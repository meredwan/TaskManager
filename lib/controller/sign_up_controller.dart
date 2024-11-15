import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';

import '../ui/utils/urls.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  Future<bool> signUp(
    String email,
    String firstName,
    String lastName,
    String mobileNumber,
    String password,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobileNumber,
      "password": password,
      "Photo": ""
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registration, body: requestBody);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMassage = response.errorMassage;
    }

    return isSuccess;
  }
}
