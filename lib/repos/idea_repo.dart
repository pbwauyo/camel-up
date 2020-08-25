import 'package:camel_up/models/idea.dart';
import 'package:camel_up/utils/pref_keys.dart';
import 'package:camel_up/utils/pref_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IdeaRepo {
  final _firestore = Firestore.instance;

  Future<void> saveIdeaToFirestore() async{
    final docReference = _firestore.collection("ideas").document();
    final ideaDetails = await PrefManager.getIdeaDetails();
    final audienceDetails = await PrefManager.getAudienceDetails();
    
    final id = docReference.documentID;
    final title = ideaDetails[PrefKeys.TITLE];
    final text = ideaDetails[PrefKeys.TEXT];
    final ideaKeyWords = ideaDetails[PrefKeys.KEYWORDS]?.cast<String>() ?? [];
    final teamMembers = await PrefManager.getTeamMembers();
    final teammateKeywords = audienceDetails[PrefKeys.TEAMMATE_KEYWRODS]?.cast<String>() ?? [];
    final privacy = audienceDetails[PrefKeys.PRIVACY];
    final privacyList = audienceDetails[PrefKeys.PRIVACY_LIST]?.cast<String>() ?? [];

    final idea = Idea(
      id: id,
      team: teamMembers,
      ideaKeywords: ideaKeyWords,
      teammateKeywords: teammateKeywords,
      title: title,
      text: text,
      privacy: privacy,
      privacyList: privacyList
    );


    return docReference.setData(idea.toMap());
  }
}