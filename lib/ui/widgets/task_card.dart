import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/utils/appcolors.dart';
import 'package:task_manager/ui/utils/urls.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.onRefresh,
  });

  final TaskModel taskModel;
  final VoidCallback onRefresh;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectedStatus = '';
  bool _changeStatusInProgress = false;
  bool _deleteStatusInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedStatus = widget.taskModel.status!;
  }

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
              widget.taskModel.title ?? '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(widget.taskModel.description ?? ''),
            Text("Date:${widget.taskModel.createdDate ?? ''}"),
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
                    Visibility(
                      visible: !_changeStatusInProgress,
                      replacement: Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: IconButton(
                        onPressed: _OnTabEditButton,
                        icon: Icon(
                          Icons.edit,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !_deleteStatusInProgress,
                      replacement: Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: IconButton(
                        onPressed: _OnTabDeleteButton,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
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
            children: ['New', 'Completed', 'Canceled', 'Progress'].map((e) {
              return ListTile(
                onTap: () {
                  _ChangeStatus(e);
                  Navigator.pop(context);
                },
                title: Text(e),
                selected: _selectedStatus == e,
                trailing: _selectedStatus == e ? Icon(Icons.check_box) : null,
              );
            }).toList(),
          ),
          title: Text("Edit Status"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _OnTabDeleteButton() async {
    _deleteStatusInProgress = false;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        Urls.deleteTaskList(widget.taskModel.sId!));
    if (response.isSuccess) {
      widget.onRefresh();
    } else {
      ShowSnackBarMassage(context, response.errorMassage);
      _deleteStatusInProgress = false;
      setState(() {});
    }
  }

  Widget _buildTaskStatusChip() {
    return Chip(
      label: Text(
        widget.taskModel.status!,
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

  Future<void> _ChangeStatus(String newStatus) async {
    _changeStatusInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.changeStatusTaskList(widget.taskModel.sId!, newStatus),
    );
    if (response.isSuccess) {
    } else {
      _changeStatusInProgress = false;
      setState(() {});
      ShowSnackBarMassage(context, response.errorMassage);
    }
  }
}
