// import 'package:flutter/material.dart';
// import 'package:task_manager/data/models/network_response.dart';
// import 'package:task_manager/data/models/new_task_model.dart';
// import 'package:task_manager/data/models/task_count_model.dart';
// import 'package:task_manager/data/models/task_model.dart';
// import 'package:task_manager/data/services/network_caller.dart';
// import 'package:task_manager/ui/screen/add_new_task_screen.dart';
// import 'package:task_manager/ui/utils/appcolors.dart';
// import 'package:task_manager/ui/utils/urls.dart';
// import 'package:task_manager/ui/widgets/snackbar_massage.dart';
// import 'package:task_manager/ui/widgets/task_card.dart';
// import 'package:task_manager/ui/widgets/task_summary_screen.dart';
//
// import '../../data/models/task_status_model.dart';
//
// class NewTaskScreen extends StatefulWidget {
//   const NewTaskScreen({super.key});
//
//   @override
//   State<NewTaskScreen> createState() => _NewTaskScreenState();
// }
//
// class _NewTaskScreenState extends State<NewTaskScreen> {
//   bool _newTaskListInProgress = false;
//   bool _newTaskStatusCountListInProgress = false;
//   List<TaskModel> _newTaskList = [];
//   List<TaskCountModel> _newTaskStatusList = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _getNewTaskList();
//     _getStatusContList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         _getStatusContList();
//         _getStatusContList();
//       },
//       child: Scaffold(
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: AppColor.ThemeColor,
//           onPressed: _OnTabFAB,
//           child: Icon(
//             Icons.add,
//             color: Colors.white,
//           ),
//         ),
//         body: Column(
//           children: [
//             _buildSummerySection(),
//             Expanded(
//               child: Visibility(
//                 visible: !_newTaskListInProgress,
//                 replacement: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 child: ListView.separated(
//                     itemBuilder: (context, index) {
//                       return TaskCard(
//                           taskModel: _newTaskList[index],
//                           onRefresh: _getStatusContList);
//                     },
//                     separatorBuilder: (context, index) {
//                       return const SizedBox(
//                         height: 15,
//                       );
//                     },
//                     itemCount: _newTaskList.length),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSummerySection() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Visibility(
//         visible: !_newTaskStatusCountListInProgress,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: _getTaskSummeryCard(),
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<TaskSummaryCard> _getTaskSummeryCard() {
//     List<TaskSummaryCard> taskSummeryCardList = [];
//     for (TaskCountModel t in _newTaskStatusList) {
//       taskSummeryCardList
//           .add(TaskSummaryCard(Title: t.sId!, Count: t.sum ?? 0));
//     }
//     return taskSummeryCardList;
//   }
//
//   void _OnTabFAB() async {
//     final bool? shouldRefresh = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddNewTaskScreen(),
//       ),
//     );
//     if (shouldRefresh == true) {
//       _getStatusContList();
//     }
//   }
//
//   Future<void> _getNewTaskList() async {
//     _newTaskList.clear();
//     _newTaskListInProgress = true;
//     setState(() {});
//     final NetworkResponse response =
//         await NetworkCaller.getRequest(Urls.newTaskList);
//
//     if (response.isSuccess) {
//       final TaskListModel taskListModel =
//           TaskListModel.fromJson(response.responseData);
//       _newTaskList = taskListModel.taskList ?? [];
//     } else {
//       ShowSnackBarMassage(context, response.errorMassage);
//     }
//     _newTaskListInProgress = false;
//     setState(() {});
//   }
//
//   Future<void> _getStatusContList() async {
//     _newTaskStatusList.clear();
//     setState(() {});
//     final NetworkResponse response =
//         await NetworkCaller.getRequest(Urls.taskStatusCount);
//
//     if (response.isSuccess) {
//       final TaskStatusCountModel taskStatusCountModel =
//           TaskStatusCountModel.fromJson(response.responseData);
//       _newTaskStatusList = taskStatusCountModel.TaskStatusCountList ?? [];
//     } else {
//       ShowSnackBarMassage(context, response.errorMassage);
//     }
//     _newTaskListInProgress = false;
//     setState(() {});
//   }
// }

import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/new_task_model.dart';
import 'package:task_manager/data/models/task_count_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/screen/add_new_task_screen.dart';
import 'package:task_manager/ui/utils/appcolors.dart';
import 'package:task_manager/ui/utils/urls.dart';
import 'package:task_manager/ui/widgets/snackbar_massage.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:task_manager/ui/widgets/task_summary_screen.dart';

import '../../data/models/task_status_model.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _newTaskListInProgress = false;
  bool _newStatusCountListInProgress = false;
  List<TaskModel> _newTaskList = [];
  List<TaskCountModel> _newStatusCountList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNewTaskList();
    _getStatusCountList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getNewTaskList();
      },
      child: Scaffold(
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
              child: Visibility(
                visible: !_newTaskListInProgress,
                replacement: Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskModel: _newTaskList[index],
                        onRefresh: () {
                          _newTaskList;
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemCount: _newTaskList.length),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSummerySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: !_newStatusCountListInProgress,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _getTaskSummeryCard(),
          ),
        ),
      ),
    );
  }

  List<TaskSummaryCard> _getTaskSummeryCard() {
    List<TaskSummaryCard> taskSummeryCardList = [];
    for (TaskCountModel t in _newStatusCountList) {
      taskSummeryCardList
          .add(TaskSummaryCard(Title: t.sId!, Count: t.sum ?? 0));
    }
    return taskSummeryCardList;
  }
  void _OnTabFAB() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewTaskScreen(),
      ),
    );
    if (shouldRefresh == true) {
      _getNewTaskList();
    }
  }

  Future<void> _getNewTaskList() async {
    _newTaskList.clear();
    _newTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.newTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _newTaskList = taskListModel.taskList ?? [];
    } else {
      ShowSnackBarMassage(context, response.errorMassage);
    }
    _newTaskListInProgress = false;
    setState(() {});
  }

  Future<void> _getStatusCountList() async {
    _newStatusCountList.clear();
    _newStatusCountListInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);

    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel =
           TaskStatusCountModel.fromJson(response.responseData);
       _newStatusCountList = taskStatusCountModel.TaskStatusCountList??[];
    } else {
      ShowSnackBarMassage(context, response.errorMassage);
    }
    _newStatusCountListInProgress = false;
    setState(() {});
  }
}
