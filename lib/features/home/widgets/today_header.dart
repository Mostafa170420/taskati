import 'package:flutter/material.dart';
import 'package:taskati/core/components/input/primary_button.dart';
import 'package:intl/intl.dart';

import '../../../core/extentions/navigation.dart';
import '../../add_task/page/add_task.dart';

class TodayHeader extends StatelessWidget {
  const TodayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                DateFormat.EEEE().format(DateTime.now()),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        PrimaryButton(
          width: 138,
          text: '+ Add Task',
          onPressed: () {
            pushTo(context, PutTask());
          },
        ),
      ],
    );
  }
}
