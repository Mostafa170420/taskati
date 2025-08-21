import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskati/features/upload_info/cubit/upload_states.dart';

class UploadCubit extends Cubit<UploadStates> {
  UploadCubit() : super(UploadInitialState());
  String? path;
  void checkData(String name) {
    if (path != null && name.isNotEmpty) {
      emit(UploadDoneState());
    } else if (path != null && name.isEmpty) {
      emit(UploadFailureState("Please enter your name"));
    } else if (path == null && name.isNotEmpty) {
      emit(UploadFailureState("Please upload your profile image"));
    } else {
      emit(UploadFailureState(
          "Please enter your name and upload your profile imagee"));
    }
  }

  void uploadData(
    String? filePath,
  ) {
    if (filePath != null) {
      path = filePath;
      emit(UploadSucssessState(path: filePath));
    } else {
      emit(UploadFailureState("Upload failed. Please check your inputs."));
    }
  }
}
