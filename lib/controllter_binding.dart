import 'package:get/get.dart';
import 'package:task_manager/controller/add_new_task_controller.dart';
import 'package:task_manager/controller/canceled_task_screen_controller.dart';
import 'package:task_manager/controller/completed_task_screen_controller.dart';
import 'package:task_manager/controller/forget_password_controller.dart';
import 'package:task_manager/controller/get_status_count_list_controller.dart';
import 'package:task_manager/controller/new_task_list_controller.dart';
import 'package:task_manager/controller/pin_verifications_screen_controller.dart';
import 'package:task_manager/controller/progress_task_screen_controller.dart';
import 'package:task_manager/controller/sign_in_controller.dart';
import 'package:task_manager/controller/sign_up_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(NewTaskListController());
    Get.put(CompletedTaskScreenController());
    Get.put(GetStatusCountListController());
    Get.put(CanceledTaskController());
    Get.put(ProgressTaskController());
    Get.put(ForgetPasswordController());
    Get.put(OTPPinVerificationScreenController());
    Get.put(AddNewTaskController());
  }
}
