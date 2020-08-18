part of 'team_selection_cubit.dart';

abstract class TeamSelectionState extends Equatable {
  const TeamSelectionState();
}

class TeamSelectionInitial extends TeamSelectionState {
  @override
  List<Object> get props => [];
}

class TeamSelectionActive extends TeamSelectionState {
  final Profile profile;

  TeamSelectionActive({@required this.profile});
  @override
  List<Object> get props => [profile];
}
