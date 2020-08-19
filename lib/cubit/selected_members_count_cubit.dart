import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'selected_members_count_state.dart';

class SelectedMembersCountCubit extends Cubit<SelectedMembersCountState> {
  SelectedMembersCountCubit() : super(SelectedMembersCountInitial());

  updateCount(int count){
    emit(SelectedMembersCountDone(count: count));
  }
}
