import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../data/models/network_response.dart';
import '../data/models/new_task_model.dart';
import '../data/services/network_caller.dart';
import '../ui/utils/urls.dart';

class ProgressTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;
  List<TaskModel> _progressTaskList = [];

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  List<TaskModel> get progressTaskList => _progressTaskList;

  Future<bool> getProgressNewList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.progressTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _progressTaskList = taskListModel.taskList ?? [];
      isSuccess = true;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
