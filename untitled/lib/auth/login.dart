import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../homepage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: '', showActions: false, showLeading: false, context: context),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              'assets/images/hrislogo2.png', // Replace with your image path
              width: 380.0, // Adjust the width as needed
              height: 220.0, // Adjust the height as needed
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 120.0),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: LoginForm(),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == 'admin' && password == 'pass') {
      print('Username: $username');
      print('Password: $password');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ));
    } else {
      // If the credentials are incorrect, show an error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username or password'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            labelText: 'Username',
            border: UnderlineInputBorder(),
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: UnderlineInputBorder(),
          ),
        ),
        SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {
            // Add your forgot password logic here
            print('Forgot Password tapped');
          },
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16.0,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: _login,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4d2880),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            minimumSize: Size(double.infinity, 50.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Color(0xFF4d2880)),
            ),
          ),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
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
