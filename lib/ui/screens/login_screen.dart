import 'package:flutter/material.dart';
import 'package:project_lyca/ui/shared/shared.dart';

class LoginScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Email'),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Password'),
                obscureText: true,
              ),
              ElevatedButton(
                child: Text('Login'),
                onPressed: () {},
              ),
              DividerWithText(text: 'OR'),
              ElevatedButton(
                onPressed: () {},
                child: Text('Login with Google'),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Login with Apple'),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
