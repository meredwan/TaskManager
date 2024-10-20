import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/utils/appcolors.dart';
import 'package:task_manager/ui/utils/urls.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';

class SingUpScreen extends StatefulWidget {
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
  bool _inProgress = false;

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
          Visibility(
            visible: !_inProgress,
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
              recognizer: TapGestureRecognizer()..onTap = _onTapSignIn),
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
    _inProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEControllar.text.trim(),
      "firstName": _fristNameTEControllar.text.trim(),
      "lastName": _lastNameTEControllar.text.trim(),
      "mobile": _mobileTEControllar.text.trim(),
      "password": _passwordlTEControllar.text,
      "Photo": ""
    };
    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registration, body: requestBody);
    _inProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _clearTextField();
      ShowSnackBarMassage(context, "New User Created");
    } else {
      print(response.statusCode);
      ShowSnackBarMassage(context,"Something Wrong", true);
    }
  }

  void _onTapSignIn() {
    Navigator.pop(context);
  }

  void _clearTextField(){
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
