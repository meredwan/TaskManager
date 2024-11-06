class Urls {
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';

  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createTask = '$_baseUrl/createTask';
  static const String newTaskList = '$_baseUrl/listTaskByStatus/New';
  static const String completedTaskList = '$_baseUrl/listTaskByStatus/Completed';
  static const String canceledTaskList = '$_baseUrl/listTaskByStatus/Canceled';
  static const String progressTaskList = '$_baseUrl/listTaskByStatus/Progress';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount';
  static const String ProfileUpdate = '$_baseUrl/ProfileUpdate';
  static const String RecoverResetPassword = '$_baseUrl/RecoverResetPassword';
  static  String RecoverVerifyEmail(String emailUrl) => '$_baseUrl/RecoverVerifyEmail/$emailUrl';
  static  String RecoverVerifyOtp(String emailUrl, String otp) => '$_baseUrl/RecoverVerifyEmail/$emailUrl/$otp';


  static  String changeStatusTaskList(String TaskId, String Status) =>
      '$_baseUrl/updateTaskStatus/$TaskId/$Status';

  static  String deleteTaskList(String TaskId) =>
      '$_baseUrl/deleteTask/$TaskId';
}