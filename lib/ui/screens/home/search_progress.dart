import 'package:flutter/material.dart';

class SearchProgress extends StatefulWidget {
  final Function onCancel;

  SearchProgress({required this.onCancel});

  @override
  State<StatefulWidget> createState() => _SearchProgressState();
}

class _SearchProgressState extends State<SearchProgress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Searching',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () => widget.onCancel(),
          ),
        ],
      ),
    );
  }
}
