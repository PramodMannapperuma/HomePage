// import 'package:flutter/material.dart';
//
//
// // Profile overview section
// Container(
// padding: EdgeInsets.all(16),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(8),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.5),
// spreadRadius: 2,
// blurRadius: 5,
// offset: Offset(0, 3), // changes position of shadow
// ),
// ],
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Profile Overview',
// style: TextStyle(
// fontSize: 20,
// fontWeight: FontWeight.bold,
// ),
// ),
// SizedBox(height: 10),
// Row(
// children: [
// _buildProfileInfoItem(
// 'Hours Worked', '150', Colors.blue),
// _buildProfileInfoItem(
// 'Tasks Completed', '30', Colors.green),
// ],
// ),
// Row(
// children: [
// _buildProfileInfoItem('Projects', '5', Colors.orange),
// _buildProfileInfoItem('Overdue Tasks', '2', Colors.red),
// ],
// ),
// ],
// ),
// ),
// SizedBox(height: 20),


// Tasks section
// Container(
// padding: EdgeInsets.all(16),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(8),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.5),
// spreadRadius: 2,
// blurRadius: 5,
// offset: Offset(0, 3), // changes position of shadow
// ),
// ],
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Tasks',
// style: TextStyle(
// fontSize: 20,
// fontWeight: FontWeight.bold,
// ),
// ),
// SizedBox(height: 10),
// _buildTaskItem(
// 'Design new UI', 'Deadline: Tomorrow', Colors.orange),
// _buildTaskItem('Update Flutter dependencies',
// 'Deadline: Today', Colors.red),
// ],
// ),
// ),
import 'package:flutter/material.dart';


// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import '../app_bar.dart';
// import '../home/Dashbord.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   @override
//   Widget build(BuildContext context) {

//     var mediaQuery = MediaQuery.of(context);
//     var screenWidth = mediaQuery.size.width;
//     var screenHeight = mediaQuery.size.height;
//     var isTabletOrLarger = screenWidth >= 600;

//     return Scaffold(
//       appBar: customAppBar(
//           title: '', showActions: false, showLeading: false, context: context),
//       body: Stack(
//         children: [
//           Positioned(
//             top: 0,
//             child: Image.asset(
//               'assets/images/hrislogo2.png', // Replace with your image path
//               width: screenWidth * 0.9, // Make the image width responsive
//               height: screenHeight * 0.2, // Make the image height responsive
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: screenHeight *0.135),
//                     Padding(
//                       padding: EdgeInsets.all(1.0),
//                       child: LoginForm(),
//                     ),
//                     SizedBox(height: 10.0),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class LoginForm extends StatefulWidget {
//   @override
//   _LoginFormState createState() => _LoginFormState();
// }

// class _LoginFormState extends State<LoginForm> {
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isLoading = false;

//   Future<void> _login() async {
//     String username = _usernameController.text;
//     String password = _passwordController.text;

//     if (username.isEmpty || password.isEmpty) {
//       _showErrorDialog('Username and password cannot be empty');
//       return;
//     }
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       showDialog(
//         barrierDismissible:
//             false, // Prevents the dialog from closing until we manually do it
//         context: context,
//         builder: (BuildContext context) {
//           return const AlertDialog(
//             content: Row(
//               children: [
//                 CircularProgressIndicator(),
//                 SizedBox(width: 24),
//                 Text("Logging In ... "),
//               ],
//             ),
//           );
//         },
//       );

//       final response = await http.post(
//         Uri.parse('http://hris.accelution.lk/api/auth'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           'client_id': username,
//           'client_secret': password,
//         }),
//       );
//       Navigator.pop(context);
//       setState(() {
//         _isLoading = false;
//       });

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final token = data['access_token'];
//         print('Token In login $token');

//         // Assuming the token is obtained correctly
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => MainScreen(token: token),
//           ),
//         );

//       } else {
//         final errorData = json.decode(response.body);
//         _showErrorDialog(
//             errorData['message'] ?? 'Invalid username or password');
//         // Navigator.pop(context);
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showErrorDialog('An error occurred. Please try again. $e');
//       print('Login error: $e'); // Logging for debugging
//       // Navigator.pop(context);
//     }
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Login Failed'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextField(
//           controller: _usernameController,
//           decoration: InputDecoration(
//             labelText: 'Username',
//             border: UnderlineInputBorder(),
//           ),
//         ),
//         SizedBox(height: 10.0),
//         TextField(
//           controller: _passwordController,
//           obscureText: true,
//           decoration: InputDecoration(
//             labelText: 'Password',
//             border: UnderlineInputBorder(),
//           ),
//         ),
//         SizedBox(height: 10.0),
//         GestureDetector(
//           onTap: () {
//             // Add your forgot password logic here
//             print('Forgot Password tapped');
//           },
//           child: Text(
//             'Forgot Password?',
//             style: TextStyle(
//               color: Colors.blue,
//               fontSize: 16.0,
//             ),
//           ),
//         ),
//         SizedBox(height: 10.0),
//         ElevatedButton(
//           onPressed: _login,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Color(0xFF4d2880),
//             padding: EdgeInsets.symmetric(
//               vertical: 10.0,
//             ),
//             minimumSize: Size(double.infinity, 50.0),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//               side: BorderSide(color: Color(0xFF4d2880)),
//             ),
//           ),
//           child: Text(
//             'Login',
//             style: TextStyle(fontSize: 18.0, color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }

