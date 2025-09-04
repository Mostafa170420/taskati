import 'package:flutter/material.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/models/task_model.dart';

import '../../../core/constants/task_colors.dart';
import '../../../core/utils/app_colors.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onComplete,
    required this.onDelete,
  });

  final TaskModel task;
  final Function() onComplete;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onComplete();
        } else {
          onDelete();
        }
      },
      background: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.check, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Complete',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.pinkColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Delete',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: task.isCompleted ? Colors.green : taskColors[task.color],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white,
                          size: 17,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '${task.startTime} : ${task.endTime}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                        ),
                      ],
                    ),
                    if (task.description?.isNotEmpty == true) ...[
                      SizedBox(height: 6),
                      Text(
                        task.description ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(width: 1, height: 60, color: Colors.white),
              SizedBox(width: 10),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  task.isCompleted ? 'COMPLETED' : 'TODO',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
