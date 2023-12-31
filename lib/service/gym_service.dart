import 'package:gympact/constants/constants.dart';
import 'package:gympact/models/diet.dart';
import 'package:gympact/models/package.dart';
import 'package:http/http.dart' as http;

import '../models/group.dart';

class GymService {
  var client = http.Client();

  String baseUrl = Constant.baseUrl;

  Future<http.Response> getGymDetails(int userId) async {
    var url = Uri.parse("$baseUrl/gym/getGymByUserId?userId=$userId");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> getPackageEnded(int id) async {
    var url = Uri.parse("$baseUrl/gym/getPackageEnded?id=$id");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> getPackageEndsInDays(int id) async {
    var url = Uri.parse("$baseUrl/gym/getPackageEndsInDays?id=$id");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> attendanceDetails(int id) async {
    var url = Uri.parse("$baseUrl/gym/attendanceDetails?id=$id");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> statistic(int id) async {
    var url = Uri.parse("$baseUrl/gym/statistic?id=$id");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> progressDetails(int id) async {
    var url = Uri.parse("$baseUrl/gym/progressDetails?id=$id");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> savePackage(int gymId, Package package) async {
    var url = Uri.parse("$baseUrl/gym/savePackage?id=$gymId");
    var response = await client.post(url,
        headers: {"Content-Type": "application/json"}, body: package.toJson());
    return response;
  }

  Future<http.Response> saveDiet(int gymId, Diet diet) async {
    var url = Uri.parse("$baseUrl/gym/saveDiet?id=$gymId");
    var response = await client.post(url,
        headers: {"Content-Type": "application/json"}, body: diet.toJson());
    return response;
  }

  Future<http.Response> createGroup(int id, String groupName) async {
    var url = Uri.parse("$baseUrl/gym/saveGroup?id=$id&groupName=$groupName");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> addMember(int groupId, int userId) async {
    var url =
        Uri.parse("$baseUrl/gym/addMember?groupId=$groupId&userId=$userId");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> getGroups(int id) async {
    var url = Uri.parse("$baseUrl/gym/getGroups?id=$id");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> notifyGroup(int groupId, Message message) async {
    var url = Uri.parse("$baseUrl/gym/notifyGroup?groupId=$groupId");
    var response = await client.post(url,
        headers: {"Content-Type": "application/json"}, body: message.toJson());
    return response;
  }
}
