import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/features/upload_info/page/upload_info_screen.dart';

import '../../../core/extentions/navigation.dart';
import '../../home/page/home_screens.dart';
import '../../upload_info/cubit/upload_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      bool isUpload = BlocProvider.of<UploadCubit>(context).isUpload!;

      pushWithReplacement(
          context, isUpload ? const HomeScreens() : UploadInfoScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/Task Done.json',
              width: MediaQuery.of(context).size.width / 1.8,
              repeat: false,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text("Taskati", style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 10),
            Text("it's Time to Get Organized",
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
