import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/screen/pin_verifications_screen.dart';
import 'package:task_manager/ui/screen/sing_in_screen.dart';
import 'package:task_manager/ui/screen/sing_up_screen.dart';
import 'package:task_manager/ui/utils/appcolors.dart';
import 'package:task_manager/ui/utils/urls.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  bool _forgetPasswordInProgress = false;
  final TextEditingController _emailTEController = TextEditingController();

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
                  "Your Email Address",
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
        Visibility(
          visible: !_forgetPasswordInProgress,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: ElevatedButton(
            onPressed: _onTabNextButton,
            child: Icon(
              Icons.arrow_circle_right_outlined,
              size: 30,
            ),
          ),
        ),
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

  void _onTabNextButton() {
    if (_emailTEController.text != '') {
      _onTabOTPScreen();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PinVerificationScreen(
            verifyEmail: _emailTEController.text.trim(),
          ),
        ),
      );
    }
  }

  Future<void> _onTabOTPScreen() async {
    _forgetPasswordInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.RecoverVerifyEmail(_emailTEController.text),
    );
    _forgetPasswordInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      ShowSnackBarMassage(context, response.responseData['data']);
    } else {
      ShowSnackBarMassage(context, response.errorMassage);
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
