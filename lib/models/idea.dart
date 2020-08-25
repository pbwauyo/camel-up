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

  Idea({this.id, this.team, this.ideaKeywords, 
  this.teammateKeywords, this.title, 
  this.text, this.audio, this.video ,
  this.privacyList, this.privacy});

  factory Idea.fromMap(Map<String, dynamic> map){
   return Idea(
     id: map["id"],
     team: List<Map<String, dynamic>>.from(map["team"] ?? []),
     ideaKeywords: List<String>.from(map["ideaKeywords"] ?? []),
     teammateKeywords: List<String>.from(map["teammateKeywords"] ?? []),
     title: map["title"],
     text: map["text"],
     audio: map["audio"] ?? "",
     video: map["video"] ?? "",
     privacyList: map["privacyList"] ?? [],
     privacy: map["privacy"]
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
      "privacy" : privacy
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