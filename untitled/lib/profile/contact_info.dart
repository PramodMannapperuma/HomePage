import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';
import 'package:untitled/profile/profile_detail_column.dart';
import 'package:untitled/profile/profile_detail_row.dart';

class ContactInfo extends StatefulWidget {
  const ContactInfo({super.key});

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  final Map<String, dynamic> contactData = {
    'firstName': 'Demon',
    'lastName': 'Silva',
    'DL NO': 'N/A',
    'PP NO': 'N/A',
    'Mobile1': '071 123 1232',
    'Mobile2': '0776767567',
    'Office Mobile': '0112323456',
    'Office Mobile 2': '0113434123',
    'Resident Tel': '0114545456',
    'Resident Tel2': '0114545765',
    'Office Tel': '0116767678',
    'Office Extension': 'N/A',
    'Personal Email': "demon@gmail.com",
    'Office Email': 'silva@gmail.com',
    'Permanent Address': 'No.123/4, Nawala Rd, Rajagiriya.',
    'Resident Address': 'No 23/8, Kohuwala, Dehiwala.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Contact Information',
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
                    '${contactData['firstName']} ${contactData['lastName']}'
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
                    title: 'DL Number', value: '${contactData['DL NO']}'),
                ProfileDetailRow(
                    title: 'PP Number', value: '${contactData['PP NO']}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(
                  title: 'Mobile No',
                  value: '${contactData['Mobile1']}',
                ),
                ProfileDetailRow(
                    title: 'Office Mobile', value: '${contactData['Office Mobile']}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(
                  title: 'Resident Tel',
                  value: '${contactData['Resident Tel']}',
                ),
                ProfileDetailRow(
                    title: 'Office Tel',
                    value: '${contactData['Office Tel']}'),
              ],
            ),
            const SizedBox(height: 20),
            ProfileDetailColumn(
                title: 'Office Email', value: '${contactData['Office Email']}'),
            ProfileDetailColumn(
                title: 'Personal Email', value: '${contactData['Personal Email']}'),
            ProfileDetailColumn(
                title: 'Office Mobile 2', value: '${contactData['Office Mobile 2']}'),
            ProfileDetailColumn(
                title: 'Resident Tel 2', value: '${contactData['Resident Tel2']}'),
            ProfileDetailColumn(
                title: 'Permanent Address', value: '${contactData['Permanent Address']}'),
            ProfileDetailColumn(title: 'Resident Address', value: '${contactData['Resident Address']}'),
          ],
        ),
      ),
    );
  }
}
