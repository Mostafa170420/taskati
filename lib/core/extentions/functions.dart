import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/features/upload_info/cubit/upload_cubit.dart';

pickImage(context, {required bool isCamera}) async {
  var picker = await ImagePicker().pickImage(
    source: isCamera ? ImageSource.camera : ImageSource.gallery,
  );
  BlocProvider.of<UploadCubit>(context).uploadData(picker?.path);
}
