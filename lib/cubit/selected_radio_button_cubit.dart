import 'package:bloc/bloc.dart';
import 'package:camel_up/utils/constants.dart';
import 'package:equatable/equatable.dart';

part 'selected_radio_button_state.dart';

class SelectedRadioButtonCubit extends Cubit<SelectedRadioButtonState> {
  SelectedRadioButtonCubit() : super(SelectedRadioButtonEveryone());

  everyoneSelected(){
    emit(SelectedRadioButtonEveryone());
  }

  noOneSelected(){
    emit(SelectedRadioButtonNoOne());
  }

  selection(){
    emit(SelectedRadioButtonSelection());
  }
}
