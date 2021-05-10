import 'package:equatable/equatable.dart';

class Pronunciation extends Equatable {
  final String diacritics;
  final String? audioUrl;

  const Pronunciation({
    required this.diacritics,
    this.audioUrl,
  });

  @override
  List<Object?> get props => [diacritics, audioUrl];
}
