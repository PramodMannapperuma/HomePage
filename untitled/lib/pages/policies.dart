import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';

class Policy {
  final String id;
  final String name;
  final String details;
  bool isRead;
  bool isAgreed;

  Policy({
    required this.id,
    required this.name,
    this.details = '',
    this.isRead = false,
    this.isAgreed = false,
  });
}

class Policies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PolicyScreen();
  }
}

class PolicyScreen extends StatefulWidget {
  @override
  _PolicyScreenState createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  List<Policy> policies = [
    Policy(
        id: '1',
        name: 'Privacy Policy',
        details:
            'Details about the privacy policyDetails about the privacy policyDetails about the privacy policyDetails about the privacy policyDetails about the privacy policyDetails about the privacy policyDetails about the privacy policyDetails about the privacy policyDetails about the privacy policyDetails about the privacy policyDetails about the privacy policyDetails about the privacy policyDetails about the privacy policyDetails about the privacy policyDetails about the privacy policyDetails about the privacy policyDetails about the privacy policy...'),
    Policy(
        id: '2',
        name: 'Terms and Conditions',
        details:
            'Details about the terms and conditionsDetails about the terms and conditionsDetails about the terms and conditionsDetails about the terms and conditionsDetails about the terms and conditionsDetails about the terms and conditionsDetails about the terms and conditionsDetails about the terms and conditionsDetails about the terms and conditionsDetails about the terms and conditionsDetails about the terms and conditionsDetails about the terms and conditionsDetails about the terms and conditionsDetails about the terms and conditionsDetails about the terms and conditions...'),
    Policy(
        id: '3',
        name: 'User Agreement',
        details:
            'Details about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreementDetails about the user agreement...'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Policies',
          showActions: true,
          showLeading: false,
          context: context),
      body: ListView.builder(
        itemCount: policies.length,
        itemBuilder: (context, index) {
          final policy = policies[index];
          return ExpansionTile(
            title: Text(policy.name),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(policy.details),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       policy.isRead = !policy.isRead;
                  //     });
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     primary: policy.isRead ? Colors.green : Colors.red,
                  //   ),
                  //   child: Text('Read'),
                  // ),
                  SizedBox(width: 10),
                  Checkbox(
                    value: policy.isAgreed,
                    onChanged: (bool? value) {
                      setState(() {
                        policy.isAgreed = value ?? false;
                      });
                    },
                  ),
                  Text('I Agree to the terms and conditions'),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
