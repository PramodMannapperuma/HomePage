import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';
import 'package:untitled/profile/profile_detail_column.dart';
import 'package:untitled/profile/profile_detail_row.dart';
import 'package:untitled/styles/sidebar.dart';

import '../APIs/Apis.dart';

class ContactInfo extends StatefulWidget {
  final String token;

  const ContactInfo({super.key, required this.token});

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Contact Information',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true, // Show back button instead of hamburger icon
      ),
      drawer: CustomSidebar(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService.getProfile(widget.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final contactData = snapshot.data!;

          return SingleChildScrollView(
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
                        backgroundImage: AssetImage(
                            "assets/images/2.-electronic-evan (1).jpg"),
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
                        '${contactData['firstName']} ${contactData['surname']}'
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
                        title: 'DL Number', value: '${contactData['dlNo']}'),
                    ProfileDetailRow(
                        title: 'PP Number', value: '${contactData['ppNo']}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileDetailRow(
                      title: 'Mobile No',
                      value: '${contactData['mobile1']}',
                    ),
                    ProfileDetailRow(
                        title: 'Office Mobile',
                        value: '${contactData['officeMobile']}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileDetailRow(
                      title: 'Resident Tel',
                      value: '${contactData['residentialTel']}',
                    ),
                    ProfileDetailRow(
                        title: 'Office Tel',
                        value: '${contactData['officeTel']}'),
                  ],
                ),
                const SizedBox(height: 20),
                ProfileDetailColumn(
                    title: 'Office Email',
                    value: '${contactData['officeEmail']}'),
                ProfileDetailColumn(
                    title: 'Personal Email',
                    value: '${contactData['personalEmail']}'),
                ProfileDetailColumn(
                    title: 'Office Mobile 2',
                    value: '${contactData['mobile2']}'),
                ProfileDetailColumn(
                    title: 'Resident Tel 2',
                    value: '${contactData['otherTel']}'),
                ProfileDetailColumn(
                    title: 'Permanent Address',
                    value: '${contactData['permanentAddress']}'),
                ProfileDetailColumn(
                    title: 'Resident Address',
                    value: '${contactData['residentialAddress']}'),
                ProfileDetailColumn(
                    title: 'Office Ext',
                    value: '${contactData['officeExt']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
