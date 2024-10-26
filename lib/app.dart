import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/splash_screen.dart';
import 'package:task_manager/ui/utils/appcolors.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});
  static GlobalKey<NavigatorState> NavigatorKey=GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:TaskManagerApp.NavigatorKey ,
      theme: ThemeData(
        elevatedButtonTheme: _elevatedButtonThemeData(),
        inputDecorationTheme: _inputDecorationTheme(),
        textTheme: const TextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
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
