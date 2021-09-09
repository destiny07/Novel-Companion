import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => UnknownScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Invalid Route')),
    );
  }
}
