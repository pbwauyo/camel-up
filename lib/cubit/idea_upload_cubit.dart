import 'package:bloc/bloc.dart';
import 'package:camel_up/cubit/privacy_members_cubit.dart';
import 'package:camel_up/cubit/selected_members_cubit.dart';
import 'package:camel_up/repos/idea_repo.dart';
import 'package:camel_up/utils/pref_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'idea_upload_state.dart';

class IdeaUploadCubit extends Cubit<IdeaUploadState> {
  final IdeaRepo ideaRepo;

  IdeaUploadCubit(this.ideaRepo) : super(IdeaUploadInitial());

  uploadIdea(BuildContext context) async{
    try{
      emit(IdeaUploadInProgress());
      await ideaRepo.saveIdeaToFirestore();
      PrefManager.clearIdea();
      context.bloc<PrivacyMembersCubit>().reset();
      context.bloc<SelectedMembersCubit>().reset();
      emit(IdeaUploadDone());
    }catch(error){
      emit(IdeaUploadError(
        message: "$error"
      ));
    }  
  }

  resetIdeaUploadState(){
    emit(IdeaUploadInitial());
  }
}
