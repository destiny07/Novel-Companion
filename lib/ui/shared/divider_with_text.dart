import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(child: Divider(thickness: 1)),
          Padding(
            child: Text(text),
            padding: EdgeInsets.symmetric(horizontal: 10),
          ),
          Expanded(child: Divider(thickness: 1)),
        ],
      ),
    );
  }
}
