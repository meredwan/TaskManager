import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../data/models/network_response.dart';
import '../data/models/new_task_model.dart';
import '../data/services/network_caller.dart';
import '../ui/utils/urls.dart';

class NewTaskListController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;
  String? _errorMassage;

  String? get errorMassage => _errorMassage;
  List<TaskModel> _newTaskList = [];

  List<TaskModel> get taskList => _newTaskList;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _newTaskList.clear();
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.newTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _newTaskList = taskListModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
