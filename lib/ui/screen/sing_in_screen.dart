import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/sign_in_controller.dart';
import 'package:task_manager/ui/screen/forgot_password_email.dart';
import 'package:task_manager/ui/screen/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screen/sing_up_screen.dart';
import 'package:task_manager/ui/utils/appcolors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';

class SingInScreen extends StatefulWidget {
  static const String name = "/SignInScreen";

  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final SignInController signInController = Get.find<SignInController>();

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
                  "Get Started With",
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildSingInFrom(),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _onTabForgotPasswordButton,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      _buildSignUpSection(),
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

  Widget _buildSingInFrom() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Valid Email";
              }
              return null;
            },
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "Email"),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? Value) {
              if (Value?.isEmpty ?? true) {
                return "Enter your Password";
              }
              if (Value!.length <= 6) {
                return "Enter a Password more than 6 Character";
              }
              return null;
            },
            controller: _passwordTEController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          GetBuilder<SignInController>(builder: (controller) {
            return Visibility(
              visible: !controller.inProgress,
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
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSignUpSection() {
    return RichText(
      text: TextSpan(
        text: "Don't have an account?",
        style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5),
        children: [
          TextSpan(
              text: "Sign Up",
              style: TextStyle(color: AppColor.ThemeColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.offAllNamed(SingUpScreen.name);
                }),
        ],
      ),
    );
  }

  void _onTabForgotPasswordButton() {
    Get.toNamed(ForgotPasswordEmailScreen.name);
  }

  void _onTabNextButton() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _SignIn();
  }

  Future<void> _SignIn() async {
    final bool result = await signInController.SignIn(
        _emailTEController.text.trim(), _passwordTEController.text.trim());
    if (result) {
      Get.toNamed(MainBottomNavScreen.name);
    } else {
      ShowSnackBarMassage(context, signInController.errorMassage!, true);
    }
  }
}
