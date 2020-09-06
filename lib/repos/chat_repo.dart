import 'package:camel_up/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessageRepo {
  // final _firestore = Firestore.instance;
  final _chatsCollectionRef = FirebaseFirestore.instance.collection("chats");

  Future<void> postChatMessage(ChatMessage chatMessage) async{
    final currentUserEmail = chatMessage.senderEmail;
    await _chatsCollectionRef.doc(currentUserEmail)
    .collection(chatMessage.receiverEmail).doc(chatMessage.id).set(chatMessage.toMap());
    _chatsCollectionRef.doc(currentUserEmail).collection("last_sent_messages")
    .doc(chatMessage.receiverEmail).set(chatMessage.toMap());
  }

  Stream<QuerySnapshot> getConversationAsStream({@required String currentUserEmail, 
        @required String receiverEmail}){

    return _chatsCollectionRef.doc(currentUserEmail)
                              .collection(receiverEmail)
                              .orderBy("timestamp", descending: true)
                              .snapshots();

  }

  Stream<QuerySnapshot> getUserLastSentMessagesAsStream({@required String userEmail}){
    return _chatsCollectionRef.doc(userEmail).collection("last_sent_messages")
                  .orderBy("timestamp", descending: true)
                  .snapshots();
  }
}