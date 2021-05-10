import 'package:equatable/equatable.dart';

class Pronunciation extends Equatable {
  final String diacritics;
  final String? audioUrl;

  const Pronunciation({
    required this.diacritics,
    this.audioUrl,
  });

  factory Pronunciation.fromJson(Map<String, dynamic> data) {
    return Pronunciation(diacritics: data['diacritics']);
  }

  @override
  List<Object?> get props => [diacritics, audioUrl];
}
