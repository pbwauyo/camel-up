part of 'nav_menu_item_cubit.dart';

abstract class NavMenuItemState extends Equatable {
  const NavMenuItemState();

  @override
  List<Object> get props => [];
}

class NavMenuItemInitial extends NavMenuItemState {}

class NavMenuItemProfile extends NavMenuItemState {}

class NavMenuItemDonate extends NavMenuItemState {}

class NavMenuItemAbout extends NavMenuItemState {}

class NavMenuItemHelp extends NavMenuItemState {}

class NavMenuItemLogout extends NavMenuItemState {}

class NavMenuItemChats extends NavMenuItemState {}
