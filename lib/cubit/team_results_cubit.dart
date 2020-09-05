import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camel_up/models/profile.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

part 'team_results_state.dart';

class TeamResultsCubit extends Cubit<TeamResultsState> {

  final UserRepo userRepo;

  TeamResultsCubit({@required this.userRepo}) : super(TeamResultsInitial());

  final  _usersStreamController = BehaviorSubject<List<Profile>>();

  get usersStream => _usersStreamController;

  fetchUsersByKeyword(String keyword) async{
    emit(TeamResultsLoading());
    
    try{
      final List<Profile> list = [];
      final querySnapshot = await userRepo.getUserProfiles();
      final documents = querySnapshot.docs;
      documents.forEach((document) {
        final profile = Profile.fromMap(document.data());
        if(theresAMatch(profile, keyword)){
          print("Added Profile: $profile");
          list.add(profile);
        } 
      });
      print("List: ${list.length}");
      _usersStreamController.add(list);
      emit(TeamResultsLoaded());

    }catch(error){
      print("Error: ${error.message}");
      emit(TeamResultsLoaded());
      emit(TeamResultsError(error: "${error.message}"));
    }
  }

  resetState(){
    emit(TeamResultsInitial());
  }

}
