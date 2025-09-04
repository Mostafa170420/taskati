import 'package:hive/hive.dart';

part 'task_model_adapter.dart';

class TaskModel {
  final String id;
  final String title;
  final String? description;
  final String date;
  final String startTime;
  final String endTime;
  final int color;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.isCompleted,
  });

  copyWith({
    String? title,
    String? description,
    String? date,
    String? startTime,
    String? endTime,
    int? color,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
