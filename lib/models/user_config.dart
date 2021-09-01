import 'package:equatable/equatable.dart';

class UserConfig extends Equatable {
  final List<String> history;
  final int fontSize;
  final String fontStyle;

  const UserConfig({
    required this.history,
    required this.fontSize,
    required this.fontStyle,
  });

  factory UserConfig.fromJson(Map<String, dynamic> data) {
    return UserConfig(
      history:
          data['history'] != null ? List<String>.from(data['history']) : [],
      fontSize: data['fontSize'] != null ? data['fontSize'] : null,
      fontStyle: data['fontStyle'] != null ? data['fontStyle'] : null,
    );
  }

  UserConfig copyWith({
    List<String>? history,
    int? fontSize,
    String? fontStyle,
  }) {
    return UserConfig(
      history: history ?? this.history,
      fontSize: fontSize ?? this.fontSize,
      fontStyle: fontStyle ?? this.fontStyle,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'history': history,
      'fontSize': fontSize,
      'fontStyle': fontStyle,
    };
  }

  @override
  List<Object?> get props => [history, fontSize, fontStyle];
}
