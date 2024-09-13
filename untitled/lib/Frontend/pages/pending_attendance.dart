import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/Backend/APIs/Apis.dart';
import '../../Backend/models/att_model.dart';
import '../app_bar.dart'; // Import the custom app bar

class PendingAttendanceScreen extends StatefulWidget {
  final String token;

  const PendingAttendanceScreen({super.key, required this.token});

  @override
  _PendingAttendanceScreenState createState() => _PendingAttendanceScreenState();
}

class _PendingAttendanceScreenState extends State<PendingAttendanceScreen> {
  final int _initialDaysToFetch = 30; // Start with fetching data for the most recent 5 days
  final int _incrementDays = 5; // Incremental days to fetch on demand
  List<AttendanceData> _pendingAttendance = [];
  bool _isLoadingMore = false;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _fetchInitialAttendance();
  }

  Future<void> _fetchInitialAttendance() async {
    await _fetchAttendance(_initialDaysToFetch);
  }

  Future<void> _fetchAttendance(int daysToFetch, {bool isInitialLoad = true}) async {
    if (_isLoadingMore) return; // Prevent multiple concurrent loads

    setState(() {
      _isLoadingMore = true;
    });

    DateTime today = DateTime.now();
    List<Future<List<AttendanceData>>> fetchFutures = List.generate(
      daysToFetch,
          (i) async {
        DateTime targetDate = today.subtract(Duration(days: i));
        try {
          // Fetch attendance for a single day
          return await ApiService().fetchAttendanceData(widget.token, targetDate);
        } catch (e) {
          print('Failed to fetch attendance for $targetDate: $e');
          return [];
        }
      },
    );

    List<List<AttendanceData>> results = await Future.wait(fetchFutures);

    // Combine all fetched lists and filter unique pending attendances
    Set<AttendanceData> uniqueAttendance = results
        .expand((dailyList) => dailyList)
        .where((attendance) => attendance.status == 'pending')
        .toSet();

    if (uniqueAttendance.isNotEmpty) {
      setState(() {
        _pendingAttendance.addAll(uniqueAttendance.toList());
        _isLoadingMore = false;
        _hasMoreData = uniqueAttendance.length == daysToFetch; // More data available if all days returned data
      });
    } else {
      setState(() {
        _isLoadingMore = false;
        _hasMoreData = false; // No more data to load
      });
    }
  }

  Future<void> _loadMoreData() async {
    if (_hasMoreData) {
      await _fetchAttendance(_incrementDays, isInitialLoad: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Pending Attendance details',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _pendingAttendance.length + (_hasMoreData ? 1 : 0), // Add 1 for loading indicator
              itemBuilder: (context, index) {
                if (index == _pendingAttendance.length && _hasMoreData) {
                  // Display a loading indicator at the bottom
                  _loadMoreData();
                  return Center(child: CircularProgressIndicator());
                }

                AttendanceData attendance = _pendingAttendance[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Attendance Date: ${attendance.date}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4d2880),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Status: ${attendance.status}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (attendance.comment != null &&
                            attendance.comment!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Comment: ${attendance.comment}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoadingMore)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
