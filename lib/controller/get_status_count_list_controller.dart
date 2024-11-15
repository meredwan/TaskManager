import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/new_task_model.dart';
import 'package:task_manager/data/models/task_count_model.dart';
import 'package:task_manager/data/models/task_status_model.dart';

import '../data/models/task_model.dart';
import '../data/services/network_caller.dart';
import '../ui/utils/urls.dart';

class GetStatusCountListController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;
  List<TaskCountModel> _newStatusCountList = [];

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  List<TaskCountModel> get newStatusCountList => _newStatusCountList;

  Future<bool> getStatusCountList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);

    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel =
          TaskStatusCountModel.fromJson(response.responseData);
      _newStatusCountList = taskStatusCountModel.TaskStatusCountList ?? [];

    } else {
      _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
