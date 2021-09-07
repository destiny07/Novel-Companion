import 'package:equatable/equatable.dart';

class UserConfig extends Equatable {
  final double fontSize;
  final String fontStyle;
  final String theme;

  const UserConfig({
    required this.fontSize,
    required this.fontStyle,
    required this.theme
  });

  factory UserConfig.fromJson(Map<String, dynamic> data) {
    return UserConfig(
      fontSize: data['fontSize'] != null ? data['fontSize'].toDouble() : null,
      fontStyle: data['fontStyle'] != null ? data['fontStyle'] : null,
      theme: data['theme'] != null ? data['theme'] : null
    );
  }

  UserConfig copyWith({
    double? fontSize,
    String? fontStyle,
    String? theme,
  }) {
    return UserConfig(
      fontSize: fontSize ?? this.fontSize,
      fontStyle: fontStyle ?? this.fontStyle,
      theme: theme ?? this.theme,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fontSize': fontSize,
      'fontStyle': fontStyle,
      'theme': theme,
    };
  }

  @override
  List<Object?> get props => [fontSize, fontStyle, theme];
}
