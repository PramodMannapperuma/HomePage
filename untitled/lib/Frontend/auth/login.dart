import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Frontend/home/Dashbord.dart';

import '../app_bar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var screenWidth = mediaQuery.size.width;
    var screenHeight = mediaQuery.size.height;
    var textFieldHeight = screenHeight * 0.05; // Reduced height
    var buttonHeight = screenHeight * 0.05; // Reduced height
    var fontSize = screenWidth * 0.035;

    return Scaffold(
      appBar: customAppBar(
        title: '',
        showActions: false,
        showLeading: false,
        context: context,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.1),
              Image.asset(
                'assets/images/test-bg.png',
                height: screenHeight * 0.3, // Adjust image height
                fit: BoxFit.cover,
              ),
              SizedBox(height: screenHeight * 0.05),
              LoginForm(
                textFieldHeight: textFieldHeight,
                buttonHeight: buttonHeight,
                fontSize: fontSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final double textFieldHeight;
  final double buttonHeight;
  final double fontSize;

  LoginForm({
    required this.textFieldHeight,
    required this.buttonHeight,
    required this.fontSize,
  });

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog('Username and password cannot be empty');
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 24),
                Text("Logging In ... "),
              ],
            ),
          );
        },
      );

      final response = await http.post(
        Uri.parse('http://hris.accelution.lk/api/auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'client_id': username,
          'client_secret': password,
        }),
      );
      Navigator.pop(context);
      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['access_token'];
        print('Token In login $token');

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('lastLogin', DateTime.now().toString());

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(token: token),
          ),
        );

      } else {
        final errorData = json.decode(response.body);
        _showErrorDialog(errorData['message'] ?? 'Invalid username or password');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('An error occurred. Please try again. $e');
      print('Login error: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10.0),
        Text(
          'Username',
          style: TextStyle(
            fontSize: widget.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          height: widget.textFieldHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
          ),
          child: TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            style: TextStyle(fontSize: widget.fontSize),
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Password',
          style: TextStyle(
            fontSize: widget.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          height: widget.textFieldHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            style: TextStyle(fontSize: widget.fontSize),
          ),
        ),
        SizedBox(height: 20.0),
        GestureDetector(
          onTap: () {
            // Add your forgot password logic here
            print('Forgot Password tapped');
          },
          child: Text(
            'Forgot Password?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: _login,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff4d2880),
            padding: EdgeInsets.symmetric(vertical: widget.buttonHeight * 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Color(0xff4d2880)),
            ),
          ),
          child: _isLoading
              ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : Text(
            'Login',
            style: TextStyle(fontSize: widget.fontSize, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}




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