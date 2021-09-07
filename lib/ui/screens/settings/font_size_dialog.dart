import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';

class FontSizeDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FontSizeDialogState();
}

class _FontSizeDialogState extends State<FontSizeDialog> {
  final List<double> fontSizes = [11, 12, 13, 14, 15, 16, 17];
  late double _currentFontSize;

  @override
  void initState() {
    final blocState = BlocProvider.of<UserConfigBloc>(context).state;
    final fontSizeValue = blocState.fontSize;

    _currentFontSize = fontSizeValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: BlocListener<UserConfigBloc, UserConfigState>(
        listener: (listenerContext, state) {
          if (!state.isSaving && state.isSaveSuccessful) {
            Navigator.of(context).pop();
          }
        },
        child: Container(
          height: 64.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Font Size'),
              _fontSizeDropdown(),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        _saveButton(),
      ],
    );
  }

  Widget _saveButton() {
    return BlocBuilder<UserConfigBloc, UserConfigState>(
      buildWhen: (previous, current) => previous.isSaving != current.isSaving,
      builder: (context, state) {
        return TextButton(
          child: state.isSaving ? Text('Saving...') : Text('Save'),
          onPressed: state.isSaving
              ? null
              : () {
                  BlocProvider.of<UserConfigBloc>(context)
                      .add(UserConfigUpdateFontSize(_currentFontSize));
                },
        );
      },
    );
  }

  Widget _fontSizeDropdown() {
    return DropdownButton<double>(
      value: _currentFontSize,
      items: fontSizes
          .map((fontSize) => DropdownMenuItem<double>(
                value: fontSize,
                child: Text(
                  fontSize.toStringAsFixed(0),
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
