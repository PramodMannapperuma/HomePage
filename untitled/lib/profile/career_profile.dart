import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';
import 'package:untitled/profile/profile_detail_column.dart';
import 'package:untitled/profile/profile_detail_row.dart';

class CareerProfile extends StatefulWidget {
  const CareerProfile({super.key});

  @override
  State<CareerProfile> createState() => _CareerProfileState();
}

class _CareerProfileState extends State<CareerProfile> {
  final Map<String, dynamic> careerData = {
    'firstName': 'Demon',
    'lastName': 'Silva',
    'higherEducation': 'BSc in Software Engineering',
    'professionalCertificates': 'LinkedIn Certificates',
    'PreviousWork1': 'Intern SE At ABC',
    'PreviousWork2': 'Associate SE At ABC',
    'PreviousWork3': 'Software Engineer At ABC',
    'Current Position': 'Senior SE',
    'Department': 'IT Deparment',
    'Division':'Daily Paid',
    'Type': 'Permanent',
    'Level':'Corporate Mgt',
    'Grade': 'Grade 2',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Career Profile',
          showActions: true,
          showLeading: false,
          context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage:
                        AssetImage("assets/images/2.-electronic-evan (1).jpg"),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Text(
                    '${careerData['firstName']} ${careerData['lastName']}'
                        .trim(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )
              ],
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(
                    title: 'Current Position', value: '${careerData['Current Position']}'),
                ProfileDetailRow(
                    title: 'Department', value: '${careerData['Department']}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(title: 'Division', value: '${careerData['Division']}'),
                ProfileDetailRow(title: 'Type', value: '${careerData['Type']}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(title: 'Level', value: '${careerData['Level']}'),
                ProfileDetailRow(title: 'Grade', value: '${careerData['Grade']}'),
              ],
            ),
            const SizedBox(height: 20),
            ProfileDetailColumn(title: 'Higher Education', value: '${careerData['higherEducation']}'),
            ProfileDetailColumn(title: 'Professional Certificates', value: '${careerData['professionalCertificates']}'),
            ProfileDetailColumn(title: 'Previous Work', value: '${careerData['PreviousWork1']}'),
            ProfileDetailColumn(title: 'Previous Work', value: '${careerData['PreviousWork2']}'),
            ProfileDetailColumn(title: 'Previous Work', value: '${careerData['PreviousWork3']}'),
          ],
        ),
      ),
    );
  }
}
