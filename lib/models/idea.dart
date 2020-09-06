import 'package:cloud_firestore/cloud_firestore.dart';

class Idea {
  String id;
  List<Map<String, dynamic>> team;
  List<String> ideaKeywords;
  List<String> teammateKeywords;
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
  String profileEmail;
  String profileName;
  String profileImage;
  List<String> simplifiedTeam;

  Idea({this.id, this.team, this.ideaKeywords, 
  this.teammateKeywords, this.title, 
  this.text, this.audio, this.video ,
  this.privacyList, this.privacy, this.timestamp, this.commentsCount, 
  this.likesCount, this.liked, this.averageEvaluation,
  this.profileEmail, this.profileName, this.profileImage, this.simplifiedTeam});

  factory Idea.fromMap(Map<String, dynamic> map){
   return Idea(
     id: map["id"] ?? "",
     team: List<Map<String, dynamic>>.from(map["team"] ?? []),
     ideaKeywords: List<String>.from(map["ideaKeywords"] ?? []),
     teammateKeywords: List<String>.from(map["teammateKeywords"] ?? []),
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
     averageEvaluation: map["averageEvaluation"] ?? "0.0",
     profileEmail: map["profileEmail"],
     profileImage: map["proifleImage"],
     profileName: map["profileName"],
   );                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
  }

  Map<String, dynamic> toMap(){
    return {
      "id" : id,
      "team" : team,
      "ideaKeywords" : ideaKeywords,
      "teammateKeywords" : teammateKeywords,
      "title" : title,
      "text" : text,
      "audio" : audio ?? "",
      "video" : video ?? "",
      "privacyList" : privacyList,
      "privacy" : privacy,
      "averageEvaluation" : averageEvaluation ?? "",
      "timestamp" : Timestamp.now().nanoseconds.toString(),
      "simplifiedTeam" : simplifiedTeam
    };
  }

  reset(){
    id = "";
    team = [];
    ideaKeywords = [];
    teammateKeywords = [];
    title = "";
    text = "";
    audio = "";
    video = "";
    privacy = "";
  }
}