import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/new_task_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/utils/urls.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _progressTaskInProgress = false;
  List<TaskModel> _getProgressList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progressNewListScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_progressTaskInProgress,
      replacement: Center(
        child: CircularProgressIndicator(),
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          _progressNewListScreen();
        },
        child: ListView.separated(
            itemBuilder: (context, index) {
              return TaskCard(taskModel: _getProgressList[index], onRefresh: _progressNewListScreen,);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 15,
              );
            },
            itemCount: _getProgressList.length),
      ),
    );
  }

  Future<void> _progressNewListScreen() async {
    _getProgressList.clear();
    _progressTaskInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.progressTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _getProgressList = taskListModel.taskList ?? [];
    } else {
      ShowSnackBarMassage(context, response.errorMassage);
    }
    _progressTaskInProgress = false;
    setState(() {});
  }
}
