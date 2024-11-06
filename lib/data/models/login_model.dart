import 'user_data_model.dart';

class LoginModel {
  String? status;
  UserModel? data;
  String? token;

  LoginModel({this.status, this.data, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new UserModel.fromJson(json['data']);
    } else {
      data = null;
    }
    token = json['token'];
  }
}
