import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/completed_task_screen_controller.dart';

import 'package:task_manager/ui/widgets/snackbar_massage.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  static const String name = "/CompletedTaskScreen";

  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompletedTaskScreenController _completedTaskScreenController =
      Get.find<CompletedTaskScreenController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCompletedTaskScreen();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompletedTaskScreenController>(builder: (controller) {
      return Visibility(
        visible: !controller.inProgress,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            _getCompletedTaskScreen();
          },
          child: ListView.separated(
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: controller.completedNewTask[index],
                  onRefresh: _getCompletedTaskScreen,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemCount: controller.completedNewTask.length),
        ),
      );
    });
  }


  Future<void> _getCompletedTaskScreen() async {
    final bool result =
        await _completedTaskScreenController.getCompletedNewTask();
    if (result == false) {
      ShowSnackBarMassage(
          context, _completedTaskScreenController.errorMassage!);
    }
  }
}
