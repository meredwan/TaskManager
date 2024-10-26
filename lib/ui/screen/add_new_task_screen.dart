import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/utils/urls.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';
import 'package:task_manager/ui/widgets/tmappbar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;
  bool _shouldRefreshNewTaskAdded = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
        onPopInvoked: (didPop)async {
          if(didPop){
            return;
          }
          Navigator.pop(context, _shouldRefreshNewTaskAdded);
        },
      child: Scaffold(
        appBar: TMAppBar(),
        body: SingleChildScrollView(
          child: Screen_BG(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 42,
                    ),
                    Text(
                      "Add New Task",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    TextFormField(
                      controller: _titleTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter a value';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "Title"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _descriptionTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter a value';
                        }
                        return null;
                      },
                      maxLines: 5,
                      decoration: InputDecoration(hintText: "Description"),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Visibility(
                      visible: !_addNewTaskInProgress,
                      replacement: Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                          onPressed: _onTabSubmitButton,
                          child: Icon(Icons.arrow_circle_right_outlined)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTabSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New"
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTask, body: requestBody);
    _addNewTaskInProgress = false;
    setState(() {

    });
    if (response.isSuccess) {
      _shouldRefreshNewTaskAdded=true;
      _ClearTextField();
      ShowSnackBarMassage(context, "Created New Task");
    }
    else{
      ShowSnackBarMassage(context, response.errorMassage, true);
    }

  }

  void _ClearTextField() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }
}
