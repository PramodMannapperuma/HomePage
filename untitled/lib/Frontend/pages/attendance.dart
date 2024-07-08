// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:untitled/Backend/APIs/Apis.dart';
// import '../../Backend/models/att_model.dart';
// import '../app_bar.dart';
// import '../styles/sidebar.dart';
//
//
// class Attendance extends StatefulWidget {
//   final String token;
//
//   const Attendance({Key? key, required this.token}) : super(key: key);
//
//   @override
//   State<Attendance> createState() => _AttendanceState();
// }
//
// class _AttendanceState extends State<Attendance> {
//
//   // final String? token = widget.token;
//   // final token = widget.token;
//
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   DateTime today = DateTime.now();
//
//   Map<DateTime, List<Event>> events = {};
//   TextEditingController _eventController = TextEditingController();
//   TextEditingController _startTimeController = TextEditingController();
//   TextEditingController _leaveTimeController = TextEditingController();
//
//   late final ValueNotifier<List<Event>> _selectedEvents;
//   late Future<List<AttendanceData>> futureAttendanceData;
//
//   final ApiService apiService = ApiService();
//
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = _focusedDay;
//     _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
//     futureAttendanceData =
//         apiService.fetchAttendanceData(widget.token, _selectedDay!);
//     print('Token in attendance is ${widget.token}');
//
//   }
//
//
//   @override
//   void dispose() {
//     _eventController.dispose();
//     _startTimeController.dispose();
//     _leaveTimeController.dispose();
//     super.dispose();
//   }
//
//   void _onDaySelected(DateTime selectedDate, DateTime focusedDay) {
//     if (!isSameDay(_selectedDay, selectedDate)) {
//       setState(() {
//         _selectedDay = selectedDate;
//         _focusedDay = focusedDay;
//         _selectedEvents.value = _getEventsForDay(selectedDate);
//         futureAttendanceData =
//             apiService.fetchAttendanceData(widget.token, selectedDate);
//         print('Token in ondayselected${widget.token}');
//       });
//     }
//   }
//
//   List<Event> _getEventsForDay(DateTime day) {
//     return events[day] ?? [];
//   }
//
//   Future<void> _showAddAttendanceBottomSheet(BuildContext context) async {
//     await showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return Padding(
//           padding:
//           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "Add Attendance",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: _startTimeController,
//                   decoration: InputDecoration(
//                     labelText: "Starting Time",
//                   ),
//                   onTap: () async {
//                     TimeOfDay? pickedTime = await showTimePicker(
//                       context: context,
//                       initialTime: TimeOfDay.now(),
//                     );
//                     if (pickedTime != null) {
//                       _startTimeController.text = pickedTime.format(context);
//                     }
//                   },
//                 ),
//                 TextField(
//                   controller: _leaveTimeController,
//                   decoration: InputDecoration(
//                     labelText: "Leaving Time",
//                   ),
//                   onTap: () async {
//                     TimeOfDay? pickedTime = await showTimePicker(
//                       context: context,
//                       initialTime: TimeOfDay.now(),
//                     );
//                     if (pickedTime != null) {
//                       _leaveTimeController.text = pickedTime.format(context);
//                     }
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text(
//                         "Cancel",
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.all(14.0),
//                         backgroundColor: Color(0xff4d2880),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: () {
//                         if (_startTimeController.text.isNotEmpty &&
//                             _leaveTimeController.text.isNotEmpty) {
//                           setState(() {
//                             events[_selectedDay!] = [
//                               Event(
//                                 _startTimeController.text,
//                                 _leaveTimeController.text,
//                               )
//                             ];
//                           });
//
//                           _startTimeController.clear();
//                           _leaveTimeController.clear();
//                           Navigator.of(context).pop();
//                           _selectedEvents.value =
//                               _getEventsForDay(_selectedDay!);
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content:
//                               Text("Please enter Start and Leaving times"),
//                               duration: Duration(seconds: 2),
//                             ),
//                           );
//                         }
//                       },
//                       child: Text(
//                         "Submit",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(
//         title: 'Attendance',
//         showActions: true,
//         showLeading: true,
//         context: context,
//         showBackButton: true,
//       ),
//       drawer: CustomSidebar(),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Color(0xff4d2880),
//         onPressed: () {
//           _showAddAttendanceBottomSheet(context);
//         },
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             child: TableCalendar(
//               rowHeight: 45,
//               headerStyle: HeaderStyle(
//                 titleCentered: true,
//               ),
//               focusedDay: _focusedDay,
//               startingDayOfWeek: StartingDayOfWeek.monday,
//               onDaySelected: _onDaySelected,
//               availableGestures: AvailableGestures.all,
//               selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//               firstDay: DateTime.utc(2023, 01, 01),
//               lastDay: DateTime.utc(3030, 12, 31),
//               calendarFormat: _calendarFormat,
//               eventLoader: _getEventsForDay,
//               calendarStyle: CalendarStyle(
//                 outsideDaysVisible: false,
//               ),
//               onFormatChanged: (format) {
//                 if (_calendarFormat != format) {
//                   setState(() {
//                     _calendarFormat = format;
//                   });
//                 }
//               },
//               onPageChanged: (focusedDay) {
//                 _focusedDay = focusedDay;
//               },
//             ),
//           ),
//           SizedBox(height: 10.0),
//           Divider(
//             thickness: 1,
//           ),
//           SizedBox(
//             height: 8.0,
//           ),
//           Expanded(
//             child: FutureBuilder<List<AttendanceData>>(
//               future: futureAttendanceData,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No data available'));
//                 } else {
//                   final data = snapshot.data!;
//                   final selectedDateData = data.firstWhere(
//                           (element) =>
//                       element.date == _selectedDay.toString().split(" ")[0],
//                       orElse: () => AttendanceData(
//                           amdIn: 'N/A',
//                           recIn: 'N/A',
//                           amdOut: 'N/A',
//                           comment: 'N/A',
//                           recOut: 'N/A',
//                           date: _selectedDay.toString().split(" ")[0],
//                           status: 'N/A'));
//                   return ListView(
//                     children: [
//                       ListTile(
//                         title: Text('Date: ${selectedDateData.date}'),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('AMD In: ${selectedDateData.amdIn}'),
//                             Text('Rec In: ${selectedDateData.recIn}'),
//                             Text('AMD Out: ${selectedDateData.amdOut}'),
//                             Text('Comment: ${selectedDateData.comment}'),
//                             Text('Rec Out: ${selectedDateData.recOut}'),
//                             Text('Status: ${selectedDateData.status}'),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Event {
//   final String startTime;
//   final String leaveTime;
//
//   Event(this.startTime, this.leaveTime);
// }

import 'package:flutter/material.dart';
import 'package:untitled/Backend/APIs/Apis.dart';
import '../../Backend/models/att_model.dart';
import '../app_bar.dart';
import '../styles/sidebar.dart';

class Attendance extends StatefulWidget {
  final String token;

  const Attendance({Key? key, required this.token}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  DateTime _selectedDay = DateTime.now();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _leaveTimeController = TextEditingController();

  late Future<List<AttendanceData>> futureAttendanceData;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureAttendanceData =
        apiService.fetchAttendanceData(widget.token, _selectedDay);
    print('Token in attendance is ${widget.token}');
  }

  @override
  void dispose() {
    _startTimeController.dispose();
    _leaveTimeController.dispose();
    super.dispose();
  }

  Future<void> _markAttendance() async {
    if (_startTimeController.text.isNotEmpty &&
        _leaveTimeController.text.isNotEmpty) {
      // Assuming you have a method to submit the attendance data to the backend
      setState(() {
        futureAttendanceData = apiService.fetchAttendanceData(widget.token, _selectedDay);
      });
      _startTimeController.clear();
      _leaveTimeController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Attendance marked successfully!"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter both Start and Leaving times"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Attendance',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      drawer: CustomSidebar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                        labelStyle: TextStyle(color: Colors.black54),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20.0,
                        ),
                      ),
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          _startTimeController.text = pickedTime.format(context);
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: _leaveTimeController,
                      decoration: InputDecoration(
                        labelText: "Leaving Time",
                        labelStyle: TextStyle(color: Colors.black54),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20.0,
                        ),
                      ),
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          _leaveTimeController.text = pickedTime.format(context);
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 50.0),
                          backgroundColor: Color(0xff4d2880),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _markAttendance,
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Divider(thickness: 1),
          SizedBox(height: 10),
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
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final attendance = data[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${attendance.date}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87)),
                            SizedBox(height: 5),
                            Text('AMD In: ${attendance.amdIn}'),
                            Text('Rec In: ${attendance.recIn}'),
                            Text('AMD Out: ${attendance.amdOut}'),
                            Text('Comment: ${attendance.comment}'),
                            Text('Rec Out: ${attendance.recOut}'),
                            Text('Status: ${attendance.status}'),
                          ],
                        ),
                      );
                    },
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

  Event(this.startTime, this.leaveTime);
}
