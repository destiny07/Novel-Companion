import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/constants.dart' as constants;
import 'package:project_lyca/ui/custom_font.dart';

class FontDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FontDialogState();
}

class _FontDialogState extends State<FontDialog> {
  late String _currentFontStyle;

  @override
  void initState() {
    final blocState = BlocProvider.of<UserConfigBloc>(context).state;
    _currentFontStyle = blocState.fontStyle;
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
              Text('Font'),
              _fontStyleDropdown(),
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
                      .add(UserConfigUpdateFontStyle(_currentFontStyle));
                },
        );
      },
    );
  }

  Widget _fontStyleDropdown() {
    return DropdownButton<String>(
      value: _currentFontStyle,
      items: constants.fontNameMap.keys
          .map((fontNameKey) => DropdownMenuItem<String>(
                value: fontNameKey,
                child: Text(
                  constants.fontNameMap[fontNameKey]!,
                  style: CustomFont.fontStyleMap[fontNameKey],
                ),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _currentFontStyle = value!;
        });
      },
    );
  }
}
