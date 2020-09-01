part of 'evaluation_percentage_cubit.dart';

abstract class EvaluationPercentageState extends Equatable {
  final double percentage;
  EvaluationPercentageState(this.percentage);

  @override
  List<Object> get props => [];
}

class EvaluationPercentageInitial extends EvaluationPercentageState {
  EvaluationPercentageInitial(): super(0);

  @override
  List<Object> get props => [];
}

class EvaluationPercentageActive extends EvaluationPercentageState{
  final double percentage;

  EvaluationPercentageActive(this.percentage): super(percentage);

  @override
  List<Object> get props => [percentage];
}
