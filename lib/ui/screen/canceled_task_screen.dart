import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/canceled_task_screen_controller.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  static const String name = "/CanceledTaskScreen";

  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  final CanceledTaskController _canceledTaskController =
      Get.find<CanceledTaskController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _canceledNewTaskListScreen();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CanceledTaskController>(builder: (controller) {
      return Visibility(
        visible: !controller.inProgress,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            _canceledNewTaskListScreen();
          },
          child: ListView.separated(
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: controller.canceledNewTask[index],
                  onRefresh: _canceledNewTaskListScreen,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemCount: controller.canceledNewTask.length),
        ),
      );
    });
  }

  Future<void> _canceledNewTaskListScreen() async {
    final bool result = await _canceledTaskController.CanceledNewTask();
    if (result == false) {
      ShowSnackBarMassage(context, _canceledTaskController.errorMassage!);
    }
  }
}
