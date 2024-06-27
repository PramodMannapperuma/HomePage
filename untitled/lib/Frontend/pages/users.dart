import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../styles/sidebar.dart';

// Define Employee model with picture URL
class Employee {
  final String name;
  final String jobTitle;
  final String department;
  final String pictureUrl;
  final String email;
  final String phone;

  Employee({
    required this.name,
    required this.jobTitle,
    required this.department,
    required this.pictureUrl,
    required this.email,
    required this.phone,
  });
}

// Dummy data for employees
final List<Employee> employees = List.generate(
  10,
      (index) => Employee(
    name: 'Employee $index',
    jobTitle: 'Job Title $index',
    department: 'Department $index',
    pictureUrl: 'assets/images/2.-electronic-evan (1).jpg',
    email: 'employee$index@company.com',
    phone: '123-456-7890',
  ),
);

// Widget to display employee details in a card
class EmployeeCard extends StatelessWidget {
  final Employee employee;

  EmployeeCard({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 4.0,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage(employee.pictureUrl),
            ),
            SizedBox(height: 16.0),
            Text(
              employee.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              employee.jobTitle,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              employee.department,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              employee.email,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
            Text(
              employee.phone,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmployeeGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Company Employees',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true, // Show back button instead of hamburger icon
      ),
      drawer: CustomSidebar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.55,
          ),
          itemCount: employees.length,
          itemBuilder: (context, index) {
            return EmployeeCard(employee: employees[index]);
          },
        ),
      ),
    );
  }
}
