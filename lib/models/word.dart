import 'package:equatable/equatable.dart';
import 'package:project_lyca/models/models.dart';

class Word extends Equatable {
  final String name;
  final String partOfSpeech;
  final List<String> descriptions;
  final List<String>? examples;
  final List<String>? synonyms;
  final List<String>? antonyms;
  final List<Pronunciation>? pronunciations;

  const Word({
    required this.name,
    required this.partOfSpeech,
    required this.descriptions,
    this.examples,
    this.synonyms,
    this.antonyms,
    this.pronunciations,
  });

  @override
  List<Object?> get props => [
        name,
        partOfSpeech,
        descriptions,
        examples,
        synonyms,
        antonyms,
        pronunciations,
      ];
}
