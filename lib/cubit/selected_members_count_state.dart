part of 'selected_members_count_cubit.dart';

abstract class SelectedMembersCountState extends Equatable {
  const SelectedMembersCountState();
}

class SelectedMembersCountInitial extends SelectedMembersCountState {
  const SelectedMembersCountInitial();
  @override
  List<Object> get props => [];
}

class SelectedMembersCountDone extends SelectedMembersCountState {
  final int count;
  SelectedMembersCountDone({@required this.count});
  @override
  List<Object> get props => [count];
}
