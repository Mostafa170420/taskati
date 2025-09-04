import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../core/models/task_model.dart';
import '../../../core/services/local_storage.dart';
import '../../../core/utils/app_colors.dart';
import 'task_cart.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  String selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          DatePicker(
            DateTime.now(),
            height: 100,
            width: 70,
            initialSelectedDate: DateTime.now(),
            selectionColor: AppColors.primaryColor,
            selectedTextColor: Colors.white,
            dayTextStyle: Theme.of(context).textTheme.bodyMedium!,
            monthTextStyle: Theme.of(context).textTheme.bodyMedium!,
            dateTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
            onDateChange: (date) {
              setState(() {
                selectedDate = DateFormat("yyyy-MM-dd").format(date);
              });
            },
          ),
          SizedBox(height: 10),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: LocalHelper.taskBox.listenable(),
              builder: (context, box, child) {
                List<TaskModel> tasks = [];
                for (var model in box.values) {
                  if (model.date == selectedDate) {
                    tasks.add(model);
                  }
                }
                if (tasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/animation/empty.json', width: 300),
                        Text(
                          'No Tasks Found',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskCard(
                      task: tasks[index],
                      onComplete: () {
                        box.put(
                          tasks[index].id,
                          tasks[index].copyWith(isCompleted: true),
                        );
                      },
                      onDelete: () {
                        box.delete(tasks[index].id);
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: tasks.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
