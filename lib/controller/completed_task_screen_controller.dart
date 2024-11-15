import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/new_task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';

import '../data/models/task_model.dart';
import '../ui/utils/urls.dart';

class CompletedTaskScreenController extends GetxController {
  bool _inProgress = false;
  List<TaskModel> _completedNewTask = [];
  String? _errorMassage;

  bool get inProgress => _inProgress;

  List<TaskModel> get completedNewTask => _completedNewTask;

  String? get errorMassage => _errorMassage;

  Future<bool> getCompletedNewTask() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.completedTaskList);

    if (response.isSuccess) {
      isSuccess=true;
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _completedNewTask = taskListModel.taskList ?? [];
    } else {
      _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
