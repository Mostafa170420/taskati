import 'package:flutter/material.dart';
import 'package:taskati/features/home/widgets/tasks_list.dart';
import 'package:taskati/features/home/widgets/today_header.dart';

import '../widgets/home_header.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            HomeHeader(),
            SizedBox(height: 20),
            TodayHeader(),
            SizedBox(height: 20),
            TasksList(),
          ],
        ),
      ),
    ));
  }
}
