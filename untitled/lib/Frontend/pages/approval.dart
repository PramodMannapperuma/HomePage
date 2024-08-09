import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_bar.dart';
import '../styles/sidebar.dart';

class ApprovalScreen extends StatefulWidget {
  final String token;

  const ApprovalScreen({Key? key, required this.token}) : super(key: key);

  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Approval Panel',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      drawer: CustomSidebar(
        token: widget.token,
      ),
      body: EmployeeListScreen(),
    );
  }
}

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final List<String> employees = List.generate(10, (index) => 'Employee ${index + 1}');
  late List<String> filteredEmployees;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredEmployees = employees;
    searchController.addListener(_filterEmployees);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterEmployees() {
    setState(() {
      filteredEmployees = employees
          .where((employee) =>
          employee.toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
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
            itemCount: filteredEmployees.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                title: Text(
                  filteredEmployees[index],
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeDetailsScreen(employeeName: filteredEmployees[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class EmployeeDetailsScreen extends StatelessWidget {
  final String employeeName;

  const EmployeeDetailsScreen({Key? key, required this.employeeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: '$employeeName - Approval Details',
        showActions: false,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          // Attendance Details Section
          SectionHeader(title: 'Attendance Details'),
          AttendanceDetailsTab(employeeName: employeeName),

          // Leave Requests Section
          SectionHeader(title: 'Leave Request Details'),
          LeaveRequestsTab(employeeName: employeeName),

          // Request Letters Section
          SectionHeader(title: 'Request Letters Details'),
          RequestLettersTab(employeeName: employeeName),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class AttendanceDetailsTab extends StatelessWidget {
  final String employeeName;

  const AttendanceDetailsTab({Key? key, required this.employeeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3, // Replace with your actual data source length
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2,
          child: ListTile(
            contentPadding: EdgeInsets.all(15.0),
            title: Text(
              employeeName,
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
            trailing: ActionButtons(),
          ),
        );
      },
    );
  }
}

class LeaveRequestsTab extends StatelessWidget {
  final String employeeName;

  const LeaveRequestsTab({Key? key, required this.employeeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3, // Replace with your actual data source length
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 3,
          child: ListTile(
            contentPadding: EdgeInsets.all(15.0),
            title: Text(
              employeeName,
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
                Text('Time of the day: Half day'),
              ],
            ),
            trailing: ActionButtons(),
          ),
        );
      },
    );
  }
}

class RequestLettersTab extends StatelessWidget {
  final String employeeName;

  const RequestLettersTab({Key? key, required this.employeeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3, // Replace with your actual data source length
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 3,
          child: ListTile(
            contentPadding: EdgeInsets.all(15.0),
            title: Text(
              'Request Letter ${index + 1}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Request Type: General'),
                Text('Date: 2024-08-09'),
                Text('Details: Request details go here.'),
              ],
            ),
            trailing: ActionButtons(),
          ),
        );
      },
    );
  }
}

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
