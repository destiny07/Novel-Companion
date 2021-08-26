import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Padding(padding: EdgeInsets.all(8.0), child: TextField()),
      color: Colors.white,
      alignment: Alignment.topCenter,
    );
  }
}
