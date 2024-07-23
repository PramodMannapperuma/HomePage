import 'dart:convert';
import 'dart:async';
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
    var fontSize = screenWidth * 0.043;

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
              Image.asset(
                'assets/images/test-bg.png',
                height: screenHeight * 0.4, // Adjust image height
                width: screenWidth * 0.9,
                fit: BoxFit.fill,
              ),
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

  const LoginForm({
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

      final response = await http
          .post(
        Uri.parse('http://hris.accelution.lk/api/auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'client_id': username,
          'client_secret': password,
        }),
      )
          .timeout(const Duration(seconds: 10)); // Add a timeout duration

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

        // Save the session cookies
        List<String> cookies = response.headers['set-cookie']?.split(',') ?? [];
        await prefs.setStringList('cookies', cookies);

        // Verify session cookies by fetching the user profile
        await fetchUserProfile();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(token: token),
          ),
        );
      } else {
        final errorData = json.decode(response.body);
        _showErrorDialog(
            errorData['message'] ?? 'Invalid username or password');
      }
    } on TimeoutException catch (_) {
      Navigator.pop(context); // Ensure the dialog is dismissed
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('The server is not up. Please try again later!');
    } catch (e) {
      Navigator.pop(context); // Ensure the dialog is dismissed
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('An error occurred. Please try again later.');
      print('Login error: $e');
    }
  }

  Future<void> fetchUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cookies = prefs.getStringList('cookies') ?? [];
    String cookieHeader = cookies.join('; ');

    final response = await http.get(
      Uri.parse('http://hris.accelution.lk/api/user/profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': cookieHeader,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('User Profile: $data');
    } else {
      print('Failed to fetch user profile');
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
          style:
          TextStyle(fontSize: widget.fontSize, fontWeight: FontWeight.bold),
        ),
        Container(
          height: widget.textFieldHeight * 1.2,
          child: TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Password',
          style:
          TextStyle(fontSize: widget.fontSize, fontWeight: FontWeight.bold),
        ),
        Container(
          height: widget.textFieldHeight * 1.2,
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
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
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Color(0xff4d2880)),
            ),
          ),
          child: _isLoading
              ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : Text(
            'Login',
            style: TextStyle(
                fontSize: widget.fontSize * 1.2, color: Colors.white),
          ),
        ),
        SizedBox(height: 25,),
        Divider(thickness: 2,),
        Center(
            child: Text(
              ' © 2023 - Accelution',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            )),
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
