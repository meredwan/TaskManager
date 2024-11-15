import 'package:get/get.dart';

import '../data/auth/auth_controller.dart';
import '../data/models/login_model.dart';
import '../data/models/network_response.dart';
import '../data/services/network_caller.dart';
import '../ui/utils/urls.dart';

class SignInController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;
  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  Future<bool> SignIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> _requestBody = {"email": email, "password": password};
    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.login, body: _requestBody);

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);
      isSuccess = true;
    } else {
      _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
