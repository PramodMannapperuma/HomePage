import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled/Backend/APIs/Apis.dart';
import '../../Backend/models/cover_ups.dart';
import '../../Backend/models/leave_balance_model.dart';
import '../../Backend/models/leave_model.dart';
import '../../Backend/models/leave_types.dart';
import 'package:intl/intl.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';

class Leave extends StatefulWidget {
  final String token;

  const Leave({Key? key, required this.token}) : super(key: key);

  @override
  State<Leave> createState() => _LeavePageState();
}

class _LeavePageState extends State<Leave> {

  // Define static color constants
  static const Color incompleteColor = Colors.grey;
  static const Color amendmentColor = Colors.blue;
  static const Color pendingColor = Colors.amber;
  static const Color rejectedColor = Colors.red;
  static const Color attendanceColor = Colors.green;
  static const Color holidayColor = Colors.black;
  static const Color leaveColor = Colors.purple;

  // Map status to color
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
  final Map<DateTime, String> _leaveStatus = {};

  TextEditingController _commentController = TextEditingController();

  late Future<List<LeaveData>> futureLeaveData;
  late final ValueNotifier<List<Event>> _selectedEvents;
  final ApiService apiService = ApiService();

  List<LeaveBalanceData>? leaveBalanceData;
  List<LeaveType>? leaveTypes;
  List<CoverUp>? coverUps;
  // Map<DateTime, List<LeaveData>> leaveDataMap = {};
  bool isLoading = true;

  String? _selectedLeaveType;
  String? _selectedTimeOfDay;
  String? _selectedCoverUp;
  String? _attachmentPath;

  @override
  void initState() {
    super.initState();
    _fetchLeaveBalance();
    _fetchLeaveTypes();
    _fetchCoverUps();
    _selectedDay = _focusedDay;
    futureLeaveData = apiService.fetchLeaveData(widget.token, _focusedDay);
    _loadLeaveData();
    _selectedEvents = ValueNotifier([]);
  }

  Future<void> _loadLeaveData() async {
    try {
      final List<LeaveData> data =
          await apiService.fetchLeaveData(widget.token, _focusedDay);
      setState(() {
        _leaveStatus.clear();
        for (var leave in data) {
          if (leave.date != null) {
            final DateTime date = DateTime.parse(leave.date!);
            _leaveStatus[date] = leave.status ?? 'pending';
          }
        }
      });
    } catch (e) {
      print('Error loading leave data: $e');
    }
  }

  Future<void> _fetchLeaveTypes() async {
    try {
      final data = await apiService.fetchLeaveTypes(widget.token);
      setState(() {
        leaveTypes = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching leave types: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchCoverUps() async {
    try {
      final data = await apiService.fetchCoverUps(widget.token);
      setState(() {
        coverUps = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching cover-ups: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchLeaveBalance() async {
    try {
      final data = await ApiService().fetchLeaveBalance(widget.token);
      setState(() {
        leaveBalanceData = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching leave balance: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future<void> _fetchLeaveData(DateTime selectedDate) async {
  //   try {
  //     final List<LeaveData> data = await apiService.fetchLeaveData(widget.token, _focusedDay);
  //     setState(() {
  //       leaveDataMap.clear();
  //       for (var leave in data) {
  //         if (leave.date != null) {
  //           // Check if the date is not null
  //           final DateTime date = DateTime.parse(leave.date!); // Use non-nullable type
  //           leaveDataMap[date] = leave.status ?? 'unknown';
  //         }
  //       }
  //     });
  //   } catch (e) {
  //     // Handle error
  //     print('Error fetching leave data: $e');
  //   }
  // }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDate, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDate)) {
      setState(() {
        _selectedDay = selectedDate;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDate);
        futureLeaveData = apiService.fetchLeaveData(widget.token, selectedDate);
      });

      // if (!leaveDataMap.containsKey(selectedDate)) {
      //   _fetchLeaveData(selectedDate);
      // }
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return [];
  }

  Future<void> _submitLeave(
    BuildContext context,
    String token,
    String selectedDay,
    String selectedTypeOfDay,
    String comment,
    String coverUp,
    List<String> removeDays,
  ) async {
    final datesData = [
      {
        'date': selectedDay,
        'data': {
          'leave_id': 1,
          'cat': selectedTypeOfDay,
          'comment': comment,
          'coverup': coverUp,
        }
      }
    ];

    final uri = Uri.parse('http://hris.accelution.lk/api/leave');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Accept'] = '/'
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['dates'] = jsonEncode(datesData) // As a JSON string
      ..fields['remove'] = '[]'; // As a JSON string

    print('Dates data: ${jsonEncode(datesData)}');
    print('Remove data: ${jsonEncode(removeDays)}');
    print('Token: $token');

    try {
      // Send the request
      final response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Leave submitted successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
        _loadLeaveData();
        setState(() {
          _selectedEvents.value = _getEventsForDay(_selectedDay!);
        });
        // _fetchLeaveData(_selectedDay!); // Refresh the data
      } else {
        final responseBody = await response.stream.bytesToString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to submit leave: ${response.statusCode} ${responseBody}'),
            duration: Duration(seconds: 2),
          ),
        );
        print(
            "Error in submitting leave ${response.statusCode} ${responseBody}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _pickAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _attachmentPath = result.files.single.path;
      });
    }
  }

  Future<void> _submitLeaveRemoval(
    String token,
    List<String> removeDays,
  ) async {
    final uri = Uri.parse('${ApiService.baseUrl}/leave');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Accept'] = '*/*'
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['dates'] = '[]'
      ..fields['remove'] = jsonEncode(removeDays);

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Leave removed successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
        // _fetchLeaveData(_selectedDay!); // Refresh the data
      } else {
        final responseBody = await response.stream.bytesToString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to remove leave: ${response.statusCode} ${responseBody}'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _clearForm() {
    setState(() {
      _selectedLeaveType = null;
      _selectedTimeOfDay = null;
      _commentController.clear();
      _attachmentPath = null;
      _selectedCoverUp = null;
    });
  }

  Future<void> _showAddLeaveBottomSheet(BuildContext context) async {
    if (_selectedDay != null && _selectedDay!.isBefore(today)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You cannot add leave for past dates.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Add Leave",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    isLoading
                        ? CircularProgressIndicator()
                        : DropdownButtonFormField<String>(
                            value: _selectedLeaveType,
                            decoration: InputDecoration(
                              labelText: "Leave Type",
                            ),
                            items: leaveTypes?.map((LeaveType leaveType) {
                                  return DropdownMenuItem<String>(
                                    value: leaveType.text,
                                    child: Text(leaveType.text),
                                  );
                                }).toList() ??
                                [],
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedLeaveType = newValue;
                                if (newValue != "Medical") {
                                  _attachmentPath = null;
                                }
                              });
                            },
                          ),
                    if (_selectedLeaveType != null && leaveTypes != null) ...[
                      if (leaveTypes!
                              .firstWhere(
                                  (type) => type.text == _selectedLeaveType)
                              .additionalData['coverup'] ==
                          'yes')
                        DropdownButtonFormField<String>(
                          value: _selectedCoverUp,
                          decoration: InputDecoration(
                            labelText: "Cover up",
                          ),
                          items: coverUps?.map((CoverUp coverUp) {
                                return DropdownMenuItem<String>(
                                  value: coverUp.id,
                                  child: Text(coverUp.name),
                                );
                              }).toList() ??
                              [],
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCoverUp = newValue;
                            });
                          },
                        ),
                      if (leaveTypes!
                              .firstWhere(
                                  (type) => type.text == _selectedLeaveType)
                              .additionalData['attachment'] ==
                          'yes')
                        Column(
                          children: [
                            TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: "Attachment",
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.attach_file),
                                  onPressed: _pickAttachment,
                                ),
                              ),
                              controller:
                                  TextEditingController(text: _attachmentPath),
                            ),
                            if (_attachmentPath != null)
                              Text(
                                  "Selected file: ${_attachmentPath!.split('/').last}"),
                          ],
                        ),
                    ],
                    DropdownButtonFormField<String>(
                      value: _selectedTimeOfDay,
                      decoration: InputDecoration(
                        labelText: "Time of the Day",
                      ),
                      items: [
                        "Full Day",
                        "Half Day - Morning",
                        "Half Day - Evening"
                      ].map((String timeOfDay) {
                        return DropdownMenuItem<String>(
                          value: timeOfDay,
                          child: Text(timeOfDay),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTimeOfDay = newValue;
                        });
                      },
                    ),
                    TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        labelText: "Reason",
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            _clearForm();
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
                          onPressed: () async {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(_selectedDay!);
                            if (_selectedLeaveType != null &&
                                _selectedTimeOfDay != null &&
                                _commentController.text.isNotEmpty &&
                                (_selectedLeaveType != "Annual" ||
                                    _selectedCoverUp != null) &&
                                (_selectedLeaveType != "Medical" ||
                                    _attachmentPath != null)) {
                              _submitLeave(
                                context,
                                widget.token,
                                formattedDate,
                                _selectedTimeOfDay!,
                                _commentController.text,
                                _selectedCoverUp ?? '',
                                [''],
                              );

                              _clearForm();
                              Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please enter all fields"),
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
      },
    );
  }

  Color _getStatusColor(String? status) {
    return statusColorMap[status] ??
        Colors.grey; // Default color if none of the cases match
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

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
                  "Leave",
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
          _showAddLeaveBottomSheet(context);
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
              // eventLoader: _loadLeaveData;
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
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  final status = _leaveStatus[day];
                  if (status != null) {
                    Color statusColor;
                    switch (status) {
                      case 'accepted':
                        statusColor = Colors.green;
                        break;
                      case 'rejected':
                        statusColor = Colors.red;
                        break;
                      case 'pending':
                      default:
                        statusColor = Colors.orange;
                    }
                    return Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: statusColor,
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<LeaveData>>(
              future: futureLeaveData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No leave data available.'),
                  );
                } else {
                  final data = snapshot.data!;
            //       return ListView.builder(
            //         itemCount: leaveData.length,
            //         itemBuilder: (context, index) {
            //           final leave = leaveData[index];
            //           return ListTile(
            //             title: Text('Leave Date: ${leave.date ?? 'N/A'}'),
            //             subtitle: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 // Text('Start Time: ${leave.startTime ?? 'N/A'}'),
            //                 // Text('End Time: ${leave.endTime ?? 'N/A'}'),
            //                 Text('Comment: ${leave.comment ?? 'N/A'}'),
            //                 Text('Status: ${leave.status ?? 'N/A'}'),
            //               ],
            //             ),
            //           );
            //         },
            //       );
            //     }
            //   },
            // ),
                  final selectedDateData = data.firstWhere(
                        (element) =>
                    element.date == _selectedDay?.toString().split(" ")[0],
                    orElse: () => LeaveData(
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
                                  )
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
                              Divider(thickness: 1),
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
            // child: Padding(
            //   padding: EdgeInsets.all(screenWidth * 0.03),
            //   child: SingleChildScrollView(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           'Leave Details',
            //           style: TextStyle(
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold,
            //             color: Color(0xff4d2880),
            //           ),
            //         ),
            //         SizedBox(height: screenHeight * 0.02),
            //         isLoading
            //             ? Center(child: CircularProgressIndicator())
            //             : leaveBalanceData != null &&
            //                     leaveBalanceData!.isNotEmpty
            //                 ? Card(
            //                     elevation: 4,
            //                     shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(8),
            //                     ),
            //                     child: Padding(
            //                       padding: EdgeInsets.all(screenWidth * 0.03),
            //                       child: Center(
            //                         child: _buildLeaveTable(),
            //                       ),
            //                     ),
            //                   )
            //                 : Center(
            //                     child: Text(
            //                       'No leave balance data available.',
            //                       style: TextStyle(fontSize: 14),
            //                     ),
            //                   ),
            //         _buildLeaveDetail(),
            //       ],
            //     ),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }

  // Widget _buildLeaveTable() {
  //   return DataTable(
  //     columnSpacing: 12,
  //     headingRowHeight: 35,
  //     dataRowHeight: 32,
  //     columns: [
  //       DataColumn(
  //           label: Text('Leave',
  //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
  //       DataColumn(
  //           label: Text('Entitled',
  //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
  //       DataColumn(
  //           label: Text('Utilized',
  //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
  //       DataColumn(
  //           label: Text('Pending',
  //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
  //       DataColumn(
  //           label: Text('Available',
  //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
  //     ],
  //     rows: leaveBalanceData!.map((data) {
  //       return DataRow(cells: [
  //         DataCell(
  //           Center(child: Text(data.leave, style: TextStyle(fontSize: 14))),
  //         ),
  //         DataCell(
  //           Center(
  //               child: Text(data.total.toString(),
  //                   style: TextStyle(fontSize: 14))),
  //         ),
  //         DataCell(
  //           Center(
  //               child: Text(data.utilized.toString(),
  //                   style: TextStyle(fontSize: 14))),
  //         ),
  //         DataCell(
  //           Center(
  //               child: Text(data.pending.toString(),
  //                   style: TextStyle(fontSize: 14))),
  //         ),
  //         DataCell(
  //           Center(
  //               child: Text(data.available.toString(),
  //                   style: TextStyle(fontSize: 14))),
  //         ),
  //       ]);
  //     }).toList(),
  //   );
  // }

  // Widget _buildLeaveDetail() {
  //   if (_selectedDay == null || !leaveDataMap.containsKey(_selectedDay!)) {
  //     return Center(
  //       child: Text(
  //         'No leave data available for the selected date.',
  //         style: TextStyle(fontSize: 14),
  //       ),
  //     );
  //   }
  //
  //   List<LeaveData> leaveList = leaveDataMap[_selectedDay!] ?? [];
  //
  //   if (leaveList.isEmpty) {
  //     return Center(
  //       child: Text(
  //         'No leave data available for the selected date.',
  //         style: TextStyle(fontSize: 14),
  //       ),
  //     );
  //   }
  //
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(),
  //     itemCount: leaveList.length,
  //     itemBuilder: (context, index) {
  //       LeaveData leave = leaveList[index];
  //       return Card(
  //         elevation: 4,
  //         margin: EdgeInsets.symmetric(
  //           vertical: 8.0,
  //           horizontal: 5.0,
  //         ),
  //         child: ListTile(
  //           title: Text(
  //             leave.date ?? 'No Date',
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               color: Color(0xff4d2880),
  //             ),
  //           ),
  //           subtitle: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('Status: ${leave.status ?? 'N/A'}'),
  //               // Text('AMD In: ${leave.amdIn ?? 'N/A'}'),
  //               // Text('REC In: ${leave.recIn ?? 'N/A'}'),
  //               // Text('AMD Out: ${leave.amdOut ?? 'N/A'}'),
  //               // Text('REC Out: ${leave.recOut ?? 'N/A'}'),
  //               Text('Comment: ${leave.comment ?? 'N/A'}'),
  //               IconButton(
  //                 icon: Icon(Icons.delete, color: Colors.red),
  //                 onPressed: () {
  //                   // _removeLeaveRequest(
  //                   //     widget.token, value[index].timeOfDay);
  //
  //                   String date =
  //                       DateFormat('yyyy-MM-dd').format(_selectedDay!);
  //                   _submitLeaveRemoval(widget.token, [date]);
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}

class Event {
  final String startTime;
  final String leaveTime;
  final String comment;

  Event(this.startTime, this.leaveTime, this.comment);
}
