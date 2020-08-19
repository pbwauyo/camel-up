part of 'selected_radio_button_cubit.dart';

abstract class SelectedRadioButtonState extends Equatable {
  final String selectedButton;
  const SelectedRadioButtonState(this.selectedButton);
  
  @override
  List<Object> get props => [selectedButton];
}

class SelectedRadioButtonEveryone extends SelectedRadioButtonState{
  const SelectedRadioButtonEveryone() : super(RadioButtonFields.EVERYONE);
  @override
  List<Object> get props => [];
}

class SelectedRadioButtonNoOne extends SelectedRadioButtonState{
  const SelectedRadioButtonNoOne() : super(RadioButtonFields.NO_ONE);
  @override
  List<Object> get props => [];
}

class SelectedRadioButtonSelection extends SelectedRadioButtonState{
  const SelectedRadioButtonSelection() : super(RadioButtonFields.SELECTION);
  @override
  List<Object> get props => [];
}
