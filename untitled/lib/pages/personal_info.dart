import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';

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
    'DL No': 'N/A',
    'PP NO': 'N/A',
    'Disability Status':'N/A',
    'Blood Group': 'O+',
    'email': 'silva@example.com',
    'Nationality' : 'Sri Lankan',
    'Ethnicity': 'Sinhalese',
    'Religion': 'Buddhist',
    'Address' :'12/3, Nugegoda, Sri Lanka.',
    'Contact': '1234567890',
    'Office Tel': '0987654321',
    'Office Email': 'demon@gmail.com'

  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Profile',
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
                  height: 115,
                  width: 115,
                  child: CircleAvatar(
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
                ProfileDetailRow(
                    title: 'Sex',
                    value: '${userData['gender']}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  const ProfileDetailRow({super.key, required this.title, required this.value});

  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black, fontSize: 16.0),
              ),
              const SizedBox(height: 10.0),
              Text(value, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 10.0),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: const Divider(thickness: 1.0),
              ),
            ],
          ),
          const Icon(Icons.lock_outline, size: 10.0),
        ],
      ),
    );
  }
}

class ProfileDetailColumn extends StatelessWidget {
  const ProfileDetailColumn(
      {super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
            ),
            const SizedBox(height: 10.0),
            Text(value, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 10.0),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: const Divider(thickness: 1.0),
            )
          ],
        ),
        const Icon(Icons.lock_outline, size: 10.0),
      ],
    );
  }
}
