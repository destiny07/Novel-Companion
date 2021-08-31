import 'package:equatable/equatable.dart';

class UserConfig extends Equatable {
  final List<String> history;
  final int fontSize;

  const UserConfig({required this.history, required this.fontSize});

  factory UserConfig.fromJson(Map<String, dynamic> data) {
    return UserConfig(
      history:
          data['history'] != null ? List<String>.from(data['history']) : [],
      fontSize: data['fontSize'] != null ? data['fontSize'] : null,
    );
  }

  UserConfig copyWith({
    List<String>? history,
    int? fontSize,
  }) {
    return UserConfig(
      history: history ?? this.history,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  Map<String, dynamic> toJson() {
    return {'history': history, 'fontSize': fontSize};
  }

  @override
  List<Object?> get props => [history, fontSize];
}
