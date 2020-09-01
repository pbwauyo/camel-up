import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'evaluation_percentage_state.dart';

class EvaluationPercentageCubit extends Cubit<EvaluationPercentageState> {

  EvaluationPercentageCubit() : super(EvaluationPercentageInitial());

  setPercentage(double percentage) {
    emit(EvaluationPercentageActive(percentage));
  }

  resetPercentage() {
    emit(EvaluationPercentageInitial());
  }
}
