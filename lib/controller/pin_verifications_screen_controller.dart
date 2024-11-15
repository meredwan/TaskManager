import 'package:get/get.dart';

import '../data/models/network_response.dart';
import '../data/services/network_caller.dart';
import '../ui/utils/urls.dart';

class OTPPinVerificationScreenController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  bool get inProgress => _inProgress;

  Future<bool> recoveredVerifyScreen(String verifyEmail, String otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.RecoverVerifyOtp(verifyEmail, otp));

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
