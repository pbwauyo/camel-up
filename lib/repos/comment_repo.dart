import 'package:camel_up/models/comment.dart';
import 'package:camel_up/repos/idea_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentRepo {
  final _firestore = Firestore.instance;
  final _ideaRepo = IdeaRepo();

  Future<Comment> getCommentById(String id) async{
    final snapshot = await _firestore.collection("comments").document(id).get();
    return Comment.fromMap(snapshot.data);
  }

  Future<List<Comment>> getNestedComments(String parentId) async{
    final snapshot = await _firestore.collection("comments")
            .where("parentCommentId", isEqualTo: parentId)
            .getDocuments();
    final documents = snapshot.documents;
    return documents.map((doc) => Comment.fromMap(doc.data)).toList();        
  }

  Future<List<Comment>> getCommentsForIdea(String ideaId) async{
    final snapshot = await _firestore.collection("comments")
            .where("ideaId", isEqualTo: ideaId)
            .getDocuments();
    final documents = snapshot.documents;
    return documents.map((doc) => Comment.fromMap(doc.data)).toList();  
  }

  Stream<QuerySnapshot> getCommentsAsStream(String ideaId){
    return _firestore.collection("comments")
    .where("ideaId", isEqualTo: ideaId)
    .orderBy("timestamp", descending: false)
    .snapshots();
  } 

  Future<void> postComment(Comment comment) async{
    final ref = _firestore.collection("comments").document();
    comment.id = ref.documentID;
    await ref.setData(comment.toMap());
    await _ideaRepo.updateCommentCount(ideaId: comment.ideaId, increment: true);
  }

  Future<void> toggleLikeComment({String id, bool liked}) async{
    final snapshot = await _firestore.collection("comments").document(id).get();
    final comment = Comment.fromMap(snapshot.data);

    if(comment.liked){
      await _firestore.collection("comments").document(id)
      .setData({"liked" : "false"}, merge: true);
      await updateCommentLikesCount(id: id, increment: false);
    }else{
      await _firestore.collection("comments").document(id)
      .setData({"liked" : "true"}, merge: true);
      await updateCommentLikesCount(id: id, increment: true);
    }
  }

  Future<String> getCommentsCount(String id) async{

    final snapshot = await _firestore.collection("comments")
                  .where("parentCommentId", isEqualTo: id).getDocuments();
    return snapshot.documents.length.toString();
  }

  Future<String> getLikesCount(String id) async{
    final ref = _firestore.collection("comments").document(id);
    final snapshot = await ref.get();
    final comment = Comment.fromMap(snapshot.data);
    return comment.likesCount;
  }

  Future<void> updateCommentLikesCount({@required String id, @required bool increment}) async{
    final ref = _firestore.collection("comments").document(id);
    final snapshot = await ref.get();
    final comment = Comment.fromMap(snapshot.data);
    final int currentCount = int.parse(comment.likesCount);

    if(increment){
      await ref.setData({"likesCount" : (currentCount+1).toString()}, merge: true);
    }else{
      await ref.setData({"likesCount" : (currentCount-1).toString()}, merge: true);
    }  
  }

  Future<bool> getCommentLikeStatus(String id) async{
    final snapshot = await _firestore.collection("comments").document(id).get();
    final comment = Comment.fromMap(snapshot.data);
    return comment.liked;
  }
}