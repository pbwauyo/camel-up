import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  String id;
  String senderEmail;
  String receiverEmail;
  String senderName;
  String senderImage;
  String message;
  String timestamp;

  ChatMessage({this.id, this.senderEmail, this.receiverEmail, this.senderName, this.senderImage,
      this.message, this.timestamp
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map){
    return ChatMessage(
      id: map["id"],
      senderEmail: map["senderEmail"],
      receiverEmail: map["receiverEmail"],
      senderName: map["senderName"],
      senderImage: map["senderImage"],
      message: map["message"],
      timestamp: map["timestamp"]
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "id" : id,
      "senderEmail" : senderEmail,
      "receiverEmail" : receiverEmail,
      "senderName" : senderName,
      "senderImage" : senderImage,
      "message" : message,
      "timestamp" : Timestamp.now().nanoseconds.toString()
    };
  }

 }