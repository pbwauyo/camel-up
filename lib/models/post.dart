import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  List<String> postKeywords;
  String title;
  String text;
  String audio;
  String video;
  List<String> privacyList;
  String privacy;
  String timestamp;
  String commentsCount;
  String likesCount;
  bool liked;
  String averageEvaluation;

  Post({this.id, this.postKeywords, 
  this.title, 
  this.text, this.audio, this.video ,
  this.privacyList, this.privacy, this.timestamp, this.commentsCount, 
  this.likesCount, this.liked, this.averageEvaluation});

  factory Post.fromMap(Map<String, dynamic> map){
   return Post(
     id: map["id"] ?? "",
     postKeywords: List<String>.from(map["ideaKeywords"] ?? []),
     title: map["title"] ?? "",
     text: map["text"] ?? "",
     audio: map["audio"] ?? "",
     video: map["video"] ?? "",
     privacyList: List<String>.from(map["privacyList"]) ?? [],
     privacy: map["privacy"] ?? "",
     timestamp: map["timestamp"] ?? "",
     commentsCount: map["commentsCount"] ?? "0",
     likesCount: map["likesCount"] ?? "0",
     liked: map["liked"].toString() == "true",
     averageEvaluation: map["averageEvaluation"] ?? "0.0"
   );                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
  }

  Map<String, dynamic> toMap(){
    return {
      "id" : id,
      "postKeywords" : postKeywords,
      "title" : title,
      "text" : text,
      "audio" : audio ?? "",
      "video" : video ?? "",
      "privacyList" : privacyList,
      "privacy" : privacy,
      "timestamp" : Timestamp.now().nanoseconds.toString()
    };
  }

  reset(){
    id = "";
    postKeywords = [];
    title = "";
    text = "";
    audio = "";
    video = "";
    privacy = "";
  }
}