import 'package:camel_up/models/idea.dart';
import 'package:camel_up/utils/pref_keys.dart';
import 'package:camel_up/utils/pref_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IdeaRepo {
  final _firestore = Firestore.instance;

  Future<void> saveIdeaToFirestore() async{
    final docReference = _firestore.collection("ideas").document();
    final ideaDetails = await PrefManager.getIdeaDetails();
    final audienceDetails = await PrefManager.getAudienceDetails();
    
    final id = docReference.documentID;
    final title = ideaDetails[PrefKeys.TITLE];
    final text = ideaDetails[PrefKeys.TEXT];
    final ideaKeyWords = ideaDetails[PrefKeys.KEYWORDS]?.cast<String>() ?? [];
    final teamMembers = await PrefManager.getTeamMembers();
    final teammateKeywords = audienceDetails[PrefKeys.TEAMMATE_KEYWRODS]?.cast<String>() ?? [];
    final privacy = audienceDetails[PrefKeys.PRIVACY];
    final privacyList = audienceDetails[PrefKeys.PRIVACY_LIST]?.cast<String>() ?? [];

    final idea = Idea(
      id: id,
      team: teamMembers,
      ideaKeywords: ideaKeyWords,
      teammateKeywords: teammateKeywords,
      title: title,
      text: text,
      privacy: privacy,
      privacyList: privacyList
    );

    return docReference.setData(idea.toMap());
  }

  Future<List<Idea>> getAllIdeas() async{
    final snapshot = await _firestore.collection("ideas").getDocuments();
    final ideaList = snapshot.documents.map(
                      (doc) => Idea.fromMap(doc.data)
                     ).toList();
    return ideaList;                 
  }

  Future<List<Idea>> getAllIdeasForUser(String email) async{
    final snapshot = await _firestore.collection("ideas")
                                .where("email", isEqualTo: email)
                                .getDocuments();
    final ideaList = snapshot.documents.map(
                      (doc) => Idea.fromMap(doc.data)
                     ).toList();
    return ideaList;                 
  }

  Future<Idea> getIdeaById(String id) async{
    final docSnapshot = await _firestore.collection("ideas")
                                        .document(id).get();
   
    return Idea.fromMap(docSnapshot.data);
  }

  Future<Idea> getFirstUserIdea(String email) async{
    final querySnapshot = await _firestore.collection("ideas")
                                    .where("email", isEqualTo: email)
                                    .limit(1)
                                    .getDocuments();
                                    
    if(querySnapshot.documents.length > 0){
      final docSnapshot = querySnapshot.documents[0];   
      return Idea.fromMap(docSnapshot.data);  
    } 
    else {
      return Idea();
    }          
  }

  Future<void> toggleLikeIdea(String id) async{
    final snapshot = await _firestore.collection("ideas").document(id).get();
    final idea = Idea.fromMap(snapshot.data);

    if(idea.liked){
      await _firestore.collection("ideas").document(id)
              .setData({"liked" : "false"}, merge: true);
      await updateLikesCount(ideaId: id, increment: false);
    }
    else {
      await _firestore.collection("ideas").document(id)
              .setData({"liked" : "true"}, merge: true);
      await updateLikesCount(ideaId: id, increment: true);
    }
  }

  Future<String> getCommentsCount(String id) async{
    final ref = _firestore.collection("ideas").document(id);
    final snapshot = await ref.get();
    final idea = Idea.fromMap(snapshot.data);
    return idea.commentsCount;
  }

  Future<String> getIdeaEvaluation({@required String evaluatorEmail, @required String ideaId}) async{
    final snapshot = await _firestore.collection("evaluations")
                .where("evaluatorEmail", isEqualTo: evaluatorEmail)
                .where("ideaId", isEqualTo: ideaId)
                .getDocuments();
    final docs = snapshot.documents;
    return docs[0]["evaluation"].toString();
  }

  Future<String> getIdeaAverageEvaluation({@required String ideaId}) async{
    final snapshot = await _firestore.collection("ideas").document(ideaId).get();
    return snapshot.data["averageEvaluation"].toString();
  }

  Future<void> updateIdeaAverageEvaluation({@required String ideaId, @required String evaluation}) async{
    final ref = _firestore.collection("ideas").document(ideaId);
    final currentEvaluation = double.parse(await getIdeaAverageEvaluation(ideaId: ideaId));
    final int evalutationCount = await getCurrentEvaluationCount(ideaId);
    final newEvaluation = (currentEvaluation+(double.parse(evaluation)))/evalutationCount;
    await ref.setData({
      "evaluation" : newEvaluation.toString()
    }, merge: true);
  }

  Future<void> updateIdeaEvaluationCount({@required String ideaId}) async{
    final snapshot = await _firestore.collection("ideas").document(ideaId).get();
    final currentEvaluationCount = int.parse(snapshot.data["evaluationCount"]);
    await _firestore.collection("ideas").document(ideaId).setData({
      "evaluationCount" : (currentEvaluationCount+1)
    }, merge: true);
  }

  Future<int> getCurrentEvaluationCount(String ideaId) async{
    final snapshot = await _firestore.collection("ideas").document(ideaId).get();
    return int.parse(snapshot.data["evaluationCount"]);
  }

  Future<void> saveIdeaEvaluation({@required String evaluatorEmail, 
        @required String ideaId, @required String evaluation}) async{
    final ref = _firestore.collection("evaluations");
    final snapshot = await ref.where("evaluatorEmail", isEqualTo: evaluatorEmail)
                .where("ideaId", isEqualTo: ideaId)
                .getDocuments();

    final docs = snapshot.documents;
    if(docs.length >= 1) { //if already exists
      docs[0].reference.setData({
        "evaluation" : evaluation
      }, merge: true);
    }else {  //else
      ref.add({
        "evaluatorEmail" : evaluatorEmail,
        "ideaId" : ideaId,
        "evaluation" : evaluation
      });
    }
    updateIdeaEvaluationCount(ideaId: ideaId);
    updateIdeaAverageEvaluation(ideaId: ideaId, evaluation: evaluation);
  }

  Future<void> updateCommentCount({@required String ideaId, @required bool increment}) async{
    final ref = _firestore.collection("ideas").document(ideaId);
    final snapshot = await ref.get();
    final idea = Idea.fromMap(snapshot.data);
    final int currentCount = int.parse(idea.commentsCount);
    if(increment){
      await ref.setData({"commentsCount" : (currentCount+1).toString()}, merge: true);
    }else{
      await ref.setData({"commentsCount" : (currentCount-1).toString()}, merge: true);
    }
  }

  Future<void> updateLikesCount({@required String ideaId, @required bool increment}) async{
    final ref = _firestore.collection("ideas").document(ideaId);
    final snapshot = await ref.get();
    final idea = Idea.fromMap(snapshot.data);
    final int currentCount = int.parse(idea.likesCount);
    if(increment){
      await ref.setData({"likesCount" : (currentCount+1).toString()}, merge: true);
    }else{
      await ref.setData({"likesCount" : (currentCount-1).toString()}, merge: true);
    }  
  }

  Future<String> getLikesCount(String id) async{
    final ref = _firestore.collection("ideas").document(id);
    final snapshot = await ref.get();
    final idea = Idea.fromMap(snapshot.data);
    return idea.likesCount;
  }

  Future<bool> getIdeaLikeStatus(String id) async{
    final snapshot = await _firestore.collection("ideas").document(id).get();
    final idea = Idea.fromMap(snapshot.data);
    return idea.liked;
  }
}