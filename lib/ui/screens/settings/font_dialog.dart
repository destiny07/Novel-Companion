import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';

class FontDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FontDialogState();
}

class _FontDialogState extends State<FontDialog> {
  final List<int> fontSizes = [11, 12, 13, 14, 15, 16, 17];
  late int _currentFontSize;

  @override
  void initState() {
    final blocState = BlocProvider.of<UserConfigBloc>(context).state;
    final fontSizeValue = blocState.userConfig!.fontSize;

    _currentFontSize = fontSizeValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 64.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Font Size'),
            _fontSizeDropdown(),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            BlocProvider.of<UserConfigBloc>(context)
                .add(UserConfigUpdateFontSize(_currentFontSize));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _fontSizeDropdown() {
    return DropdownButton<int>(
      value: _currentFontSize,
      items: fontSizes
          .map((fontSize) => DropdownMenuItem<int>(
                value: fontSize,
                child: Text(
                  fontSize.toString(),
                ),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _currentFontSize = value!;
        });
      },
    );
  }
}
