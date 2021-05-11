import 'package:flutter/material.dart';

class WordInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'hello',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
              ),
              Text(
                'noun',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Row(
            children: [
              TextButton.icon(
                icon: Icon(Icons.volume_down, color: Colors.black),
                label: Text(
                  "hɛ'loʊ",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              )
            ],
          ),
          Text(
            'an expression of greeting; a greeting; some sort of greeting',
            style: TextStyle(color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
          ),
          Text(
            'examples:',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            'every morning they exchanged polite hellos',
            style: TextStyle(color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
          ),
          Text(
            'synonyms:',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            'hi, howdy, hullo',
            style: TextStyle(color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
          ),
          Text(
            'antonyms:',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            'hi, howdy, hullo',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
