import 'package:bloc/bloc.dart';
import 'package:camel_up/models/profile.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'privacy_members_state.dart';

class PrivacyMembersCubit extends Cubit<PrivacyMembersState> {
  final UserRepo userRepo;

  PrivacyMembersCubit(this.userRepo) : super(PrivacyMembersInitial());

  final _userStreamController = BehaviorSubject<List<String>>();
  get usersStream => _userStreamController;

  Future updatePrivacyListStream(List<dynamic> list) async{ 
    _userStreamController.add(List<String>.from(list));
    emit(PrivacyMembersLoaded());
  }

  reset(){
    emit(PrivacyMembersInitial());
  }
}
