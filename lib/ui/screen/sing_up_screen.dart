import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/sign_up_controller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/screen/sing_in_screen.dart';
import 'package:task_manager/ui/utils/appcolors.dart';
import 'package:task_manager/ui/utils/urls.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';

class SingUpScreen extends StatefulWidget {
  static const String name = "/SingUpScreen";

  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _emailTEControllar = TextEditingController();
  final TextEditingController _fristNameTEControllar = TextEditingController();
  final TextEditingController _lastNameTEControllar = TextEditingController();
  final TextEditingController _mobileTEControllar = TextEditingController();
  final TextEditingController _passwordlTEControllar = TextEditingController();
  SignUpController signUpController = Get.find<SignUpController>();

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
                  "Join With Us",
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
                  child: _buildSignInSection(),
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
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter Valid Email';
              }
              return null;
            },
            controller: _emailTEControllar,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "Email"),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please Enter First Name';
              }
              return null;
            },
            controller: _fristNameTEControllar,
            decoration: InputDecoration(
              hintText: "First Name",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please Enter Last Name';
              }
              return null;
            },
            controller: _lastNameTEControllar,
            decoration: InputDecoration(
              hintText: "Last Name",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please Enter Your Mobile Number';
              }
              return null;
            },
            controller: _mobileTEControllar,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "Mobile",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please Enter Your Password';
              }
            },
            controller: _passwordlTEControllar,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          GetBuilder<SignUpController>(builder: (controller) {
            return Visibility(
              visible: !signUpController.inProgress,
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

  Widget _buildSignInSection() {
    return RichText(
      text: TextSpan(
        text: "Have an account?",
        style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5),
        children: [
          TextSpan(
            text: "Sign In",
            style: TextStyle(color: AppColor.ThemeColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.offNamed(SingInScreen.name);
              },
          ),
        ],
      ),
    );
  }

  void _onTabNextButton() {
    if (_formkey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    final bool result = await signUpController.signUp(
      _emailTEControllar.text.trim(),
      _fristNameTEControllar.text.trim(),
      _lastNameTEControllar.text.trim(),
      _mobileTEControllar.text.trim(),
      _passwordlTEControllar.text,
    );

    if (result == false) {
      _clearTextField();
      Get.snackbar("New User", "New User Created Successfully");
    } else {
      ShowSnackBarMassage(context, "Something Wrong", true);
      Get.snackbar(
        "Error",
        signUpController.errorMassage!,
      );
    }
  }

  void _clearTextField() {
    _emailTEControllar.clear();
    _fristNameTEControllar.clear();
    _lastNameTEControllar.clear();
    _mobileTEControllar.clear();
    _passwordlTEControllar.clear();
  }

  @override
  void dispose() {
    _emailTEControllar.dispose();
    _fristNameTEControllar.dispose();
    _lastNameTEControllar.dispose();
    _mobileTEControllar.dispose();
    _passwordlTEControllar.dispose();
    super.dispose();
  }
}
