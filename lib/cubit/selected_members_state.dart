part of 'selected_members_cubit.dart';

abstract class SelectedMembersState extends Equatable {
  const SelectedMembersState();
}

class SelectedMembersInitial extends SelectedMembersState {
  const SelectedMembersInitial();

  @override
  List<Object> get props => [];
}

class SelectedMembersDone extends SelectedMembersState {
  const SelectedMembersDone();
  @override
  List<Object> get props => [];
}
