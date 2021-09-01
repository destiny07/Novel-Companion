import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      content: Container(
        height: 170.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _preview(),
            _themeDropdown(),
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
                .add(UserConfigUpdateTheme(_currentTheme));
            Navigator.of(context).pop();
          },
        ),
      ],
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
              color: _getThemeDataByName(_currentTheme).backgroundColor,
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
                            color: _getThemeDataByName(_currentTheme)
                                .textTheme
                                .bodyText1!
                                .color),
                      ),
                      Icon(
                        Icons.volume_up,
                        color: _getThemeDataByName(_currentTheme)
                            .textTheme
                            .bodyText1!
                            .color,
                      ),
                    ],
                  ),
                  Text(
                    'Some example text for you.',
                    style: _fontStyleTheme.copyWith(
                        color: _getThemeDataByName(_currentTheme)
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
                color: _getThemeDataByName(_currentTheme).iconTheme.color,
              ),
              Icon(
                Icons.search,
                color: _getThemeDataByName(_currentTheme).iconTheme.color,
              ),
              Icon(
                Icons.settings,
                color: _getThemeDataByName(_currentTheme).iconTheme.color,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _themeDropdown() {
    return DropdownButton<String>(
      value: _currentTheme,
      items: constants.themeNameMap.keys
          .map((themeKey) => DropdownMenuItem<String>(
                value: themeKey,
                child: Text(constants.themeNameMap[themeKey]!),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _currentTheme = value!;
        });
      },
    );
  }

  ThemeData _getThemeDataByName(String themeName) {
    switch (themeName) {
      case constants.blueThemeKey:
        return CustomTheme.blueTheme;
      case constants.whiteThemeKey:
        return CustomTheme.whiteTheme;
      case constants.darkThemeKey:
        return CustomTheme.darkTheme;
      case constants.grayThemeKey:
        return CustomTheme.grayTheme;
      case constants.pinkThemeKey:
        return CustomTheme.pinkTheme;
      default:
        return CustomTheme.blueTheme;
    }
  }
}
