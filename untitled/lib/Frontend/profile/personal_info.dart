import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:untitled/Frontend/profile/profile_detail_column.dart';
import 'package:untitled/Frontend/profile/profile_detail_row.dart';
import '../../Backend/APIs/Apis.dart';
import '../app_bar.dart';
import '../styles/sidebar.dart';

class PersonalInfo extends StatefulWidget {
  late final String token;


  PersonalInfo({super.key, required this.token});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  // late final String token;
  @override
  Widget build(BuildContext context) {
    print('token in personal ${widget.token}');
    return Scaffold(
      appBar: customAppBar(
        title: 'Personal Information',
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

          final userData = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder<Uint8List>(future: ApiService.fetchProfilePicture(widget.token), builder: (context, snapshot){
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage('assets/images/profile.png'),
                        );
                      } else if (snapshot.hasData) {
                        return CircleAvatar(
                          radius: 45,
                          backgroundImage: MemoryImage(snapshot.data!),
                        );
                      } else {
                        return CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage('assets/images/profile.png'),
                        );
                      }
                    },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        '${userData['firstName']} ${userData['surname']}'
                            .trim(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )
                  ],
                ),
                Divider(thickness: 1),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileDetailRow(
                        title: 'First Name', value: '${userData['firstName']}'),
                    ProfileDetailRow(
                        title: 'Last Name', value: '${userData['surname']}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileDetailRow(
                        title: 'UserId', value: '${userData['code']}'),
                    ProfileDetailRow(
                        title: 'Sex', value: '${userData['gender']}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileDetailRow(
                        title: 'Disability Status',
                        value: '${userData['disabilityStatus']}'),
                    ProfileDetailRow(
                        title: 'Blood Group',
                        value: '${userData['bloodGroup']}'),
                  ],
                ),
                const SizedBox(height: 20),
                ProfileDetailColumn(
                    title: 'Email', value: '${userData['email']}'),
                ProfileDetailColumn(
                    title: 'Nationality', value: '${userData['nationality']}'),
                ProfileDetailColumn(
                    title: 'Ethnicity', value: '${userData['ethnicity']}'),
                ProfileDetailColumn(
                    title: 'Religion', value: '${userData['religion']}'),
                ProfileDetailColumn(
                    title: 'Address', value: '${userData['permanentAddress']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

