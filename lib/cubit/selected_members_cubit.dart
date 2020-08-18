import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

part 'selected_members_state.dart';

class SelectedMembersCubit extends Cubit<SelectedMembersState> {
  SelectedMembersCubit() : super(SelectedMembersInitial());
  
  final _selectedMembersStreamController = BehaviorSubject<List<Map<String, dynamic>>>();

  get selectedMembersStream => _selectedMembersStreamController;

  initialiseMemberSelection(){
    emit(SelectedMembersInitial());
  }

  finishTeamMemberSelection(List<Map<String, dynamic>> members){
    _selectedMembersStreamController.add(members);
    emit(SelectedMembersDone());
  }
}
