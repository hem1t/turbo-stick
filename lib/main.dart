import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:timers/color.dart';
import 'package:timers/providers.dart';

import 'sidebar/sidebar.dart';
import 'timers/timer_base.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(384, 554),
      minTextAdapt: true,
      builder: (context, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: AppColors.backgroundColor,
            shadowColor: AppColors.contrastColor),
        home: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: MultiProvider(providers: [
              ChangeNotifierProvider(create: (_) => AppSettings())
            ], child: const Timer())),
      );
    });
  }
}

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        MainPage(),
        Sidebar(),
      ],
    );
  }
}