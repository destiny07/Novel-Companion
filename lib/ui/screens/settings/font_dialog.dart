import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/constants.dart' as constants;

class FontDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FontDialogState();
}

class _FontDialogState extends State<FontDialog> {
  static final Map<String, TextStyle> fontStyleMap = {
    constants.latoKey: GoogleFonts.lato(),
    constants.notoSansKey: GoogleFonts.notoSans(),
    constants.openSansKey: GoogleFonts.openSans(),
    constants.oswaldKey: GoogleFonts.oswald(),
    constants.poppinsKey: GoogleFonts.poppins(),
    constants.robotoKey: GoogleFonts.roboto(),
  };
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
      content: Container(
        height: 64.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Font'),
            _fontStyleDropdown(),
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
                .add(UserConfigUpdateFontStyle(_currentFontStyle));
            Navigator.of(context).pop();
          },
        ),
      ],
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
                  style: fontStyleMap[fontNameKey],
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
