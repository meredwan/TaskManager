import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/tmappbar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: SingleChildScrollView(
        child: Screen_BG(
          child: Padding(
            padding: const EdgeInsets.all(24),
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
                  decoration: InputDecoration(hintText: "Title"),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(hintText: "Description"),
                ),
                const SizedBox(
                  height: 24,
                ),
        
                ElevatedButton(onPressed: () {
                  
                }, child: Icon(Icons.arrow_circle_right_outlined))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
