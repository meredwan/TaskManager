import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/new_task_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/utils/urls.dart';

class CanceledTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;
  List<TaskModel> _canceledNewTask = [];

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  List<TaskModel> get canceledNewTask => _canceledNewTask;

  Future<bool> CanceledNewTask() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.canceledTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _canceledNewTask = taskListModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
