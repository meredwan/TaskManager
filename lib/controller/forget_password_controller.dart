import 'package:get/get.dart';

import '../data/models/network_response.dart';
import '../data/services/network_caller.dart';
import '../ui/utils/urls.dart';

class ForgetPasswordController extends GetxController {
  bool _inProgress = false;

  String? _errorMassage;

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  Future<bool> onTabOTPScreen(String email) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.RecoverVerifyEmail(email),
    );

    if (response.isSuccess) {
      isSuccess = true;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
