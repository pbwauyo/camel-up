part of 'idea_upload_cubit.dart';

abstract class IdeaUploadState extends Equatable {
  const IdeaUploadState();
}

class IdeaUploadInitial extends IdeaUploadState {
  @override
  List<Object> get props => [];
}

class IdeaUploadInProgress extends IdeaUploadState{
  @override
  List<Object> get props => [];
}

class IdeaUploadDone extends IdeaUploadState{
  @override
  List<Object> get props => [];
}

class IdeaUploadError extends IdeaUploadState{
  final String message;
  IdeaUploadError({@required this.message});

  @override
  List<Object> get props => [];
}
