import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/ui/utils/appcolors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key, required this.taskModel,
  });
  final TaskModel taskModel;
  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
             widget.taskModel.title?? '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(widget.taskModel.description?? ''),
            Text("Date:${widget.taskModel.createdDate?? ''}"),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatusChip(),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: _OnTabEditButton,
                      icon: Icon(
                        Icons.edit,
                      ),
                    ),
                    IconButton(
                      onPressed: _OnTabDeleteButton,
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _OnTabEditButton() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['New', 'Completed','Cancelled','Progress'].map((e){
              return ListTile(
                onTap: () {

                },
                title: Text(e),
              );
            }).toList(),
          ),
          title: Text("Edit Status"),
          actions: [

            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("Cancel"),),
            TextButton(onPressed: () {}, child: Text("OK"),),
          ],
        );
      },
    );
  }

  void _OnTabDeleteButton() {}

  Widget _buildTaskStatusChip() {
    return Chip(
      label: Text(
        "New",
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16,
          ),
          side: BorderSide(color: AppColor.ThemeColor)),
    );
  }
}
