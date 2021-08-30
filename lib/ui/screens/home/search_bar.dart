import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.blueAccent,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 32.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
      alignment: Alignment.topCenter,
    );
  }
}
