import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/group.dart';
import '../models/progress.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  Future<User?> fetchUserData() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.get("userId") == null) return null;
    var userId = int.parse(pref.get("userId").toString());
    // print(userId.toString() + "dfg");
    final response = await UserService().getUser(userId);
    if (response.statusCode == 200) {
      User user = User.fromJson(response.body);
      pref.setString('user', response.body);
      pref.setString('role', user.role.name);
      pref.setString('userId', user.id.toString());
      state = user;
      return user;
    }
    return null;
  }

  Future<User?> updateUserDataFromPref() async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.get("userId") as int;
    final response = await UserService().getUser(userId);
    if (response.statusCode == 200) {
      User user = User.fromJson(response.body);
      final pref = await SharedPreferences.getInstance();
      pref.setString('user', response.body);
      pref.setString('role', user.role.name);
      pref.setString('userId', user.id.toString());
      state = user;
    }
    return state;
  }

  updateProgess(List<Progress> progressList) {
    state = state?.copyWith(progressList: progressList);
  }

  User? get() => state;

  logout() {
    state = null;
  }
}

final homeMessageProvider =
    StateNotifierProvider<HomeMessageNotifier, Map<String, dynamic>>(
        (ref) => HomeMessageNotifier());

class HomeMessageNotifier extends StateNotifier<Map<String, dynamic>> {
  HomeMessageNotifier() : super({});

  fetchMessages(int userId) async {
    final response = await UserService().homeMessagge(userId);
    if (response.statusCode == 200) {
      // state
      final res = json.decode(response.body) as Map<String, dynamic>;
      state = res;
      return state;
    }
    return {};
  }

  get() => state;
}

final progressListProvider =
    StateNotifierProvider<TodaysProgressNotifier, List<Progress>?>(
        (ref) => TodaysProgressNotifier());

class TodaysProgressNotifier extends StateNotifier<List<Progress>?> {
  TodaysProgressNotifier() : super(null);

  Future<List<Progress>?> fetchProgress(int userId) async {
    final response = await UserService().getTodaysProgress(userId);
    if (response.statusCode == 200) {
      final res = List<Progress>.from(
          (json.decode(response.body) as List<dynamic>)
              .map((e) => Progress.fromMap(e as Map<String, dynamic>))
              .toList());
      state = res;
    }
    return state;
  }

  List<Progress>? get() => state;
}

final progressDetailsProvider =
    StateNotifierProvider<ProgressDetailsNotifier, Map<String, dynamic>>(
        (ref) => ProgressDetailsNotifier());

class ProgressDetailsNotifier extends StateNotifier<Map<String, dynamic>> {
  ProgressDetailsNotifier() : super({});

  fetchProgress(int userId) async {
    final response = await UserService().getProgressDetails(userId);
    if (response.statusCode == 200) {
      final map = json.decode(response.body) as Map<String, dynamic>;
      state = map;
      return state;
    }
    return {};
  }

  get() => state;
}

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, List<Message>>(
        (ref) => NotificationNotifier());

class NotificationNotifier extends StateNotifier<List<Message>> {
  NotificationNotifier() : super([]);

  fetchNotification(int userId) async {
    final response = await UserService().getNotification(userId);
    if (response.statusCode == 200) {
      final res = List<Message>.from(
          (json.decode(response.body) as List<dynamic>)
              .map((e) => Message.fromMap(e)));
      state = res;
      print(res);
      return state;
    }
    return {};
  }

  get() => state;
}
