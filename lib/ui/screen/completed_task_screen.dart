import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return TaskCard();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 15,
          );
        },
        itemCount: 10);
  }
}
