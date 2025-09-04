import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/components/input/primary_button.dart';

import '../../../core/constants/task_colors.dart';
import '../../../core/models/task_model.dart';
import '../../../core/services/local_storage.dart';
import '../../../core/utils/app_colors.dart';
import '../widgets/text_form_fiald_selction.dart';

class PutTask extends StatefulWidget {
  const PutTask({super.key, this.taskModel});

  final TaskModel? taskModel;

  @override
  State<PutTask> createState() => _PutTaskState();
}

class _PutTaskState extends State<PutTask> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();

  int selectedColor = 0;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.taskModel?.title ?? '';
    descriptionController.text = widget.taskModel?.description ?? '';
    dateController.text = widget.taskModel?.date ??
        DateFormat("yyyy-MM-dd").format(DateTime.now());
    startTimeController.text = widget.taskModel?.startTime ??
        DateFormat("hh:mm a").format(DateTime.now());
    endTimeController.text = widget.taskModel?.endTime ??
        DateFormat("hh:mm a").format(DateTime.now());
    selectedColor = widget.taskModel?.color ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: PrimaryButton(
            height: 55,
            text: widget.taskModel != null ? 'Update Task' : 'Create Task',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                String id = '';
                if (widget.taskModel != null) {
                  id = widget.taskModel!.id;
                } else {
                  id = DateTime.now().millisecondsSinceEpoch.toString();
                }
                LocalHelper.cacheTask(
                  id,
                  TaskModel(
                    id: id,
                    title: titleController.text,
                    description: descriptionController.text,
                    date: dateController.text,
                    startTime: startTimeController.text,
                    endTime: endTimeController.text,
                    color: selectedColor,
                    isCompleted: false,
                  ),
                );
                Navigator.pop(context);
              }
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 6),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Enter title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                Text(
                  'Description',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 6),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter description ...',
                  ),
                ),
                SizedBox(height: 12),
                dateSelection(),
                SizedBox(height: 12),
                timeSelection(),
                SizedBox(height: 12),
                colorSelection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column colorSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600)),
        SizedBox(height: 6),
        Row(
          spacing: 5,
          children: List.generate(taskColors.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: CircleAvatar(
                backgroundColor: taskColors[index],
                child: (selectedColor == index)
                    ? Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            );
          }),
        ),
      ],
    );
  }

  Column dateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600)),
        SizedBox(height: 6),
        TextFormField(
          controller: dateController,
          onTap: () async {
            var selectedDate = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              initialDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365 * 3)),
            );
            if (selectedDate != null) {
              dateController.text = DateFormat(
                "yyyy-MM-dd",
              ).format(selectedDate);
            }
          },
          readOnly: true,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.calendar_month,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Row timeSelection() {
    return Row(
      children: [
        TimeFieldSelection(
          controller: startTimeController,
          text: 'Start Time',
          onTap: () async {
            var selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (selectedTime != null) {
              startTimeController.text = selectedTime.format(context);
              // var startTime = DateFormat(
              //   "hh:mm:ss a",
              // ).parse(startTimeController.text);
            }
          },
        ),
        SizedBox(width: 10),
        TimeFieldSelection(
          controller: endTimeController,
          text: 'End Time',
          onTap: () async {
            var selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (selectedTime != null) {
              endTimeController.text = selectedTime.format(context);
            }
          },
        ),
      ],
    );
  }
}
