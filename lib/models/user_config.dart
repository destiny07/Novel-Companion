import 'package:equatable/equatable.dart';

class UserConfig extends Equatable {
  final List<String> history;

  const UserConfig({
    required this.history
  });

  @override
  List<Object?> get props => [history];
}