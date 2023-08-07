import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gympact/constants/constants.dart';
import 'package:gympact/models/past_workout.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/progress.dart';

class UserService {
  var client = http.Client();

  String baseUrl = Constant.baseUrl;

  Future<http.Response> checkPhone(String phone) async {
    var url = Uri.parse("$baseUrl/user/checkPhone");
    var response = await client.post(url, body: phone);
    return response;
  }

  Future<http.Response> checkSignUp(Map<String, String> singup) async {
    var url = Uri.parse("$baseUrl/user/signup");
    var response = await client.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(singup));
    return response;
  }

  Future<http.Response> checkLogin(Map<String, String> login) async {
    var url = Uri.parse("$baseUrl/user/login");
    var response = await client.post(url,
        headers: {"Content-Type": "application/json"}, body: jsonEncode(login));
    return response;
  }

  Future<http.Response> getUser(int userId) async {
    var url = Uri.parse("$baseUrl/user/getUser?id=$userId");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> searchUser(int gymId, String query) async {
    var url = Uri.parse("$baseUrl/user/search?gymId=$gymId&query=$query");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> updateUserData(int gymId, User user) async {
    var url = Uri.parse("$baseUrl/user/save?gymId=$gymId");
    var response = await client.post(url,
        headers: {"Content-Type": "application/json"}, body: user.toJson());
    return response;
  }

  Future<http.Response> savePastWorkout(int id, PastWorkout pastWorkout) async {
    var url = Uri.parse("$baseUrl/user/savePastWorkout?id=$id");
    var response = await client.post(url,
        headers: {"Content-Type": "application/json"},
        body: pastWorkout.toJson());
    return response;
  }

  Future<http.Response> birthdayList(int gymId) async {
    var url = Uri.parse("$baseUrl/user/birthday?gymId=$gymId");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> homeMessagge(int id) async {
    var url = Uri.parse("$baseUrl/user/homeMessagge?id=$id ");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> getNotification(int id) async {
    var url = Uri.parse("$baseUrl/user/getNotification?id=$id ");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> getTodaysProgress(int id) async {
    var url = Uri.parse("$baseUrl/user/userProgress?id=$id ");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> getProgressDetails(int id) async {
    var url = Uri.parse("$baseUrl/user/progressDetails?id=$id ");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> saveTodaysProgress(Progress progress, int id) async {
    var url = Uri.parse("$baseUrl/user/addProgress?id=$id ");
    var response = await client.post(url,
        headers: {"Content-Type": "application/json"}, body: progress.toJson());
    return response;
  }

  Future<http.Response> thisMonthStreakList(int gymId) async {
    var url = Uri.parse("$baseUrl/gym/thisMonthStreakList?id=$gymId ");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> highAchieverList(int gymId) async {
    var url = Uri.parse("$baseUrl/user/highAchieverList?gymId=$gymId ");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> checkTodaysAttendance(int id) async {
    var url = Uri.parse("$baseUrl/user/checkTodaysAttendance?id=$id");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> markAttendance(int id) async {
    var url = Uri.parse("$baseUrl/user/markAttendance?id=$id");
    var response = await client.get(url);
    return response;
  }

  Future<StreamedResponse> uploadProfileImg(int userId, File file) async {
    var url = Uri.parse("$baseUrl/user/uploadProfileImg");
    List<int> imageBytes = await file.readAsBytes();

    var request = http.MultipartRequest("POST", url);
    var multipartFile = http.MultipartFile.fromBytes(
      'img',
      imageBytes,
      filename: 'image.jpg',
    );
    request.fields['id'] = userId.toString();
    request.files.add(multipartFile);
    var response = await request.send();

    return response;
  }

  logout(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.loginScreenRoute, (route) => false);
    }
  }
}
