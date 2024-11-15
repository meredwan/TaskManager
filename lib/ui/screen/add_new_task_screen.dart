import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/add_new_task_controller.dart';
import 'package:task_manager/ui/screen/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';
import 'package:task_manager/ui/widgets/tmappbar.dart';

class AddNewTaskScreen extends StatefulWidget {
  static const String name = "/AddNewTaskScreen";

  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddNewTaskController addNewTaskController = Get.find<AddNewTaskController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        Navigator.pop(context, addNewTaskController.shouldRefresh);
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
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
                    GetBuilder<AddNewTaskController>(builder: (controller) {
                      return Visibility(
                        visible: !addNewTaskController.inProgress,
                        replacement: Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: _onTabSubmitButton,
                            child: Icon(Icons.arrow_circle_right_outlined)),
                      );
                    })
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
    final bool result = await addNewTaskController.addNewTask(
        _titleTEController.text.trim(),
        _descriptionTEController.text.trim(),
        "New");

    if (result) {
      _ClearTextField();
      Get.snackbar("Task Massage", "Created New Task",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      ShowSnackBarMassage(context, addNewTaskController.errorMassage!, true);
    }
  }

  void _ClearTextField() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }
}
