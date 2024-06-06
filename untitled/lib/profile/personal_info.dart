import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';
import 'package:untitled/profile/profile_detail_column.dart';
import 'package:untitled/profile/profile_detail_row.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  // Hardcoded user data
  final Map<String, dynamic> userData = {
    'firstName': 'Demon',
    'lastName': 'Silva',
    'userId': '123456789012345',
    'gender': 'Male',
    'Disability Status': 'N/A',
    'Blood Group': 'O+',
    'email': 'silva@example.com',
    'Nationality': 'Sri Lankan',
    'Ethnicity': 'Sinhalese',
    'Religion': 'Buddhist',
    'Address': '12/3, Nugegoda, Sri Lanka.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Personal Information',
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
                    '${userData['firstName']} ${userData['lastName']}'.trim(),
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
                    title: 'First Name', value: '${userData['firstName']}'),
                ProfileDetailRow(
                    title: 'Last Name', value: '${userData['lastName']}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(
                  title: 'UserId',
                  value: '${userData['userId']?.substring(0, 15)}',
                ),
                ProfileDetailRow(title: 'Sex', value: '${userData['gender']}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(
                  title: 'Disability Status',
                  value: '${userData['Disability Status']}',
                ),
                ProfileDetailRow(title: 'Blood Group', value: '${userData['Blood Group']}'),
              ],
            ),
            const SizedBox(height: 20),
            ProfileDetailColumn(title: 'Email', value: '${userData['email']}'),
            ProfileDetailColumn(title: 'Nationality', value: '${userData['Nationality']}'),
            ProfileDetailColumn(title: 'Ethnicity', value: '${userData['Ethnicity']}'),
            ProfileDetailColumn(title: 'Religion', value: '${userData['Religion']}'),
            ProfileDetailColumn(title: 'Address', value: '${userData['Address']}'),
          ],
        ),
      ),
    );
  }
}


