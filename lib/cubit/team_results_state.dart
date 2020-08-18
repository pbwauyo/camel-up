part of 'team_results_cubit.dart';

abstract class TeamResultsState extends Equatable {
  const TeamResultsState();
}

class TeamResultsInitial extends TeamResultsState {
  @override
  List<Object> get props => [];
}

class TeamResultsLoading extends TeamResultsState{
  @override
  List<Object> get props => [];
}

class TeamResultsLoaded extends TeamResultsState{
  @override
  List<Object> get props => [];
}

class TeamResultsError extends TeamResultsState{
  final String error;

  TeamResultsError({@required this.error});
  
  @override
  List<Object> get props => [error];
}
