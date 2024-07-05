import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CalendarPage extends StatefulWidget {
  final String token;
  const CalendarPage({super.key, required this.token});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, List<dynamic>> _events = {};

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _fetchData();
  }

  Future<void> _fetchData() async {
    String token = widget.token; // Replace with your actual token
    DateTime selectedDate =
        DateTime.now(); // Replace with your actual selected date

    List<AttendanceData> attendanceData =
        await fetchAttendanceData(token, selectedDate);
    List<LeaveData> leaveData = await fetchLeaveData(token, selectedDate);

    setState(() {
      _events = {};

      // Map attendance data
      for (var attendance in attendanceData) {
        _events[attendance.date] = _events[attendance.date] ?? [];
        _events[attendance.date]!.add(attendance);
      }

      // Map leave data
      for (var leave in leaveData) {
        _events[leave.date] = _events[leave.date] ?? [];
        _events[leave.date]!.add(leave);
      }
    });
  }

  Future<List<AttendanceData>> fetchAttendanceData(
      String token, DateTime selectedDate) async {
    final response = await http.get(
      Uri.parse('http://hris.accelution.lk/api/attendance/$selectedDate'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body); 
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((item) => AttendanceData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get attendance');
    }
  }

  Future<List<LeaveData>> fetchLeaveData(
      String token, DateTime selectedDate) async {
    final response = await http.get(
      Uri.parse('http://hris.accelution.lk/api/leave/$selectedDate'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((item) => LeaveData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get leave');
    }
  }

  Widget _buildMarker(DateTime date, Color color) {
    return Positioned(
      bottom: 1,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        width: 16.0,
        height: 16.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        child: TableCalendar(
          rowHeight: 35,
          headerStyle: HeaderStyle(
            titleCentered: true,
          ),
          focusedDay: _focusedDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          onDaySelected: (selectedDate, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDate)) {
              setState(() {
                _selectedDay = selectedDate;
                _focusedDay = focusedDay;
              });
            }
          },
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          firstDay: DateTime.utc(2023, 01, 01),
          lastDay: DateTime.utc(3030, 12, 31),
          calendarFormat: _calendarFormat,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
          ),
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          eventLoader: (day) {
            return _events[day] ?? [];
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              if (events.isNotEmpty) {
                var event = events[0];
                if (event is AttendanceData) {
                  switch (event.status) {
                    case 'attended':
                      return _buildMarker(date, Colors.green);
                    case 'not noted':
                      return _buildMarker(date, Colors.yellow);
                    case 'no pay':
                      return _buildMarker(date, Colors.red);
                  }
                } else if (event is LeaveData) {
                  return _buildMarker(date, Colors.blue);
                }
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}

class AttendanceData {
  final DateTime date;
  final String? status;

  AttendanceData({required this.date, required this.status});

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      date: DateTime.parse(json['date']),
      status: json['status'],
    );
  }
}

class LeaveData {
  final DateTime date;
  final String? type;

  LeaveData({required this.date, required this.type});

  factory LeaveData.fromJson(Map<String, dynamic> json) {
    return LeaveData(
      date: DateTime.parse(json['date']),
      type: json['type'],
    );
  }
}
