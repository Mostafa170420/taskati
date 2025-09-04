import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/input/primary_button.dart';
import '../../../core/extentions/dialogs.dart';
import '../../../core/extentions/functions.dart';
import '../../../core/extentions/navigation.dart';
import '../../upload_info/cubit/upload_cubit.dart';
import '../../upload_info/cubit/upload_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.light_mode,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              BlocBuilder<UploadCubit, UploadStates>(
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
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PrimaryButton(
                              text: "Upload From Camera",
                              onPressed: () async {
                                await pickImage(context, isCamera: true);
                                BlocProvider.of<UploadCubit>(context).checkData(
                                    BlocProvider.of<UploadCubit>(context)
                                            .name ??
                                        '');
                                Navigator.of(context).pop();
                              },
                              width: size.width / 1.3,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            PrimaryButton(
                              text: "Upload From Gallery",
                              onPressed: () async {
                                await pickImage(context, isCamera: false);
                                BlocProvider.of<UploadCubit>(context).checkData(
                                    BlocProvider.of<UploadCubit>(context)
                                            .name ??
                                        '');
                                Navigator.of(context).pop();
                              },
                              width: size.width / 1.3,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
