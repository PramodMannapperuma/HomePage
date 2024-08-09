import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_bar.dart';
import '../styles/sidebar.dart';

class ApprovalScreen extends StatefulWidget {
  final String token;

  const ApprovalScreen({Key? key, required this.token}) : super(key: key);
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<ApprovalScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    LeaveScreen(),
    AttendanceScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Approval Panel',
          showActions: true,
          showLeading: true,
          context: context,
          showBackButton: true),
      drawer: CustomSidebar(
        token: '',
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Leave',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Attendance',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff4d2880),
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        type: BottomNavigationBarType
            .fixed, // Ensures the background color is consistent
      ),
    );
  }
}

class LeaveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3, // Replace with your data source length
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 3,
          child: ListTile(
            contentPadding: EdgeInsets.all(15.0),
            title: Text(
              'Employee ${index + 1}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Leave Type: Casual'),
                Text('Date: 2024-08-09'),
                Text('Reason: Personal Matter'),
                Text('Time of the day: half day'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  onPressed: () {
                    // Handle accept action
                  },
                  child: Text(
                    'Accept',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 3.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  onPressed: () {
                    // Handle decline action
                  },
                  child: Text(
                    'Decline',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _employees =
      List.generate(6, (index) => 'Employee ${index + 1}');
  List<String> _filteredEmployees = [];

  @override
  void initState() {
    super.initState();
    _filteredEmployees = _employees;
    _searchController.addListener(() {
      setState(() {
        _filteredEmployees = _employees
            .where((employee) => employee
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search Employees',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredEmployees.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 2,
                child: ListTile(
                  contentPadding: EdgeInsets.all(15.0),
                  title: Text(
                    _filteredEmployees[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: 2024-08-09'),
                      Text('Actual In: 09:00 AM'),
                      Text('Actual Out: 05:00 PM'),
                      Text('Comment: On Time'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          // Handle accept action
                        },
                        child: Text(
                          'Accept',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          // Handle decline action
                        },
                        child: Text(
                          'Decline',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
