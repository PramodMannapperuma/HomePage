import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:untitled/Backend/models/leave_model.dart';
import 'package:untitled/Backend/models/leave_balance_model.dart';
import 'package:untitled/Backend/models/leave_types.dart';
import '../models/att_approval.dart';
import '../models/att_model.dart';
import '../models/cover_ups.dart';
import '../models/dash_model.dart';
import '../models/leave_approval.dart';
import '../models/policy_model.dart';
import '../models/approval_items.dart';
import '../models/subordinate_model.dart';
import '../models/team_member_model.dart';

class ApiService {
  static const String _baseUrl = 'http://hris.accelution.lk/api';
  static String get baseUrl => _baseUrl;

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
  // New method to fetch team members' details
  static Future<List<TeamMember>> fetchTeamMembers(String token) async {
    try {
      final response = await http
          .get(
        Uri.parse('$_baseUrl/team'),
        headers: _headers(token),
      )
          .timeout(Duration(seconds: 60));

      _logResponse(response);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => TeamMember.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load team members: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching team members: $e');
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
          dataList = jsonDecode(data) as List<dynamic>;
        } else if (data is List) {
          dataList = data as List<dynamic>;
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
      Uri.parse('$baseUrl/profile-picture'),
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

  Future<List<LeaveType>> fetchLeaveTypes(String token) async {
    // Replace with your API endpoint
    final response = await http.get(
      Uri.parse('$baseUrl/leave-types'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    _logResponse(response);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      return data.map((json) => LeaveType.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load leave types');
    }
  }

  Future<List<CoverUp>> fetchCoverUps(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/coverups'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    _logResponse(response);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> coverups = jsonResponse['data'];
      return coverups.map((dynamic item) => CoverUp.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load cover-ups');
    }
  }

  Future<List<Policy>> fetchPolicies(String token) async {
    // final String url = 'http://hris.accelution.lk/api/policies?length=10&start=0';

    final response = await http.get(
      Uri.parse('$baseUrl/policies?length=10&start=0'),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );
    _logResponse(response);

    if (response.statusCode == 200) {
      // Parse the JSON response into a list of policies.
      List<dynamic> body = jsonDecode(response.body);
      List<Policy> policies = body.map((dynamic item) => Policy.fromJson(item)).toList();
      return policies;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load policies');
    }
  }

  Future<String> fetchPolicy(String token) async {
    final url = Uri.parse('http://hris.accelution.lk/api/view-policy/1.pdf');

    try {
      final response = await http.get(
        url,
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/1.pdf';
        final pdfFile = File(filePath);
        await pdfFile.writeAsBytes(response.bodyBytes);
        return filePath;
      } else {
        throw Exception('Failed to download PDF. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching PDF: $e');
    }
  }

  Future<List<Subordinate>> fetchSubordinates(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/team/subordinates'),
        headers: _headers(token),
      ).timeout(Duration(seconds: 60));

      _logResponse(response);

      if (response.statusCode == 200) {
        // Directly decode the response body to a List
        List<dynamic> data = json.decode(response.body);

        // Map the dynamic list to a list of Subordinate objects
        return data.map((item) => Subordinate.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load subordinates: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching subordinates: $e');
    }
  }


  static Future<List<ApprovalItem>> fetchPendingApprovals(String token) async {

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/approvals/pending?length=10&start=0'),
        headers: _headers(token),
      );

      _logResponse(response);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => ApprovalItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load pending approvals: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching pending approvals: $e');
    }
  }

  // Fetch leave requests for a specific employee
  Future<List<LeaveApproval>> fetchLeaveRequests(String employeeId, String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/approvals/leave?length=10&start=0&employeeId=$employeeId'),
      headers: _headers(token),
    ).timeout(Duration(seconds: 60));

    _logResponse(response);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => LeaveApproval.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load leave requests');
    }
  }

  // Fetch attendance records for a specific employee
  Future<List<AttApproval>> fetchAttendanceRecords(String employeeId, String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/approvals/attendance?length=10&start=0&employeeId=$employeeId'),
      headers: _headers(token),
    ).timeout(Duration(seconds: 60));

    _logResponse(response);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => AttApproval.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load attendance records');
    }
  }
}



