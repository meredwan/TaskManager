import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/progress_task_screen_controller.dart';

import 'package:task_manager/ui/widgets/snackbar_massage.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  static const String name = "/ProgressTaskScreen";

  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final ProgressTaskController _progressTaskController =
      Get.find<ProgressTaskController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progressNewListScreen();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressTaskController>(builder: (controller) {
      return Visibility(
        visible: !controller.inProgress,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            _progressNewListScreen();
          },
          child: ListView.separated(
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: _progressTaskController.progressTaskList[index],
                  onRefresh: _progressNewListScreen,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemCount: _progressTaskController.progressTaskList.length),
        ),
      );
    });
  }

  Future<void> _progressNewListScreen() async {
    final bool progressResult =
        await _progressTaskController.getProgressNewList();
    if (progressResult) {
      ShowSnackBarMassage(context, _progressTaskController.errorMassage!);
    }
  }
}
