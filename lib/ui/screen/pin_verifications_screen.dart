import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/pin_verifications_screen_controller.dart';
import 'package:task_manager/ui/screen/set_password_screen.dart';
import 'package:task_manager/ui/screen/sing_in_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/utils/appcolors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';

class PinVerificationScreen extends StatefulWidget {
  static const String name = "/PinVerificationScreen";

  PinVerificationScreen({super.key, required this.verifyEmail});

  final String verifyEmail;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  OTPPinVerificationScreenController _otpPinVerificationScreenController =
      Get.find<OTPPinVerificationScreenController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Screen_BG(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "Pin Verification",
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  "A 6 digit verification pin will send your email address",
                  style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.grey),
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
        ),
      ),
    );
  }

  Widget _buildEmailFrom() {
    return Column(
      children: [
        PinCodeTextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
              selectedFillColor: Colors.white,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 55,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              inactiveColor: Colors.green),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          appContext: context,
        ),
        const SizedBox(
          height: 20,
        ),
        GetBuilder(builder: (context) {
          return Visibility(
            visible: !_otpPinVerificationScreenController.inProgress,
            replacement: Center(
              child: CircularProgressIndicator(),
            ),
            child: ElevatedButton(
                onPressed: _onTabSetPasswordScreen,
                child: Text("Verify",
                    style: TextStyle(fontSize: 18, color: Colors.white))),
          );
        }),
      ],
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

  void _onTabSetPasswordScreen() {
    if (_otpController.text != '') {
      _recoveredVerifyScreen();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetPasswordScreen(
              email: widget.verifyEmail, otp: _otpController.text),
        ),
      );
    }
  }

  Future<void> _recoveredVerifyScreen() async {
    final bool result = await _otpPinVerificationScreenController
        .recoveredVerifyScreen(widget.verifyEmail, _otpController.text);
    if (result == false) {
      ShowSnackBarMassage(
          context, _otpPinVerificationScreenController.errorMassage!);
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
