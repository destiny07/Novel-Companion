import 'package:equatable/equatable.dart';

class UserConfig extends Equatable {
  final List<String> history;

  const UserConfig({required this.history});

  factory UserConfig.fromJson(Map<String, dynamic> data) {
    return UserConfig(
      history:
          data['history'] != null ? List<String>.from(data['history']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'history': history};
  }

  @override
  List<Object?> get props => [history];
}
