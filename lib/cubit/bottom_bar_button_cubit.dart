import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_bar_button_state.dart';

class BottomBarButtonCubit extends Cubit<BottomBarButtonState> {
  BottomBarButtonCubit() : super(BottomBarButtonIdeaList());

  goToIdeaList(){
    emit(BottomBarButtonIdeaList());
  }

  goToCreatePost(){
    emit(BottomBarButtonCreatePost());
  }

  goToCreateIdea(){
    emit(BottomBarButtonCreateIdea());
  }

  goToSearch(){
    emit(BottomBarButtonSearch());
  }
}
