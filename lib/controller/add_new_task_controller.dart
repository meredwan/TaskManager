import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/utils/urls.dart';

class AddNewTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;
  bool _shouldRefresh = false;

  bool get shouldRefresh => _shouldRefresh;

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  Future<bool> addNewTask(
      String title, String description, String status) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": status,
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTask, body: requestBody);
    if (response.isSuccess) {
      isSuccess = true;
      _shouldRefresh;
    } else {
      _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
