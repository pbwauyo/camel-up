import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  static const _TEAM_MEMBERS = "TEAM_MEMBERS";

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
}

