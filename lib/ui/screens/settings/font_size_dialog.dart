import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
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
        listener: (listenerContext, state) async {
          if (!state.isSaving && state.isSaveSuccessful) {
            Navigator.of(context).pop();
          } else if (!state.isSaving && !state.isSaveSuccessful) {
            await Fluttertoast.cancel();
            await Fluttertoast.showToast(
              msg: "Error saving font size.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        child: Container(
          height: 64.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Font Size',
                style: GoogleFonts.workSans(
                  fontWeight: FontWeight.bold,
                ),
              ),
              _fontSizeDropdown(),
            ],
          ),
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 8.0),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            primary: Color.fromRGBO(1, 0, 31, 1),
            textStyle: GoogleFonts.workSans(
              fontWeight: FontWeight.bold,
            ),
          ),
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
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(186, 226, 221, 1),
            onPrimary: Colors.white,
            textStyle: GoogleFonts.workSans(
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  Widget _fontSizeDropdown() {
    return DropdownButton<double>(
      underline: Container(),
      value: _currentFontSize,
      items: fontSizes
          .map((fontSize) => DropdownMenuItem<double>(
                value: fontSize,
                child: Text(
                  fontSize.toStringAsFixed(0),
                  style: GoogleFonts.workSans(),
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
