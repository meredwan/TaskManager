import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
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
