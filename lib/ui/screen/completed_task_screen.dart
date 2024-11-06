import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/new_task_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/utils/urls.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;
   List<TaskModel> _completedNewTask = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCompletedTaskScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCompletedTaskInProgress,
      replacement: Center(
        child: CircularProgressIndicator(),
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          _getCompletedTaskScreen();
        },
        child: ListView.separated(
            itemBuilder: (context, index) {
              return TaskCard(taskModel: _completedNewTask[index], onRefresh: _getCompletedTaskScreen,);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 15,
              );
            },
            itemCount: _completedNewTask.length),
      ),
    );
  }

  Future<void> _getCompletedTaskScreen() async {
    _completedNewTask.clear();
    _getCompletedTaskInProgress = false;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.completedTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _completedNewTask = taskListModel.taskList ?? [];
    } else {
      ShowSnackBarMassage(context, response.errorMassage);
    }
    _getCompletedTaskInProgress = false;
    setState(() {});
  }
}
