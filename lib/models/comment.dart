import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String commenterId;
  String ideaId;
  String text;
  String likesCount;
  String parentCommentId;
  String nestedCommentsCount;
  String timestamp;
  bool liked;
  String commenterName;
  String commenterImageUrl;

  Comment({this.id, this.commenterId, this.ideaId, this.text, this.likesCount, 
        this.parentCommentId, this.nestedCommentsCount, this.timestamp, this.liked,
        this.commenterName, this.commenterImageUrl
        });
  
  factory Comment.fromMap(Map<String, dynamic> map){
    return Comment(
      id: map["id"],
      commenterId: map["commenterId"],
      ideaId: map["ideaId"],
      text: map["text"],
      likesCount: map["likesCount"] ?? "0",
      parentCommentId: map["parentCommentId"].toString(),
      nestedCommentsCount: map["nestedCommentsCount"] ?? "0",
      timestamp: map["timestamp"] ?? "",
      liked: map["liked"].toString() == "true",
      commenterName: map["commenterName"].toString() ?? "",
      commenterImageUrl: map["commenterImageUrl"] ?? ""
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "id" : id,
      "commenterId" : commenterId,
      "ideaId" : ideaId,
      "text" : text,
      "parentCommentId" : parentCommentId,
      "timestamp" : Timestamp.now().nanoseconds.toString(),
      "liked": "false",
      "likesCount": "0",
      "nestedCommentsCount": "0",
      "commenterName" : commenterName,
      "commenterImageUrl" : commenterImageUrl
    };
  }
}