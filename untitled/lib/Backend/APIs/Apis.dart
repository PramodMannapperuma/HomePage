import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/Backend/models/leave_model.dart';
import '../models/att_model.dart';
import '../models/dash_model.dart';

class ApiService {
  static const String _baseUrl = 'http://hris.accelution.lk/api';

  static Map<String, String> _headers(String token) => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

  static Future<Map<String, dynamic>> getProfile(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/profile'),
      headers: _headers(token),
    );

    _logResponse(response);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load profile: ${response.reasonPhrase}');
    }
  }

  Future<DashboardData> fetchDashboardData(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/dashboard'),
      headers: _headers(token),
    );

    _logResponse(response);

    if (response.statusCode == 200) {
      return DashboardData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to load dashboard data: ${response.reasonPhrase}');
    }
  }

  Future<List<AttendanceData>> fetchAttendanceData(
      String token, DateTime selectedDate) async {
    final formattedDate = _formatDate(selectedDate);
    final response = await http.get(
      Uri.parse('$_baseUrl/attendance/2024-07-01'),
      headers: _headers(token),
    );

    _logResponse(response);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((item) => AttendanceData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get attendance: ${response.reasonPhrase}');
    }
  }

  Future<List<LeaveData>> fetchLeaveData(
      String token, DateTime selectedDate) async {
    final formattedDate = _formatDate(selectedDate);
    final response = await http.get(
      Uri.parse('$_baseUrl/leave/$formattedDate'),
      headers: _headers(token),
    );

    _logResponse(response);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((item) => LeaveData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get leave: ${response.reasonPhrase}');
    }
  }

  static void _logResponse(http.Response response) {
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  static String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
