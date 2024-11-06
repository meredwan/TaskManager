import 'task_status_model.dart';

class TaskStatusCountModel {
  String? status;
  List<TaskCountModel>? TaskStatusCountList;

  TaskStatusCountModel({this.status, this.TaskStatusCountList});

  TaskStatusCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      TaskStatusCountList = <TaskCountModel>[];
      json['data'].forEach((v) {
        TaskStatusCountList!.add(new TaskCountModel.fromJson(v));
      });
    }
  }
}
