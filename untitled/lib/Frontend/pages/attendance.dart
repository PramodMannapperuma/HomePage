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

  const Attendance({Key? key, required this.token}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  // final String? token = widget.token;
  // final token = widget.token;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime today = DateTime.now();

  Map<DateTime, List<Event>> events = {};
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _leaveTimeController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  late final ValueNotifier<List<Event>> _selectedEvents;
  late Future<List<AttendanceData>> futureAttendanceData;

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    futureAttendanceData =
        apiService.fetchAttendanceData(widget.token, _selectedDay!);
    print('Token in attendance is ${widget.token}');
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
        futureAttendanceData =
            apiService.fetchAttendanceData(widget.token, selectedDate);
        print('Token in onDaySelected ${widget.token}');
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
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
    print(
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}');
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _submitAttendance(String token, String selectedDay,
      String startTime, String leaveTime, String comment) async {
    final url = Uri.parse('${ApiService.baseUrl}/attendance'); // replace with your actual endpoint

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

        // Fetch updated attendance data
        futureAttendanceData = apiService.fetchAttendanceData(
            widget.token, DateTime.parse(selectedDay));
        // Update local state to reflect the changes immediately
        setState(() {
          events[_selectedDay!] = [
            Event(
              startTime,
              leaveTime,
              comment,
            )
          ];
          _selectedEvents.value = _getEventsForDay(_selectedDay!);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to submit attendance: ${response.statusCode} ${response.reasonPhrase}'),
            duration: Duration(seconds: 2),
          ),
        );
        print("Error in attendance ${response.statusCode} ${response.body}");
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
          content: Text('The connection has timed out. Please try again later.'),
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
    if (_selectedDay != null && !isSameDay(_selectedDay!, today)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You can only add attendance for today.'),
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
                          if (_selectedDay != null && isSameDay(_selectedDay!, today)) {
                            setState(() {
                              events[_selectedDay!] = [
                                Event(
                                  _startTimeController.text,
                                  _leaveTimeController.text,
                                  _commentController.text,
                                )
                              ];
                            });
                            DateTime selectedDay =
                                _selectedDay ?? DateTime.now();
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
                                content: Text('Attendance can only be added for today.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('All fields are required'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Text("Save"),
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
    switch (status) {
      case 'holiday':
        return Colors.black;
      case 'leave':
        return Colors.purple;
      case 'incomplete':
        return Colors.grey;
      case 'pending':
        return Color.fromRGBO(229, 165, 75, 1.0);
      case 'rejected':
        return Colors.red;
      case 'active-amd':
        return Colors.green;
      default:
        return Colors.grey; // Default color if none of the cases match
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
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
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
              Navigator.pushNamed(context, '/profile', arguments: widget.token);
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
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                todayDecoration: BoxDecoration(
                  color: Color(0xff4d2880),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color(0xff9575cd),
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Color(0xff9575cd),
                  shape: BoxShape.circle,
                ),
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
                          (element) => element.date == _selectedDay?.toString().split(" ")[0],
                      orElse: () => AttendanceData(
                          amdIn: 'N/A',
                          recIn: 'N/A',
                          amdOut: 'N/A',
                          comment: 'N/A',
                          recOut: 'N/A',
                          date: _selectedDay?.toString().split(" ")[0] ?? 'N/A',
                          status: 'N/A'));
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      color: _getStatusColor(selectedDateData.status),
                                    ),
                                  )
                                ],
                              ),
                              Divider(thickness: 1),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('AMD In: ${selectedDateData.amdIn ?? 'N/A'}',
                                          style: TextStyle(fontSize: screenWidth * 0.04)),
                                      SizedBox(height: 4.0),
                                      Text('AMD Out: ${selectedDateData.amdOut ?? 'N/A'}',
                                          style: TextStyle(fontSize: screenWidth * 0.04)),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Rec In: ${selectedDateData.recIn ?? 'N/A'}',
                                          style: TextStyle(fontSize: screenWidth * 0.04)),
                                      SizedBox(height: 4.0),
                                      Text('Rec Out: ${selectedDateData.recOut ?? 'N/A'}',
                                          style: TextStyle(fontSize: screenWidth * 0.04)),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(thickness: 1),
                              Text('Comment: ${selectedDateData.comment ?? 'N/A'}',
                                  style: TextStyle(fontSize: screenWidth * 0.04)),
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
