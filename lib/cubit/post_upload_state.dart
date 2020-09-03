part of 'post_upload_cubit.dart';

abstract class PostUploadState extends Equatable {
  const PostUploadState();

  @override
  List<Object> get props => [];
}

class PostUploadInitial extends PostUploadState {
  PostUploadInitial();
  @override
  List<Object> get props => [];
}

class PostUploadInProgress extends PostUploadState{
  @override
  List<Object> get props => [];
}

class PostUploadDone extends PostUploadState{
  @override
  List<Object> get props => [];
}

class PostUploadError extends PostUploadState{
  final String message;
  PostUploadError({@required this.message});

  @override
  List<Object> get props => [];
}