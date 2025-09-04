import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extentions/navigation.dart';
import '../../../core/services/local_storage.dart';
import '../../../core/utils/app_colors.dart';
import '../../profile/page/profile_screen.dart';
import '../../upload_info/cubit/upload_cubit.dart';
import '../../upload_info/cubit/upload_states.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${(LocalHelper.getData(LocalHelper.kName) as String).split(' ').first}',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColors.primaryColor),
              ),
              Text('Have a Nice Day',
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            pushTo(context, ProfileScreen());
          },
          child: BlocBuilder<UploadCubit, UploadStates>(
            buildWhen: (previous, current) =>
                current is UploadInitialState || current is UploadSucssessState,
            builder: (context, state) {
              print("State: $state");
              if (state is UploadInitialState) {
                return CircleAvatar(
                  radius: 24,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                );
              } else if (state is UploadSucssessState) {
                return CircleAvatar(
                  radius: 24,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: FileImage(File(state.path)),
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
