import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final _formKey = GlobalKey<FormState>();
  String _requestType =
      'Salary Confirmation'; // Default to the first item in the list
  String _name = '';
  String _employeeId = '';
  DateTime _date = DateTime.now();
  String _status = 'Pending';
  bool _isApproved = false; // Indicates if the request is approved

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Requests',
          showActions: true,
          showLeading: true,
          context: context,
          showBackButton: true),
      drawer: CustomSidebar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _requestType,
                decoration: InputDecoration(
                  labelText: 'Request Type',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.request_page, color: AppColors.background),
                ),
                items: <String>[
                  'Salary Confirmation',
                  'VISA Letter',
                  'Letter to Bank for loans'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _requestType = newValue!;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.person, color: AppColors.background),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Employee ID',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.badge, color: AppColors.background),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your employee ID';
                  }
                  return null;
                },
                onSaved: (value) => _employeeId = value!,
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text('Date: ${_date.toString().split(' ')[0]}'),
                trailing:
                    Icon(Icons.calendar_today, color: AppColors.background),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _date) {
                    setState(() {
                      _date = picked;
                    });
                  }
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Simulate HR approval process
                    setState(() {
                      _status = 'Approved';
                      _isApproved = true;
                    });
                    // Here you would include logic to generate and download the letter
                  }
                },
                child: Text(
                  'Submit Request',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Status: $_status',
                style: TextStyle(
                  color: _status == 'Pending' ? Colors.orange : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Section for viewing and downloading the letter
              if (_isApproved) ...[
                SizedBox(height: 16),
                Divider(),
                ListTile(
                  leading:
                      Icon(Icons.download_rounded, color: AppColors.background),
                  title: Text('Download Approval Letter'),
                  subtitle: Text('Tap to download the letter'),
                  onTap: () {
                    // Implement download functionality
                  },
                ),
                ListTile(
                  leading: Icon(Icons.visibility, color: AppColors.background),
                  title: Text('View Approval Letter'),
                  subtitle: Text('Tap to view the letter'),
                  onTap: () {
                    // Implement view functionality
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
