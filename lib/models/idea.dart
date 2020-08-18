class Idea {
  String id;
  List<String> team;
  List<String> ideaKeywords;
  List<String> teammateKeywords;
  String title;
  String text;
  String audio;
  String video;
  bool lookinForTeamates;
  String privacy;

  Idea({this.id, this.team, this.ideaKeywords, 
  this.teammateKeywords, this.title, 
  this.text, this.audio, this.video ,
  this.lookinForTeamates, this.privacy});

  factory Idea.fromMap(Map<String, dynamic> map){
   return Idea(
     id: map["id"],
     team: List<String>.from(map["team"]),
     ideaKeywords: List<String>.from(map["ideaKeywords"]),
     teammateKeywords: List<String>.from(map["teammateKeywords"]),
     title: map["title"],
     text: map["text"],
     audio: map["audio"] ?? "",
     video: map["video"] ?? "",
     lookinForTeamates: map["lookingForTeammates"].toString() == "true",
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
      "lookingForTeammates" : lookinForTeamates,
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
    lookinForTeamates =  false;
    privacy = "";
  }
}