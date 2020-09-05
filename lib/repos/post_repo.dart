import 'package:camel_up/models/post.dart';
import 'package:camel_up/utils/pref_keys.dart';
import 'package:camel_up/utils/pref_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostRepo {
  final _firestore = FirebaseFirestore.instance;

  Future<void> savePostToFirestore() async{
    final docReference = _firestore.collection("posts").doc();
    final postDetails = await PrefManager.getPostDetails();
    final postPrivacyDetails = await PrefManager.getPostPrivacyDetails();
    
    final id = docReference.id;
    final title = postDetails[PrefKeys.TITLE];
    final text = postDetails[PrefKeys.TEXT];
    final postKeyWords = postDetails[PrefKeys.KEYWORDS]?.cast<String>() ?? [];
    final privacy = postPrivacyDetails[PrefKeys.PRIVACY];
    final privacyList = postPrivacyDetails[PrefKeys.PRIVACY_LIST]?.cast<String>() ?? [];

    final post = Post(
      id: id,
      postKeywords: postKeyWords,
      title: title,
      text: text,
      privacy: privacy,
      privacyList: privacyList
    );

    return docReference.set(post.toMap(), SetOptions(merge: true));
  }

  Future<List<Post>> getAllPosts() async{
    final snapshot = await _firestore.collection("posts").get();
    final postsList = snapshot.docs.map(
                      (doc) => Post.fromMap(doc.data())
                     ).toList();
    return postsList;                 
  }

  Future<List<Post>> getAllPostsForUser(String email) async{
    final snapshot = await _firestore.collection("posts")
                                .where("email", isEqualTo: email)
                                .get();
    final postsList = snapshot.docs.map(
                      (doc) => Post.fromMap(doc.data())
                     ).toList();
    return postsList;                 
  }

  Future<Post> getPostById(String id) async{
    final docSnapshot = await _firestore.collection("posts")
                                        .doc(id).get();
   
    return Post.fromMap(docSnapshot.data());
  }

  Future<Post> getFirstUserPost(String email) async{
    final querySnapshot = await _firestore.collection("Post")
                                    .where("email", isEqualTo: email)
                                    .limit(1)
                                    .get();
                                    
    if(querySnapshot.docs.length > 0){
      final docSnapshot = querySnapshot.docs[0];   
      return Post.fromMap(docSnapshot.data());  
    } 
    else {
      return Post();
    }          
  }

  Future<void> toggleLikePost(String id) async{
    final snapshot = await _firestore.collection("posts").doc(id).get();
    final post = Post.fromMap(snapshot.data());

    if(post.liked){
      await _firestore.collection("posts").doc(id)
              .set({"liked" : "false"}, SetOptions(merge: true));
      await updateLikesCount(postId: id, increment: false);
    }
    else {
      await _firestore.collection("posts").doc(id)
              .set({"liked" : "true"}, SetOptions(merge: true));
      await updateLikesCount(postId: id, increment: true);
    }
  }

  Future<String> getCommentsCount(String id) async{
    final ref = _firestore.collection("posts").doc(id);
    final snapshot = await ref.get();
    final post = Post.fromMap(snapshot.data());
    return post.commentsCount;
  }

  Future<String> getPostEvaluation({@required String evaluatorEmail, @required String postId}) async{
    final snapshot = await _firestore.collection("post_evaluations")
                .where("evaluatorEmail", isEqualTo: evaluatorEmail)
                .where("postId", isEqualTo: postId)
                .get();
    final docs = snapshot.docs;
    return docs[0].data()["evaluation"].toString();
  }

  Future<String> getPostAverageEvaluation({@required String postId}) async{
    final snapshot = await _firestore.collection("posts").doc(postId).get();
    return snapshot.data()["averageEvaluation"].toString();
  }

  Future<void> updatePostAverageEvaluation({@required String postId, @required String evaluation}) async{
    final ref = _firestore.collection("posts").doc(postId);
    final currentEvaluation = double.parse(await getPostAverageEvaluation(postId: postId));
    final int evalutationCount = await getCurrentEvaluationCount(postId);
    final newEvaluation = (currentEvaluation+(double.parse(evaluation)))/evalutationCount;
    await ref.set({
      "evaluation" : newEvaluation.toString()
    }, SetOptions(merge: true));
  }

  Future<void> updatePostEvaluationCount({@required String postId}) async{
    final snapshot = await _firestore.collection("posts").doc(postId).get();
    final currentEvaluationCount = int.parse(snapshot.data()["evaluationCount"]);
    await _firestore.collection("posts").doc(postId).set({
      "evaluationCount" : (currentEvaluationCount+1)
    }, SetOptions(merge: true));
  }

  Future<int> getCurrentEvaluationCount(String postId) async{
    final snapshot = await _firestore.collection("posts").doc(postId).get();
    return int.parse(snapshot.data()["evaluationCount"]);
  }

  Future<void> savePostEvaluation({@required String evaluatorEmail, 
        @required String postId, @required String evaluation}) async{
    final ref = _firestore.collection("evaluations");
    final snapshot = await ref.where("evaluatorEmail", isEqualTo: evaluatorEmail)
                .where("postId", isEqualTo: postId)
                .get();

    final docs = snapshot.docs;
    if(docs.length >= 1) { //if already exists
      docs[0].reference.set({
        "evaluation" : evaluation
      }, SetOptions(merge: true));
    }else {  //else
      ref.add({
        "evaluatorEmail" : evaluatorEmail,
        "postId" : postId,
        "evaluation" : evaluation
      });
    }
    updatePostEvaluationCount(postId: postId);
    updatePostAverageEvaluation(postId: postId, evaluation: evaluation);
  }

  Future<void> updateCommentCount({@required String postId, @required bool increment}) async{
    final ref = _firestore.collection("posts").doc(postId);
    final snapshot = await ref.get();
    final post = Post.fromMap(snapshot.data());
    final int currentCount = int.parse(post.commentsCount);
    if(increment){
      await ref.set({"commentsCount" : (currentCount+1).toString()}, SetOptions(merge: true));
    }else{
      await ref.set({"commentsCount" : (currentCount-1).toString()}, SetOptions(merge: true));
    }
  }

  Future<void> updateLikesCount({@required String postId, @required bool increment}) async{
    final ref = _firestore.collection("posts").document(postId);
    final snapshot = await ref.get();
    final idea = Post.fromMap(snapshot.data());
    final int currentCount = int.parse(idea.likesCount);
    if(increment){
      await ref.set({"likesCount" : (currentCount+1).toString()}, SetOptions(merge: true));
    }else{
      await ref.set({"likesCount" : (currentCount-1).toString()}, SetOptions(merge: true));
    }  
  }

  Future<String> getLikesCount(String id) async{
    final ref = _firestore.collection("posts").doc(id);
    final snapshot = await ref.get();
    final post = Post.fromMap(snapshot.data());
    return post.likesCount;
  }

  Future<bool> getPostLikeStatus(String id) async{
    final snapshot = await _firestore.collection("posts").doc(id).get();
    final post = Post.fromMap(snapshot.data());
    return post.liked;
  }
}