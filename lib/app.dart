import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllter_binding.dart';
import 'package:task_manager/ui/screen/forgot_password_email.dart';
import 'package:task_manager/ui/screen/sing_in_screen.dart';
import 'package:task_manager/ui/screen/sing_up_screen.dart';
import 'package:task_manager/ui/screen/splash_screen.dart';
import 'package:task_manager/ui/utils/appcolors.dart';

import 'ui/screen/canceled_task_screen.dart';
import 'ui/screen/completed_task_screen.dart';
import 'ui/screen/main_bottom_nav_screen.dart';
import 'ui/screen/new_task_screen.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> NavigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerApp.NavigatorKey,
      theme: ThemeData(
        elevatedButtonTheme: _elevatedButtonThemeData(),
        inputDecorationTheme: _inputDecorationTheme(),
        textTheme: const TextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      initialRoute: "/",
      routes: {
        SplashScreen.home: (context) => SplashScreen(),
        SingInScreen.name: (context) => SingInScreen(),
        SingUpScreen.name: (context) => SingUpScreen(),
        CompletedTaskScreen.name: (context) => CompletedTaskScreen(),
        NewTaskScreen.name: (context) => NewTaskScreen(),
        CanceledTaskScreen.name: (context) => CanceledTaskScreen(),
        MainBottomNavScreen.name: (context) => MainBottomNavScreen(),
        ForgotPasswordEmailScreen.name: (context) =>
            ForgotPasswordEmailScreen(),
      },
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.ThemeColor,
        foregroundColor: Colors.white,
        fixedSize: Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        border: _inputBorder(),
        enabledBorder: _inputBorder(),
        errorBorder: _inputBorder());
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
