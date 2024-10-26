import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          // return TaskCard();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 15,
          );
        },
        itemCount: 10);
  }
}
