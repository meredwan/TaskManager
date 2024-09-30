import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/canceled_task_screen.dart';
import 'package:task_manager/ui/screen/completed_task_screen.dart';
import 'package:task_manager/ui/screen/new_task_screen.dart';
import 'package:task_manager/ui/screen/progress_task_screen.dart';
import 'package:task_manager/ui/utils/appcolors.dart';
import 'package:task_manager/ui/widgets/tmappbar.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final List<Widget> _Screens = [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CanceledTaskScreen(),
    ProgressTaskScreen()
  ];
  int _SelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _Screens[_SelectedIndex],
      bottomNavigationBar: NavigationBar(
          selectedIndex: _SelectedIndex,
          onDestinationSelected: (int index) {
            _SelectedIndex = index;
            setState(() {});
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.new_label), label: "New"),
            NavigationDestination(
                icon: Icon(Icons.check_box), label: "Completed"),
            NavigationDestination(icon: Icon(Icons.close), label: "Canceled"),
            NavigationDestination(
                icon: Icon(Icons.access_time_rounded), label: "Progress"),
          ]),
    );
  }
}

