import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'nav_menu_item_state.dart';

class NavMenuItemCubit extends Cubit<NavMenuItemState> {
  NavMenuItemCubit() : super(NavMenuItemInitial());

  highlightProfile(){
    emit(NavMenuItemProfile());
  }

  highlightDonate(){
    emit(NavMenuItemDonate());
  }

  highlightAbout(){
    emit(NavMenuItemAbout());
  }

  highlightHelp(){
    emit(NavMenuItemHelp());
  }

  highlightLogout(){
    emit(NavMenuItemLogout());
  }

  unHighlight(){
    emit(NavMenuItemInitial());
  }
}
