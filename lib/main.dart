import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/features/splash/page/splash_screen.dart';

import 'core/services/local_storage.dart';
import 'core/utils/theme.dart';
import 'features/upload_info/cubit/upload_cubit.dart';

void main() async {
  await Hive.initFlutter();
  await LocalHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UploadCubit()..getDAta()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: SplashScreen()),
    );
  }
}
