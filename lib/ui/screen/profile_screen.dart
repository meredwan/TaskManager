import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/auth/auth_controller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/user_data_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/utils/urls.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';
import 'package:task_manager/ui/widgets/tmappbar.dart';

class ProfileScreen extends StatefulWidget {
  static const String name= "/ProfileScreen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

bool _updateProfileInProgress = false;

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _selectedImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setUserData();
  }

  void _setUserData() {
    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _phoneTEController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(
        isProfileScreenOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 48,
                ),
                Text(
                  "update Profile",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                _buildPhotoPicker(),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailTEController,
                  enabled: false,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please Enter A valid Email';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(hintText: "Email"),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _firstNameTEController,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please Enter A valid Email';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(hintText: "First Name"),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please Enter your Last Name';
                    } else {
                      return null;
                    }
                  },
                  controller: _lastNameTEController,
                  decoration: InputDecoration(hintText: "Last Name"),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please Enter A valid Email';
                    } else {
                      return null;
                    }
                  },
                  controller: _phoneTEController,
                  decoration: InputDecoration(hintText: "Phone"),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please Enter A valid Email';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(hintText: "Password"),
                ),
                const SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: !_updateProfileInProgress,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        _updateProfile();

                      },
                      child: Icon(Icons.arrow_circle_right_outlined)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    Map<String, dynamic> _requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneTEController.text.trim()
    };
    if (_passwordTEController.text.isNotEmpty) {
      _requestBody['password'] = _passwordTEController.text;
    }
    if (_selectedImage != null) {
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      String ConvertedImage = base64Encode(imageBytes);
      _requestBody['phone'] = ConvertedImage;
    }
    ;
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.ProfileUpdate, body: _requestBody);
    _updateProfileInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(_requestBody);
      AuthController.saveUserData(userModel);
      ShowSnackBarMassage(context, "Profile Has been Updated");
    } else {
      ShowSnackBarMassage(context, response.errorMassage);
    }
  }

  Future<void> _pickedImage() async {
    ImagePicker _imagePicker = ImagePicker();
    XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = pickedImage;
      setState(() {});
    }
  }

  Widget _buildPhotoPicker() => Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: _pickedImage,
              child: Container(
                width: 100,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Photos",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(_getSelectedPhotoItem())
          ],
        ),
      );

  String _getSelectedPhotoItem() {
    if (_selectedImage != null) {
      return _selectedImage!.name;
    } else {
      return "Please Selected Photos";
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  _firstNameTEController.dispose();
  _lastNameTEController.dispose();
  _phoneTEController.dispose();
  _passwordTEController.dispose();
  _emailTEController.dispose();
  }
}
