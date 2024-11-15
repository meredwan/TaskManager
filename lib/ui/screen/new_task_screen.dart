import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/get_status_count_list_controller.dart';
import 'package:task_manager/controller/new_task_list_controller.dart';
import 'package:task_manager/ui/screen/add_new_task_screen.dart';
import 'package:task_manager/ui/utils/appcolors.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:task_manager/ui/widgets/task_summary_screen.dart';

import '../../data/models/task_status_model.dart';

class NewTaskScreen extends StatefulWidget {
  static const String name = "/NewTaskScreen";

  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final NewTaskListController _newTaskListController =
      Get.find<NewTaskListController>();

  final GetStatusCountListController _getStatusCountListController =
      Get.find<GetStatusCountListController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNewTaskList();
    _getStatusCountList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getNewTaskList();
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.ThemeColor,
          onPressed: _OnTabFAB,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            _buildSummerySection(),
            Expanded(
              child: GetBuilder<NewTaskListController>(builder: (controller) {
                return Visibility(
                  visible: !controller.inProgress,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskModel: controller.taskList[index],
                          onRefresh: () {
                            controller.taskList;
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 15,
                        );
                      },
                      itemCount: controller.taskList.length),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSummerySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<GetStatusCountListController>(builder: (controller) {
        return Visibility(
          visible: !controller.inProgress,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _getTaskSummeryCard(),
            ),
          ),
        );
      }),
    );
  }

  List<TaskSummaryCard> _getTaskSummeryCard() {
    List<TaskSummaryCard> taskSummeryCardList = [];
    for (TaskCountModel t in _getStatusCountListController.newStatusCountList) {
      taskSummeryCardList
          .add(TaskSummaryCard(Title: t.sId!, Count: t.sum ?? 0));
    }
    return taskSummeryCardList;
  }

  void _OnTabFAB() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewTaskScreen(),
      ),
    );
    if (shouldRefresh == true) {
      _getNewTaskList();
    }
  }

  Future<void> _getNewTaskList() async {
    final bool result = await _newTaskListController.getNewTaskList();
    if (result == false) {
      ShowSnackBarMassage(context, _newTaskListController.errorMassage!);
    }
  }

  Future<void> _getStatusCountList() async {
    final bool result =
        await _getStatusCountListController.getStatusCountList();
    if (result == false) {
      ShowSnackBarMassage(context, _getStatusCountListController.errorMassage!);
    }
    ;
  }
}
