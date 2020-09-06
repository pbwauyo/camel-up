import 'package:camel_up/models/idea.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:camel_up/utils/pref_keys.dart';
import 'package:camel_up/utils/pref_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IdeaRepo {
  final _firestore = FirebaseFirestore.instance;
  final _userRepo  =UserRepo();

  Future<void> saveIdeaToFirestore() async{
    final docReference = _firestore.collection("ideas").doc();
    final ideaDetails = await PrefManager.getIdeaDetails();
    final audienceDetails = await PrefManager.getAudienceDetails();
    final profile = await _userRepo.getCurrentUserProfile();
    
    final id = docReference.id;
    final title = ideaDetails[PrefKeys.TITLE];
    final text = ideaDetails[PrefKeys.TEXT];
    final ideaKeyWords = ideaDetails[PrefKeys.KEYWORDS]?.cast<String>() ?? [];
    final teamMembers = await PrefManager.getTeamMembers();
    final teammateKeywords = audienceDetails[PrefKeys.TEAMMATE_KEYWRODS]?.cast<String>() ?? [];
    final privacy = audienceDetails[PrefKeys.PRIVACY];
    final privacyList = audienceDetails[PrefKeys.PRIVACY_LIST]?.cast<String>() ?? [];

    teamMembers.insert(0,{
      "email": profile.email,
      "role" : "Chief Executive Officer"
    });

    final List<String> simplifiedTeam = teamMembers.map((member) => member["email"].toString()).toList();

    final idea = Idea(
      id: id,
      team: teamMembers,
      ideaKeywords: ideaKeyWords,
      teammateKeywords: teammateKeywords,
      title: title,
      text: text,
      privacy: privacy,
      privacyList: privacyList,
      profileEmail: profile.email,
      profileImage: profile.profileImage,
      profileName: "${profile.firstName} ${profile.lastName}",
      simplifiedTeam: simplifiedTeam
    );

    return docReference.set(idea.toMap());
  }

  Future<List<Idea>> getAllIdeas() async{
    final snapshot = await _firestore.collection("ideas").get();
    final ideaList = snapshot.docs.map(
                      (doc) => Idea.fromMap(doc.data())
                     ).toList();
    return ideaList;                 
  }

  Future<List<Idea>> getAllIdeasForUser(String email) async{
    final snapshot = await _firestore.collection("ideas")
                                .where("simplifiedTeam", arrayContains: email)
                                .get();
    final ideaList = snapshot.docs.map(
                      (doc) => Idea.fromMap(doc.data())
                     ).toList();
    return ideaList;                 
  }

  Future<Idea> getIdeaById(String id) async{
    final docSnapshot = await _firestore.collection("ideas")
                                        .doc(id).get();
   
    return Idea.fromMap(docSnapshot.data());
  }

  Future<Idea> getFirstUserIdea(String email) async{
    final querySnapshot = await _firestore.collection("ideas")
                                    .where("simplifiedTeam", arrayContains: email)
                                    .limit(1)
                                    .get();
                                    
    if(querySnapshot.docs.length > 0){
      final docSnapshot = querySnapshot.docs[0];   
      return Idea.fromMap(docSnapshot.data());  
    } 
    else {
      return Idea();
    }          
  }

  Future<void> toggleLikeIdea(String id) async{
    final snapshot = await _firestore.collection("ideas").doc(id).get();
    final idea = Idea.fromMap(snapshot.data());

    if(idea.liked){
      await _firestore.collection("ideas").doc(id)
              .set({"liked" : "false"}, SetOptions(merge: true));
      await updateLikesCount(ideaId: id, increment: false);
    }
    else {
      await _firestore.collection("ideas").doc(id)
              .set({"liked" : "true"}, SetOptions(merge: true));
      await updateLikesCount(ideaId: id, increment: true);
    }
  }

  Future<String> getCommentsCount(String id) async{
    final ref = _firestore.collection("ideas").doc(id);
    final snapshot = await ref.get();
    final idea = Idea.fromMap(snapshot.data());
    return idea.commentsCount;
  }

  Future<String> getIdeaEvaluation({@required String evaluatorEmail, @required String ideaId}) async{
    final snapshot = await _firestore.collection("evaluations")
                .where("evaluatorEmail", isEqualTo: evaluatorEmail)
                .where("ideaId", isEqualTo: ideaId)
                .get();
    final docs = snapshot.docs;
    return docs[0].data()["evaluation"].toString();
  }

  Future<String> getIdeaAverageEvaluation({@required String ideaId}) async{
    final snapshot = await _firestore.collection("ideas").doc(ideaId).get();
    return (snapshot.data()["averageEvaluation"]?.toString() ?? "0.0");
  }

  Future<void> updateIdeaAverageEvaluation({@required String ideaId, @required String evaluation}) async{
    final ref = _firestore.collection("ideas").doc(ideaId);
    final currentEvaluation = double.parse(await getIdeaAverageEvaluation(ideaId: ideaId));
    final int evalutationCount = await getCurrentEvaluationCount(ideaId);
    final newEvaluation = ((currentEvaluation+(double.parse(evaluation)))/evalutationCount).round();
    await ref.set({
      "averageEvaluation" : newEvaluation.toString()
    }, SetOptions(merge: true));
  }

  Future<void> updateIdeaEvaluationCount({@required String ideaId}) async{
    final snapshot = await _firestore.collection("ideas").doc(ideaId).get();
    final currentEvaluationCount = int.parse((snapshot.data()["evaluationCount"])?.toString() ?? "0");
    await _firestore.collection("ideas").doc(ideaId).set({
      "evaluationCount" : (currentEvaluationCount+1)
    }, SetOptions(merge: true));
  }

  Future<int> getCurrentEvaluationCount(String ideaId) async {
    final snapshot = await _firestore.collection("ideas").doc(ideaId).get();
    return int.parse(snapshot.data()["evaluationCount"]?.toString() ?? "0");
  }

  Future<void> updateIdeaEvaluation({@required String evaluatorEmail, 
        @required String ideaId, @required String evaluation}) async{

    final ref = _firestore.collection("evaluations");
    final snapshot = await ref.where("evaluatorEmail", isEqualTo: evaluatorEmail)
                .where("ideaId", isEqualTo: ideaId)
                .get();

    final docs = snapshot?.docs;
    if(docs != null && docs.length >= 1) { //if already exists
      docs[0].reference.set({
        "evaluation" : evaluation
      }, SetOptions(merge: true));

      print("Ref exists");
    }else {  //else
      print("Ref does not exist");
      ref.add({
        "evaluatorEmail" : evaluatorEmail,
        "ideaId" : ideaId,
        "evaluation" : evaluation
      });
      await updateIdeaEvaluationCount(ideaId: ideaId);
    }
    
    updateIdeaAverageEvaluation(ideaId: ideaId, evaluation: evaluation);
  }

  Future<void> updateCommentCount({@required String ideaId, @required bool increment}) async{
    final ref = _firestore.collection("ideas").doc(ideaId);
    final snapshot = await ref.get();
    final idea = Idea.fromMap(snapshot.data());
    final int currentCount = int.parse(idea.commentsCount);
    if(increment){
      await ref.set({"commentsCount" : (currentCount+1).toString()}, SetOptions(merge: true));
    }else{
      await ref.set({"commentsCount" : (currentCount-1).toString()}, SetOptions(merge: true));
    }
  }

  Future<void> updateLikesCount({@required String ideaId, @required bool increment}) async{
    final ref = _firestore.collection("ideas").doc(ideaId);
    final snapshot = await ref.get();
    final idea = Idea.fromMap(snapshot.data());
    final int currentCount = int.parse(idea.likesCount);
    if(increment){
      await ref.set({"likesCount" : (currentCount+1).toString()}, SetOptions(merge: true));
    }else{
      await ref.set({"likesCount" : (currentCount-1).toString()}, SetOptions(merge: true));
    }  
  }

  Future<String> getLikesCount(String id) async{
    final ref = _firestore.collection("ideas").doc(id);
    final snapshot = await ref.get();
    final idea = Idea.fromMap(snapshot.data());
    return idea.likesCount;
  }

  Future<bool> getIdeaLikeStatus(String id) async{
    final snapshot = await _firestore.collection("ideas").doc(id).get();
    final idea = Idea.fromMap(snapshot.data());
    return idea.liked;
  }
}