import 'package:camel_up/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessageRepo {
  // final _firestore = Firestore.instance;
  final _chatsCollectionRef = Firestore.instance.collection("chats");

  Future<void> postChatMessage(ChatMessage chatMessage) async{
    await _chatsCollectionRef.document(chatMessage.id).setData(chatMessage.toMap());
  }

  Stream<QuerySnapshot> getSenderChatsAsStream({@required String currentUserEmail, 
        @required String receiverEmail}){

    return _chatsCollectionRef.where("senderEmail", isEqualTo: currentUserEmail)
                              .where("receiverEmail", isEqualTo: receiverEmail)
                              .orderBy("timestamp")
                              .snapshots();
  }

  Stream<QuerySnapshot> getAllUserChatsAsStream({@required String userEmail}){

    return _chatsCollectionRef.where("senderEmail", isEqualTo: userEmail)
                              .orderBy("timestamp")
                              .snapshots();
  }
}