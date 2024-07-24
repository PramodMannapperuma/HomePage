import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:untitled/Frontend/profile/profile_detail_column.dart';
import 'package:untitled/Frontend/profile/profile_detail_row.dart';

import '../../Backend/APIs/Apis.dart';
import '../app_bar.dart';
import '../styles/sidebar.dart';

class CareerProfile extends StatefulWidget {
  final String token;

  const CareerProfile({super.key, required this.token});

  @override
  State<CareerProfile> createState() => _CareerProfileState();
}

class _CareerProfileState extends State<CareerProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Career Profile',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true, // Show back button instead of hamburger icon
      ),
      drawer: CustomSidebar(token: widget.token,),
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

          final careerData = snapshot.data!;
          final String Designation = careerData['designation'];
          List<String> words = Designation.split('');
          String firstWords = words.take(22).join('');

          final String Level = careerData['level'];
          List<String> lev = Level.split('');
          String Levels = lev.take(18).join('');

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder<Uint8List>(future: ApiService.fetchProfilePicture(widget.token), builder: (context, snapshot){
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return CircleAvatar(
                            radius: 60,
                            child: Center(
                                child: Text('Error: ${snapshot.error}', style: TextStyle(fontSize: 8),)));
                      } else if (snapshot.hasData) {
                        return CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(snapshot.data!));
                      } else {

                        return CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.black45,
                          child: Icon(Icons.person_rounded, color: Colors.white,),
                        );
                      }
                    },
                    ),
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
                        '${careerData['firstName']} ${careerData['surname']}'
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
                        title: 'Designation',
                        value: firstWords),
                    ProfileDetailRow(
                        title: 'Department',
                        value: '${careerData['department']}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileDetailRow(
                        title: 'Division', value: '${careerData['division']}'),
                    ProfileDetailRow(
                        title: 'Employee Type',
                        value: '${careerData['employeeType']}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileDetailRow(
                        title: 'Level', value: Levels),
                    ProfileDetailRow(
                        title: 'Grade', value: '${careerData['grade']}'),
                  ],
                ),
                const SizedBox(height: 20),
                ProfileDetailColumn(
                    title: 'Job Description',
                    value: '${careerData['jobDescription']}'),
                ProfileDetailColumn(
                    title: 'Professional Certificates',
                    value: '${careerData['professionalCertificates']}'),
                ProfileDetailColumn(
                    title: 'Previous Work',
                    value: '${careerData['PreviousWork1']}'),
                ProfileDetailColumn(
                    title: 'Previous Work',
                    value: '${careerData['PreviousWork2']}'),
                ProfileDetailColumn(
                    title: 'Previous Work',
                    value: '${careerData['PreviousWork3']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
