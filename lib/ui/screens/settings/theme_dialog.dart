import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/constants.dart' as constants;
import 'package:project_lyca/ui/custom_font.dart';
import 'package:project_lyca/ui/custom_theme.dart';

class ThemeDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {
  late String _currentTheme;
  late TextStyle _fontStyleTheme;

  @override
  void initState() {
    super.initState();
    final blocState = BlocProvider.of<UserConfigBloc>(context).state;
    final fontSizeValue = blocState.theme;
    final fontStyle = blocState.fontStyle;

    _fontStyleTheme = CustomFont.fontStyleMap[fontStyle]!;
    _currentTheme = fontSizeValue;
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
          height: 170.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _preview(),
              _themeDropdown(),
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
        return ElevatedButton(
          child: state.isSaving ? Text('Saving...') : Text('Save'),
          onPressed: state.isSaving
              ? null
              : () {
                  BlocProvider.of<UserConfigBloc>(context)
                      .add(UserConfigUpdateTheme(_currentTheme));
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

  Widget _preview() {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: CustomTheme.getThemeByName(_currentTheme).backgroundColor,
            ),
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Example',
                        style: _fontStyleTheme.copyWith(
                            color: CustomTheme.getThemeByName(_currentTheme)
                                .textTheme
                                .bodyText1!
                                .color),
                      ),
                      Icon(
                        Icons.volume_up,
                        color: CustomTheme.getThemeByName(_currentTheme)
                            .textTheme
                            .bodyText1!
                            .color,
                      ),
                    ],
                  ),
                  Text(
                    'Some example text for you.',
                    style: _fontStyleTheme.copyWith(
                        color: CustomTheme.getThemeByName(_currentTheme)
                            .textTheme
                            .bodyText1!
                            .color),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.flash_on,
                color:
                    CustomTheme.getThemeByName(_currentTheme).iconTheme.color,
              ),
              Icon(
                Icons.search,
                color:
                    CustomTheme.getThemeByName(_currentTheme).iconTheme.color,
              ),
              Icon(
                Icons.settings,
                color:
                    CustomTheme.getThemeByName(_currentTheme).iconTheme.color,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _themeDropdown() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Color.fromRGBO(1, 0, 31, 1),
          width: 0.5,
        ),
      ),
      child: DropdownButton<String>(
        isDense: true,
        isExpanded: true,
        underline: Container(),
        value: _currentTheme,
        items: constants.themeNameMap.keys
            .map(
              (themeKey) => DropdownMenuItem<String>(
                value: themeKey,
                child: Text(
                  constants.themeNameMap[themeKey]!,
                  style: GoogleFonts.workSans(),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            _currentTheme = value!;
          });
        },
      ),
    );
  }
}
