import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/components/input/custom_text_field.dart';
import 'package:taskati/core/components/input/primary_button.dart';
import 'package:taskati/core/extentions/dialogs.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/features/upload_info/cubit/upload_cubit.dart';
import 'package:taskati/features/upload_info/cubit/upload_states.dart';

import '../../../core/extentions/validator.dart';

class UploadInfoScreen extends StatelessWidget {
  UploadInfoScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final UploadCubit uploadCubit = UploadCubit();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => uploadCubit,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          actions: [
            TextButton(
              onPressed: () {
                formKey.currentState?.validate();
                uploadCubit.checkData(nameController.text);
              },
              child: Text(
                'Done',
              ),
            ),
          ],
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<UploadCubit, UploadStates>(
                  listener: (context, state) {
                    if (state is UploadFailureState) {
                      errorSnackbar(context, state.error);
                    } else if (state is UploadDoneState) {
                      pushWithReplacement(context, Scaffold());
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is UploadInitialState ||
                      current is UploadSucssessState,
                  builder: (context, state) {
                    print("State: $state");
                    if (state is UploadInitialState) {
                      return CircleAvatar(
                        radius: 70,
                        backgroundColor: Theme.of(context).primaryColor,
                        backgroundImage: AssetImage('assets/images/user.png'),
                      );
                    } else if (state is UploadSucssessState) {
                      return CircleAvatar(
                        radius: 70,
                        backgroundColor: Theme.of(context).primaryColor,
                        backgroundImage: FileImage(File(state.path)),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  text: "Upload From Camera",
                  onPressed: () {
                    pickImage(context, isCamera: true);
                  },
                  width: size.width / 1.3,
                ),
                SizedBox(
                  height: 10,
                ),
                PrimaryButton(
                  text: "Upload From Gallery",
                  onPressed: () {
                    pickImage(context, isCamera: false);
                  },
                  width: size.width / 1.3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Divider(
                    color: AppColors.greyColor.withOpacity(0.5),
                    thickness: 1.3,
                  ),
                ),
                CustomTextField(
                  hintText: "Enter your name",
                  controller: nameController,
                  validator: emptyValidator,
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  pickImage(context, {required bool isCamera}) async {
    var picker = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    uploadCubit.uploadData(picker?.path);
  }
}
