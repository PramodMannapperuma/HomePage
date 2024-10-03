import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled/Backend/APIs/Apis.dart';
import '../../Backend/models/att_model.dart';
import '../app_bar.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';

class Attendance extends StatefulWidget {
  final String token;
  final bool isFromSidebar;

  const Attendance({Key? key, required this.token, this.isFromSidebar = false})
      : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  static const Color incompleteColor = Colors.grey;
  static const Color amendmentColor = Colors.blue;
  static const Color pendingColor = Colors.amber;
  static const Color rejectedColor = Colors.red;
  static const Color attendanceColor = Colors.green;
  static const Color holidayColor = Colors.black;
  static const Color leaveColor = Colors.purple;

  final Map<String, Color> statusColorMap = {
    'incomplete': incompleteColor,
    'amendment': amendmentColor,
    'pending': pendingColor,
    'rejected': rejectedColor,
    'active-amd': attendanceColor,
    'holiday': holidayColor,
    'leave': leaveColor,
  };

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime today = DateTime.now();
  final Map<DateTime, String> _attendanceStatus = {};

  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _leaveTimeController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  late final ValueNotifier<List<Event>> _selectedEvents;
  late Future<List<AttendanceData>> futureAttendanceData;

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();

    // Initialize the futureLeaveData with an empty Future to prevent LateInitializationError
    futureAttendanceData = _loadMonthlyAttendanceData(_focusedDay);

    _selectedDay = _focusedDay;

    // Fetch leave data for the current month on init
    _selectedEvents = ValueNotifier([]);
  }

  Future<List<AttendanceData>> _loadMonthlyAttendanceData(
      DateTime focusedDay) async {
    DateTime startOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);

    try {
      final List<AttendanceData> data =
      await apiService.fetchAttendanceData(widget.token, startOfMonth);
      setState(() {
        _attendanceStatus.clear();
        for (var attendance in data) {
          if (attendance.date != null) {
            final DateTime date = DateTime.parse(attendance.date!);
            _attendanceStatus[DateTime(date.year, date.month, date.day)] =
                attendance.status ?? 'incomplete';
          }
        }
      });
      return data;
    } catch (e) {
      print('Error loading attendance data: $e');
      return [];
    }
  }

  @override
  void dispose() {
    _startTimeController.dispose();
    _leaveTimeController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDate, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDate)) {
      setState(() {
        _selectedDay = selectedDate;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDate);

        // Fetch attendance data for the selected day
        futureAttendanceData = apiService.fetchAttendanceData(widget.token, selectedDate);
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return [];
  }

  String formatTimeOfDayTo24Hour(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _submitAttendance(String token, String selectedDay,
      String startTime, String leaveTime, String comment) async {
    final url = Uri.parse('${ApiService.baseUrl}/attendance');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode([
          {
            'date': selectedDay,
            'data': {
              'amd_in': startTime,
              'amd_out': leaveTime,
              'comment': comment,
            }
          }
        ]),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Attendance submitted successfully!'),
            duration: Duration(seconds: 2),
          ),
        );

        // Fetch updated attendance data and refresh UI
        await _loadMonthlyAttendanceData(_focusedDay);
        setState(() {
          _selectedEvents.value = _getEventsForDay(_selectedDay!);
          futureAttendanceData = apiService.fetchAttendanceData(widget.token, _focusedDay);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to submit attendance: ${response.statusCode} ${response.reasonPhrase}'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No internet connection. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    } on TimeoutException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
          Text('The connection has timed out. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _showAddAttendanceBottomSheet(BuildContext context) async {
    if (_selectedDay != null && _selectedDay!.isAfter(today)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You cannot add attendance for future dates.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_selectedDay != null &&
        (_selectedDay!.weekday == DateTime.saturday ||
            _selectedDay!.weekday == DateTime.sunday)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You cannot add attendance for weekends.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Add your custom holiday logic here
    final holidays = <DateTime>[
      DateTime(today.year, 1, 1), // New Year's Day
      DateTime(today.year, 12, 25), // Christmas
      // Add more holidays here
    ];

    if (_selectedDay != null && holidays.contains(_selectedDay)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You cannot add attendance for holidays.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add Attendance",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _startTimeController,
                  decoration: InputDecoration(
                    labelText: "Starting Time",
                  ),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      _startTimeController.text =
                          formatTimeOfDayTo24Hour(pickedTime);
                    }
                  },
                ),
                TextField(
                  controller: _leaveTimeController,
                  decoration: InputDecoration(
                    labelText: "Leaving Time",
                  ),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      _leaveTimeController.text =
                          formatTimeOfDayTo24Hour(pickedTime);
                    }
                  },
                ),
                TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    labelText: "Comment",
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(14.0),
                        backgroundColor: Color(0xff4d2880),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_startTimeController.text.isNotEmpty &&
                            _leaveTimeController.text.isNotEmpty &&
                            _commentController.text.isNotEmpty) {
                          setState(() {
                            _selectedEvents.value = [
                              Event(
                                _startTimeController.text,
                                _leaveTimeController.text,
                                _commentController.text,
                              )
                            ];
                          });
                          DateTime selectedDay = _selectedDay ?? DateTime.now();
                          _submitAttendance(
                            widget.token,
                            selectedDay.toString().split(" ")[0],
                            _startTimeController.text,
                            _leaveTimeController.text,
                            _commentController.text,
                          );
                          _startTimeController.clear();
                          _leaveTimeController.clear();
                          _commentController.clear();
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('All fields are required'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String? status) {
    return statusColorMap[status] ?? Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: widget.isFromSidebar
          ? customAppBar(
        title: 'Attendance',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true,
      )
          : AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/hrislogo2.png',
              height: isPortrait ? 40.0 : 30.0,
            ),
            SizedBox(width: 8.0),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(35.0),
          child: Column(
            children: [
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Text(
                  "Attendance",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 0.2,
              ),
            ],
          ),
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: IconButton(
                icon: const Icon(
                  Icons.menu_outlined,
                  color: AppColors.background,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: AppColors.background,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/profile',
                  arguments: widget.token);
            },
          ),
        ],
      ),
      drawer: CustomSidebar(token: widget.token),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff4d2880),
        onPressed: () {
          _showAddAttendanceBottomSheet(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            child: TableCalendar(
              rowHeight: 40,
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: Color(0xff4d2880),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                ),
                titleTextStyle: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4d2880),
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Color(0xff4d2880),
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Color(0xff4d2880),
                ),
              ),
              focusedDay: _focusedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: _onDaySelected,
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              firstDay: DateTime.utc(2023, 01, 01),
              lastDay: DateTime.utc(3030, 12, 31),
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final status =
                  _attendanceStatus[DateTime(day.year, day.month, day.day)];
                  final color = _getStatusColor(status);

                  return Container(
                    margin: const EdgeInsets.all(6.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${day.day}',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
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
                _loadMonthlyAttendanceData(focusedDay); // Reload data when page changes
              },
            ),
          ),
          SizedBox(height: 10.0),
          Divider(
            thickness: 1,
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: FutureBuilder<List<AttendanceData>>(
              future: futureAttendanceData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  final data = snapshot.data!;
                  final selectedDateData = data.firstWhere(
                        (element) =>
                    element.date == _selectedDay?.toString().split(" ")[0],
                    orElse: () => AttendanceData(
                      amdIn: 'N/A',
                      recIn: 'N/A',
                      amdOut: 'N/A',
                      comment: 'N/A',
                      recOut: 'N/A',
                      date: _selectedDay?.toString().split(" ")[0] ?? 'N/A',
                      status: 'N/A',
                    ),
                  );
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.02,
                    ),
                    child: SizedBox(
                      height: screenHeight * 0.3,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Date: ${selectedDateData.date}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.044,
                                    ),
                                  ),
                                  Text(
                                    'Status: ${selectedDateData.status ?? 'N/A'}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.044,
                                      color: _getStatusColor(
                                          selectedDateData.status),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(thickness: 1),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'AMD In: ${selectedDateData.amdIn ?? 'N/A'}',
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.04),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        'AMD Out: ${selectedDateData.amdOut ?? 'N/A'}',
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.04),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rec In: ${selectedDateData.recIn ?? 'N/A'}',
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.04),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        'Rec Out: ${selectedDateData.recOut ?? 'N/A'}',
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.04),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Comment: ${selectedDateData.comment ?? 'N/A'}',
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Event {
  final String startTime;
  final String leaveTime;
  final String comment;
  Event(this.startTime, this.leaveTime, this.comment);
}