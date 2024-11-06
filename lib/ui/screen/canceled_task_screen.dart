import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/new_task_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/utils/urls.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  bool _canceledNewTaskInProgress = false;
  List<TaskModel> _canceledNewTask = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _canceledNewTaskListScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_canceledNewTaskInProgress,
      replacement: Center(
        child: CircularProgressIndicator(),
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          _canceledNewTaskListScreen();
        },
        child: ListView.separated(
            itemBuilder: (context, index) {
              return TaskCard(taskModel: _canceledNewTask[index], onRefresh: _canceledNewTaskListScreen,);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 15,
              );
            },
            itemCount: _canceledNewTask.length),
      ),
    );
  }

  Future<void> _canceledNewTaskListScreen() async {
    _canceledNewTask.clear();
    _canceledNewTaskInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.canceledTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _canceledNewTask = taskListModel.taskList ?? [];
    } else {
      ShowSnackBarMassage(context, response.errorMassage);
    }
    _canceledNewTaskInProgress = false;
    setState(() {});
  }
}
