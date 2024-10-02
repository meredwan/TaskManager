import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/add_new_task_screen.dart';
import 'package:task_manager/ui/utils/appcolors.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:task_manager/ui/widgets/task_summary_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.ThemeColor,
        onPressed: _OnTabFAB,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          _buildSummerySection(),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return TaskCard();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount: 10),
          )
        ],
      ),
    );
  }

  Widget _buildSummerySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TaskSummaryCard(
              Title: 'Canceled',
              Count: 09,
            ),
            TaskSummaryCard(
              Title: 'Completed',
              Count: 09,
            ),
            TaskSummaryCard(
              Title: 'Progress',
              Count: 09,
            ),
            TaskSummaryCard(
              Title: 'New Task',
              Count: 09,
            ),
          ],
        ),
      ),
    );
  }

  void _OnTabFAB() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNewTaskScreen(),
        ));
  }
}
