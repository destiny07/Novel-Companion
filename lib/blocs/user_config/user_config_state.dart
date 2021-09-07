part of 'user_config_bloc.dart';

class UserConfigState extends Equatable {
  final String fontStyle;
  final double fontSize;
  final String theme;
  final bool isFetching;
  final bool isFetchSuccess;

  const UserConfigState({
    required this.fontStyle,
    required this.fontSize,
    required this.theme,
    this.isFetching = false,
    this.isFetchSuccess = false,
  });

  factory UserConfigState.initial() {
    return UserConfigState(
      fontSize: constants.defaultFontSize,
      fontStyle: constants.defaultFontStyle,
      theme: constants.defaultTheme,
    );
  }

  UserConfigState copyWith({
    String? fontStyle,
    double? fontSize,
    String? theme,
    bool? isFetching,
    bool? isFetchSuccess,
  }) {
    return UserConfigState(
      fontStyle: fontStyle ?? this.fontStyle,
      fontSize: fontSize ?? this.fontSize,
      theme: theme ?? this.theme,
      isFetching: isFetching ?? this.isFetching,
      isFetchSuccess: isFetchSuccess ?? this.isFetchSuccess,
    );
  }

  @override
  List<Object?> get props => [
        fontStyle,
        fontSize,
        theme,
        isFetching,
        isFetchSuccess,
      ];
}
