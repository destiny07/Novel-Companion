import 'package:flutter/material.dart';
import 'package:project_lyca/ui/screens/home/word_info.dart';

class WordSearchResultCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, count) {
        var bottomPadding = 16.0;

        if (count == 0) {
          bottomPadding = 4.0;
        }

        return Container(
          color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: WordInfo(),
          ),
        );
      },
      itemCount: 1,
    );
  }
}
