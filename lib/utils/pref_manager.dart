import 'dart:convert';

import 'package:camel_up/utils/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  static const _TEAM_MEMBERS = "TEAM_MEMBERS";
  static const _IDEA_DETAILS = "IDEA_DETAILS";
  static const _POST_DETAILS = "POST_DETAILS";
  static const _AUDIENCE_DETAILS = "AUDIENCE_DETAILS";
  static const _POST_PRIVACY_DETAILS = "POST_PRIVACY_DETAILS";
  static const _PRIVACY_LIST = "PRIVACY_LIST";
  static const _POST_PRIVACY_LIST = "POST_PRIVACY_LIST";

  static saveTeamMember({@required String email, @required String role}) async{
    final prefs = await SharedPreferences.getInstance();
    final Map<String, String> newMember = {
        "email" : email,
        "role" : role
      };

    try{
      if(prefs.containsKey(_TEAM_MEMBERS)){
        String currentTeamMembers = prefs.getString(_TEAM_MEMBERS);       
        final list = List<Map<String, dynamic>>.from(json.decode(currentTeamMembers));
        list.add(newMember);
        final String encodedString = json.encode(list); 
        prefs.setString(_TEAM_MEMBERS, encodedString);
      }else{
        final List<Map<String, dynamic>> list = []..add(newMember);
        final String encodedString = json.encode(list); 
        prefs.setString(_TEAM_MEMBERS, encodedString);
      }
    }catch(error){
      print("Save TmMember Prefs ERROR: $error");
    }
  }

  static Future<List<Map<String, dynamic>>> getTeamMembers() async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(_TEAM_MEMBERS)){
      final membersString = prefs.getString(_TEAM_MEMBERS);
      final membersList = List<Map<String, dynamic>>.from(json.decode(membersString));
      return membersList;
    }else{
      return [];
    }
  }

  static clearTeamMembers() {
    SharedPreferences.getInstance().then((prefs) => prefs.remove(_TEAM_MEMBERS));
  }

  static saveIdeaDetails({@required List<String> keywords, 
    @required String title, @required String text}){

      Map<String, dynamic> details = {
        PrefKeys.KEYWORDS : keywords,
        PrefKeys.TITLE : title,
        PrefKeys.TEXT : text
      };

      String encodedString = json.encode(details);
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString(_IDEA_DETAILS, encodedString);
      });
  }

  static savePostDetails({@required List<String> keywords, 
    @required String title, @required String text}){

      Map<String, dynamic> details = {
        PrefKeys.KEYWORDS : keywords,
        PrefKeys.TITLE : title,
        PrefKeys.TEXT : text
      };

      String encodedString = json.encode(details);
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString(_POST_DETAILS, encodedString);
      });
  }

  static Future<Map<String, dynamic>> getPostDetails() async{
    final prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey(_POST_DETAILS)){
      final savedDetails = prefs.getString(_POST_DETAILS);
      final details = Map<String, dynamic>.from(json.decode(savedDetails));
      return details;
    }
    return {};
  }

  static Future<Map<String, dynamic>> getIdeaDetails() async{
    final prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey(_IDEA_DETAILS)){
      final savedDetails = prefs.getString(_IDEA_DETAILS);
      final details = Map<String, dynamic>.from(json.decode(savedDetails));
      return details;
    }
    return {};
  }

  static clearIdeaDetails(){
    SharedPreferences.getInstance().then((prefs) => prefs.remove(_IDEA_DETAILS));
  }

  static clearPostDetails(){
    SharedPreferences.getInstance().then((prefs) => prefs.remove(_POST_DETAILS));
  }

  static saveAudienceDetails({List<String> teamKeywords, 
      @required String privacy, List<String> privacyList}) {
      
      Map<String, dynamic> audienceDetails = {
        PrefKeys.TEAMMATE_KEYWRODS : teamKeywords ?? [],
        PrefKeys.PRIVACY : privacy,
        PrefKeys.PRIVACY_LIST : privacyList ?? []
      };

      String encodedString = json.encode(audienceDetails);
      SharedPreferences.getInstance()
      .then((prefs){
        prefs.setString(_AUDIENCE_DETAILS, encodedString);
      });
  }

  static savePostPrivacyDetails({ 
      @required String privacy, List<String> privacyList}) {
      
      Map<String, dynamic> audienceDetails = {
        PrefKeys.PRIVACY : privacy,
        PrefKeys.PRIVACY_LIST : privacyList ?? []
      };

      String encodedString = json.encode(audienceDetails);
      SharedPreferences.getInstance()
      .then((prefs){
        prefs.setString(_POST_PRIVACY_DETAILS, encodedString);
      });
  }

   static Future<Map<String, dynamic>> getPostPrivacyDetails() async{
    final prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey(_POST_PRIVACY_DETAILS)){
      final savedDetails = prefs.getString(_POST_PRIVACY_DETAILS);
      final details = Map<String, dynamic>.from(json.decode(savedDetails));
      return details;
    }
    return {};
  }

  static Future<Map<String, dynamic>> getAudienceDetails() async{
    final prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey(_AUDIENCE_DETAILS)){
      final savedDetails = prefs.getString(_AUDIENCE_DETAILS);
      final details = Map<String, dynamic>.from(json.decode(savedDetails));
      return details;
    }
    return {};
  }

  static clearAudienceDetails(){
    SharedPreferences.getInstance().then((prefs) => 
      prefs.remove(_AUDIENCE_DETAILS)
    );
  }

  static Future<bool> savePrivacyList(String privacyMember) async{
    final prefs = await SharedPreferences.getInstance();
    String encodedString;
  
    if(prefs.containsKey(_PRIVACY_LIST)){
      final savedList = prefs.getString(_PRIVACY_LIST);
      final list = List<dynamic>.from(json.decode(savedList));
      list.add(privacyMember);
      encodedString = json.encode(list);
    }else{
      final list = List<String>();
      list.add(privacyMember);
      encodedString = json.encode(list);
    }
    return prefs.setString(_PRIVACY_LIST, encodedString);
  }

  static Future<bool> savePostPrivacyList(String privacyMember) async{
    final prefs = await SharedPreferences.getInstance();
    String encodedString;
  
    if(prefs.containsKey(_POST_PRIVACY_LIST)){
      final savedList = prefs.getString(_POST_PRIVACY_LIST);
      final list = List<dynamic>.from(json.decode(savedList));
      list.add(privacyMember);
      encodedString = json.encode(list);
    }else{
      final list = List<String>();
      list.add(privacyMember);
      encodedString = json.encode(list);
    }
    return prefs.setString(_POST_PRIVACY_LIST, encodedString);
  }

  static Future<List<dynamic>> getPrivacyList() async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(_PRIVACY_LIST)){
      final decodedList = List<dynamic>.from(json.decode(prefs.getString(_PRIVACY_LIST)));
      return decodedList;
    }
    return [];
  }

  static Future<List<dynamic>> getPostPrivacyList() async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(_POST_PRIVACY_LIST)){
      final decodedList = List<dynamic>.from(json.decode(prefs.getString(_POST_PRIVACY_LIST)));
      return decodedList;
    }
    return [];
  }

  static clearPost(){
    SharedPreferences.getInstance()
    .then((prefs){
      prefs.remove(_POST_DETAILS);
      prefs.remove(_POST_PRIVACY_LIST);
    });
  }

  static clearIdea(){
    SharedPreferences.getInstance()
    .then((prefs){
      prefs.remove(_AUDIENCE_DETAILS);
      prefs.remove(_IDEA_DETAILS);
      prefs.remove(_PRIVACY_LIST);
      prefs.remove(_TEAM_MEMBERS);
    });
  }
}

