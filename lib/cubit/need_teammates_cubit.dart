import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'need_teammates_state.dart';

class NeedTeammatesCubit extends Cubit<NeedTeammatesState> {
  NeedTeammatesCubit() : super(NeedTeammatesFalse());

  needTeammates(){
    emit(NeedTeammatesTrue());
  }

  dontNeedTeammates(){
    emit(NeedTeammatesFalse());
  }
}


