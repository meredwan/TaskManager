import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/forget_password_controller.dart';

import 'package:task_manager/ui/screen/pin_verifications_screen.dart';
import 'package:task_manager/ui/screen/sing_in_screen.dart';
import 'package:task_manager/ui/utils/appcolors.dart';

import 'package:task_manager/ui/widgets/snackbar_massage.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  static const String name = "/ForgotPasswordEmailScreen";

  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final ForgetPasswordController _forgetPasswordController =
      Get.find<ForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            Text(
              "Your Email Address",
              style:
                  textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              "A 6 digit verification pin will send your email address",
              style: textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            _buildEmailFrom(),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildForgotEmailSection(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEmailFrom() {
    return Form(
      key: _globalKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter a Valid Email";
              }
              if (!value!.contains('@')) {
                return 'Enter Valid Email"@"';
              }
              if (!value.contains(".com")) {
                return "Enter Valid Email'.com'";
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "Email"),
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: _onTabNextButton,
            child: Icon(
              Icons.arrow_circle_right_outlined,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotEmailSection() {
    return RichText(
      text: TextSpan(
        text: "have account?",
        style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5),
        children: [
          TextSpan(
              text: "Sign In",
              style: TextStyle(color: AppColor.ThemeColor),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignIn),
        ],
      ),
    );
  }

  void _onTabNextButton() {
    if (_globalKey.currentState!.validate()) {
      _onTabOTPScreen();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PinVerificationScreen(
            verifyEmail: _emailTEController.text.trim(),
          ),
        ),
      );
    } else {
      return;
    }
  }

  Future<void> _onTabOTPScreen() async {
    final result = _forgetPasswordController
        .onTabOTPScreen(_emailTEController.text.trim());
    if (result == false) {
      ShowSnackBarMassage(context, _forgetPasswordController.errorMassage!);
    }
  }

  void _onTapSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingInScreen(),
      ),
    );
  }
}
