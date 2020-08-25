import 'package:bloc/bloc.dart';
import 'package:camel_up/models/profile.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'privacy_members_state.dart';

class PrivacyMembersCubit extends Cubit<PrivacyMembersState> {
  final UserRepo userRepo;

  PrivacyMembersCubit(this.userRepo) : super(PrivacyMembersInitial());

  final _userStreamController = BehaviorSubject<List<Profile>>();
  get usersStream => _userStreamController;

  Future updatePrivacyListStream(List<dynamic> list) async{
    final profiles = List<Profile>();

    list.forEach((email) async{
      final profile = await userRepo.getUserProfile(email);
      profiles.add(profile); 
     });
    _userStreamController.add(profiles);
    emit(PrivacyMembersLoaded());
  }

  reset(){
    emit(PrivacyMembersInitial());
  }
}
