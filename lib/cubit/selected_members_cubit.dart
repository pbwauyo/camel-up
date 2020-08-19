import 'package:bloc/bloc.dart';
import 'package:camel_up/cubit/selected_members_count_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selected_members_state.dart';

class SelectedMembersCubit extends Cubit<SelectedMembersState> {
  SelectedMembersCubit() : super(SelectedMembersInitial());
  
  final _selectedMembersStreamController = BehaviorSubject<List<Map<String, dynamic>>>();

  get selectedMembersStream => _selectedMembersStreamController;

  initialiseMemberSelection(){
    emit(SelectedMembersInitial());
  }

  finishTeamMemberSelection(BuildContext context, List<Map<String, dynamic>> members){
    _selectedMembersStreamController.add(members);
    context.bloc<SelectedMembersCountCubit>().updateCount(members.length);
    emit(SelectedMembersDone());
  }
}
