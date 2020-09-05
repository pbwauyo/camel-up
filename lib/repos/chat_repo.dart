import 'package:camel_up/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessageRepo {
  // final _firestore = Firestore.instance;
  final _chatsCollectionRef = Firestore.instance.collection("chats");

  Future<void> postChatMessage(ChatMessage chatMessage) async{
    final currentUserEmail = chatMessage.senderEmail;
    await _chatsCollectionRef.document(currentUserEmail)
    .collection(chatMessage.receiverEmail).document(chatMessage.id).setData(chatMessage.toMap());
    _chatsCollectionRef.document(currentUserEmail).collection("messages")
    .document(chatMessage.id).setData(chatMessage.toMap());
  }

  Stream<QuerySnapshot> getConversationAsStream({@required String currentUserEmail, 
        @required String receiverEmail}){

    return _chatsCollectionRef.document(currentUserEmail)
                              .collection(receiverEmail)
                              .orderBy("timestamp")
                              .snapshots();

  }

  Stream<QuerySnapshot> getAllUserChatsAsStream({@required String userEmail}){
    return _chatsCollectionRef.document(userEmail).collection("messages")
                  .orderBy("timestamp")
                  .snapshots();
  }
}