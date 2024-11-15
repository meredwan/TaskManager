import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/screen/sing_in_screen.dart';
import 'package:task_manager/ui/utils/appcolors.dart';
import 'package:task_manager/ui/utils/urls.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';

class SetPasswordScreen extends StatefulWidget {
  static const String name= "/SetPasswordScreen";
  SetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  final email;
  final otp;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool obscureText = true;
  bool _setPasswordInProgress = false;

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
                  "Set Password",
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  "Minimum length password 8 character with Letter and Number Combination",
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
    return Form(
      key: _globalKey,
      child: Column(
        children: [
          TextFormField(
            validator: (String? value) {
              if (value?.isNotEmpty == true) {
                return "Enter Valid Password";
              }
              if (value!.length > 6) {
                return 'Enter Valid Password Must be 6 Character';
              } else {
                return null;
              }
            },
            controller: _newPasswordController,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    obscureText = !obscureText;
                    setState(() {});
                  },
                  icon: obscureText
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility)),
              hintText: "Password",
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            validator: (String? value) {
              if (value?.isNotEmpty == true) {
                return "Confirm Your Password";
              }
              if (value!.length > 6) {
                return "Valid Password Must be 6 Character";
              }
              return null;
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      obscureText = !obscureText;
                      setState(() {});
                    },
                    icon: obscureText
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility)),
                hintText: "Confirm Password"),
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: _onTabConfirmButton,
            child: Text(
              "Confirm",
              style: TextStyle(fontSize: 18),
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

  void _onTabConfirmButton() {
    if (_globalKey.currentState!.validate()) {
      return;
    }
    _confirmPassword();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingInScreen(),
      ),
    );
  }

  Future<void> _confirmPassword() async {
    _setPasswordInProgress = true;
    setState(() {});
    Map<String, dynamic> _requestBody = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _confirmPasswordController.text
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registration, body: _requestBody);
    _setPasswordInProgress = false;

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
