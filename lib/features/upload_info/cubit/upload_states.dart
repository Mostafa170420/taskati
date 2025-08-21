class UploadStates {}

class UploadInitialState extends UploadStates {}

class UploadDoneState extends UploadStates {}

class UploadSucssessState extends UploadStates {
  String path;
  UploadSucssessState({required this.path});
}

class UploadFailureState extends UploadStates {
  final String error;

  UploadFailureState(this.error);
}
