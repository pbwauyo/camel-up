part of 'need_teammates_cubit.dart';

abstract class NeedTeammatesState extends Equatable {
  const NeedTeammatesState();
}

class NeedTeammatesFalse extends NeedTeammatesState {
  const NeedTeammatesFalse();
  @override
  List<Object> get props => [];
}

class NeedTeammatesTrue extends NeedTeammatesState{
  const NeedTeammatesTrue();
  @override
  List<Object> get props => [];
}