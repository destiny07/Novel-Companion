import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Login'),
            TextField(),
            TextField(),
            Divider(height: 1)
          ],
        ),
      ),
    );
  }
}
