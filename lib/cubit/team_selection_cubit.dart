import 'package:bloc/bloc.dart';
import 'package:camel_up/models/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'team_selection_state.dart';

class TeamSelectionCubit extends Cubit<TeamSelectionState> {
  TeamSelectionCubit() : super(TeamSelectionInitial());

  goToSelectedMember(Profile profile){
    emit(TeamSelectionActive(profile: profile));
  }

  goToTeamSelection(){
    emit(TeamSelectionInitial());
  }
}
