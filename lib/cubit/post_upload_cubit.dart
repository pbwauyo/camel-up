import 'package:bloc/bloc.dart';
import 'package:camel_up/cubit/privacy_members_cubit.dart';
import 'package:camel_up/repos/idea_repo.dart';
import 'package:camel_up/repos/post_repo.dart';
import 'package:camel_up/utils/pref_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_upload_state.dart';

class PostUploadCubit extends Cubit<PostUploadState> {
  final PostRepo postRepo;

  PostUploadCubit(this.postRepo) : super(PostUploadInitial());

  uploadPost(BuildContext context) async{
    try{
      emit(PostUploadInProgress());
      await postRepo.savePostToFirestore();
      PrefManager.clearPost();
      context.bloc<PrivacyMembersCubit>().reset();
      emit(PostUploadDone());
    }catch(error){
      emit(PostUploadError(
        message: "$error"
      ));
    }  
  }

  resetPostUploadState(){
    emit(PostUploadInitial());
  }

}
