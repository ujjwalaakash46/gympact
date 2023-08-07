import 'package:gympact/constants/constants.dart';
import 'package:gympact/models/workout.dart';
import 'package:http/http.dart' as http;

class WorkoutService {
  var client = http.Client();

  String baseUrl = Constant.baseUrl;

  Future<http.Response> getGymWorkouts(int gymId) async {
    var url = Uri.parse("$baseUrl/workout/listForGym?gymId=$gymId");
    var response = await client.get(url);
    return response;
  }

  Future<http.Response> saveWorkout(int userId, Workout workout) async {
    var url = Uri.parse("$baseUrl/workout/?userId=$userId");
    var response = await client.post(url,
        headers: {"Content-Type": "application/json"}, body: workout.toJson());
    return response;
  }
}
