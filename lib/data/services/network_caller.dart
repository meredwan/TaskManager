import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/auth/auth_controller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/ui/screen/sing_in_screen.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'token': AuthController.accessToken.toString()
      };
      printRequest(url, null, headers);
      final Response response = await get(uri, headers: headers);
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        if (decodeData['status'] == 'fail') {
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMassage: decodeData['data'],
          );
        }
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodeData);
      } else if (response.statusCode == 401) {
        _moveToLogin();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMassage: 'Unauthenticated');
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMassage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/Json',
        'token': AuthController.accessToken.toString()
      };

      printRequest(url, body, headers);
      final Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);

        if (decodeData['status'] == 'fail') {
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMassage: decodeData['data'],
          );
        }

        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        _moveToLogin();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMassage: 'Unauthenticated');
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMassage: e.toString(),
      );
    }
  }

  static void printRequest(
    String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  ) {
    debugPrint('Request:\n url: $url, \nBody:$body, \nheaders;$headers');
  }

  static void printResponse(String url, Response response) {
    debugPrint(
        'Request\n URL: $url, StatusCode: ${response.statusCode}, Body: ${response.body}');
  }

  static void _moveToLogin() {
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.NavigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => SingInScreen(),
        ),
        (route) => false);
  }
}
