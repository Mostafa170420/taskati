import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/extentions/navigation.dart';
import '../../../core/services/local_storage.dart';
import '../../../core/utils/app_colors.dart';

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
            // pushTo(context, ProfileScreen()).then((value) => setState(() {}));
          },
          child: CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primaryColor,
            child: CircleAvatar(
              radius: 22,
              backgroundImage: LocalHelper.getData(LocalHelper.kImage) != null
                  ? FileImage(File(LocalHelper.getData(LocalHelper.kImage)))
                  : AssetImage('assets/images/user.png'),
            ),
          ),
        ),
      ],
    );
  }
}
