// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:untitled/Backend/models/leave_model.dart';
// import '../models/att_model.dart';
// import '../models/dash_model.dart';

// class ApiService {
//   static const String _baseUrl = 'http://hris.accelution.lk/api';

//   static Map<String, String> _headers(String token) => {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       };

//   static Future<Map<String, dynamic>> getProfile(String token) async {
//     final response = await http.get(
//       Uri.parse('$_baseUrl/profile'),
//       headers: _headers(token),
//     );

//     _logResponse(response);

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load profile: ${response.reasonPhrase}');
//     }
//   }

//   Future<DashboardData> fetchDashboardData(String token) async {
//     final response = await http.get(
//       Uri.parse('$_baseUrl/dashboard'),
//       headers: _headers(token),
//     );

//     _logResponse(response);

//     if (response.statusCode == 200) {
//       return DashboardData.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception(
//           'Failed to load dashboard data: ${response.reasonPhrase}');
//     }
//   }

//   Future<List<AttendanceData>> fetchAttendanceData(
//       String token, DateTime selectedDate) async {
//     final formattedDate = _formatDate(selectedDate);
//     final response = await http.get(
//       Uri.parse('$_baseUrl/attendance/$formattedDate'),
//       headers: _headers(token),
//     );

//     _logResponse(response);

//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body)['data'];
//       return data.map((item) => AttendanceData.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to get attendance: ${response.reasonPhrase}');
//     }
//   }

//   Future<List<LeaveData>> fetchLeaveData(
//       String token, DateTime selectedDate) async {
//     final formattedDate = _formatDate(selectedDate);
//     final response = await http.get(
//       Uri.parse('$_baseUrl/leave/$formattedDate'),
//       headers: _headers(token),
//     );

//     _logResponse(response);

//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body)['data'];
//       return data.map((item) => LeaveData.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to get leave: ${response.reasonPhrase}');
//     }
//   }

//   static void _logResponse(http.Response response) {
//     print('Status code: ${response.statusCode}');
//     print('Response body: ${response.body}');
//   }

//   static String _formatDate(DateTime date) {
//     return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//   }
// }

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:untitled/Backend/models/leave_model.dart';
import 'package:untitled/Backend/models/leave_balance_model.dart';
import '../models/att_model.dart';
import '../models/dash_model.dart';

class ApiService {
  static const String _baseUrl = 'http://hris.accelution.lk/api';

  static Map<String, String> _headers(String token) => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

  static Future<Map<String, dynamic>> getProfile(String token) async {
    try {
      final response = await http
          .get(
            Uri.parse('$_baseUrl/profile'),
            headers: _headers(token),
          )
          .timeout(Duration(seconds: 60)); // Adjust timeout as needed

      _logResponse(response);

      if (response.statusCode == 200) {
        try {
          return json.decode(response.body) as Map<String, dynamic>;
        } catch (e) {
          throw Exception('Failed to parse profile data: $e');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized access - invalid token');
      } else {
        throw Exception(
            'Failed to load profile: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching the profile: $e');
    }
  }

  static void _logResponse(http.Response response) {
    print('Status code: ${response.statusCode}');

    final body = response.body;

    try {
      final decodedBody = utf8.decode(response.bodyBytes);

      const int chunkSize = 1000;
      for (int i = 0; i < decodedBody.length; i += chunkSize) {
        final end = (i + chunkSize < decodedBody.length)
            ? i + chunkSize
            : decodedBody.length;
        print(decodedBody.substring(i, end));
      }
    } catch (e) {
      print('Error decoding response body: $e');
    }
  }

  Future<DashboardData> fetchDashboardData(String token) async {
    final response = await http
        .get(
          Uri.parse('$_baseUrl/dashboard'),
          headers: _headers(token),
        )
        .timeout(Duration(seconds: 60));

    _logResponse(response);

    if (response.statusCode == 200) {
      try {
        return DashboardData.fromJson(jsonDecode(response.body));
      } catch (e) {
        throw Exception('Failed to parse dashboard data: $e');
      }
    } else {
      throw Exception(
          'Failed to load dashboard data: ${response.reasonPhrase}');
    }
  }

  Future<List<AttendanceData>> fetchAttendanceData(
      String token, DateTime selectedDate) async {
    final formattedDate = _formatDate(selectedDate);
    final response = await http
        .get(
          Uri.parse('$_baseUrl/attendance/$formattedDate'),
          headers: _headers(token),
        )
        .timeout(Duration(seconds: 60));

    _logResponse(response);

    if (response.statusCode == 200) {
      try {
        List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((item) => AttendanceData.fromJson(item)).toList();
      } catch (e) {
        throw Exception('Failed to parse attendance data: $e');
      }
    } else {
      throw Exception('Failed to get attendance: ${response.reasonPhrase}');
    }
  }

  Future<List<LeaveData>> fetchLeaveData(String token, DateTime selectedDate) async {
    final formattedDate = _formatDate(selectedDate);
    final response = await http
        .get(
      Uri.parse('$_baseUrl/leave/$formattedDate'),
      headers: _headers(token),
    )
        .timeout(Duration(seconds: 60));

    _logResponse(response);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        final data = jsonResponse['data'];
        List<dynamic> dataList;

        if (data is String) {
          dataList = jsonDecode(data) as List<dynamic>; // Decode if data is a string
        } else if (data is List) {
          dataList = data as List<dynamic>; // Use directly if data is already a list
        } else {
          throw Exception('Unexpected data format');
        }

        return dataList.map((item) => LeaveData.fromJson(item)).toList();
      } catch (e) {
        throw Exception('Failed to parse leave data: $e');
      }
    } else {
      throw Exception('Failed to get leave: ${response.reasonPhrase}');
    }
  }

  Future<List<LeaveBalanceData>> fetchLeaveBalance(String token) async {
    final response = await http
        .get(
      Uri.parse('$_baseUrl/leavebalance'),
      headers: _headers(token),
    )
        .timeout(Duration(seconds: 60));

    _logResponse(response);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        final data = jsonResponse['data'];
        List<dynamic> dataList;

        if (data is String) {
          dataList = jsonDecode(data) as List<dynamic>; // Decode if data is a string
        } else if (data is List) {
          dataList = data as List<dynamic>; // Use directly if data is already a list
        } else {
          throw Exception('Unexpected data format');
        }

        return dataList.map((item) => LeaveBalanceData.fromJson(item)).toList();
      } catch (e) {
        throw Exception('Failed to parse leave balance data: $e');
      }
    } else {
      throw Exception('Failed to get leave balance: ${response.reasonPhrase}');
    }
  }


  static String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  static Future<Uint8List> fetchProfilePicture(String token) async {
    final response = await http.get(
      Uri.parse('http://hris.accelution.lk/api/profile-picture'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: 60));
    print('token: $token');

    _logResponse(response);

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load profile picture');
    }
  }
}
