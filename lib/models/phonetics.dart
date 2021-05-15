import 'package:equatable/equatable.dart';

class Phonetics extends Equatable {
  final String text;
  final String? audio;

  const Phonetics({required this.text, this.audio});

  factory Phonetics.fromJson(Map<String, dynamic> data) {
    return Phonetics(text: data['text'], audio: data['audio']);
  }

  @override
  List<Object?> get props => [text, audio];
}
