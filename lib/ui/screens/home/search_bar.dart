import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.fromLTRB(8.0, 64, 8.0, 8.0),
      child: Padding(padding: EdgeInsets.all(8.0), child: TextField()),
      color: Colors.white,
      alignment: Alignment.topCenter,
    );
  }
}
