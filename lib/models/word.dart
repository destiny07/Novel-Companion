import 'package:equatable/equatable.dart';

class Word extends Equatable {
  final String name;
  final List<Result> results;
  final Syllables? syllables;
  final Pronunciation? pronunciation;

  const Word({
    required this.name,
    required this.results,
    required this.syllables,
    required this.pronunciation,
  });

  factory Word.fromJson(Map<String, dynamic> data) {
    return Word(
      name: data['word'],
      results: data['results'] != null
          ? List.from(data['results'])
              .map((e) => Result.fromJson(Map<String, dynamic>.from(e)))
              .toList()
          : [],
      syllables: data['syllables'] != null
          ? Syllables.fromJson(Map<String, dynamic>.from(data['syllables']))
          : null,
      pronunciation: data['pronunciation'] != null
          ? Pronunciation.fromJson(
              Map<String, dynamic>.from(data['pronunciation']))
          : null,
    );
  }

  @override
  List<Object?> get props => [name, results, syllables, pronunciation];
}

class Result extends Equatable {
  final String definition;
  final String partOfSpeech;
  final List<String> synonyms;
  final List<String> antonyms;
  final List<String> examples;

  const Result({
    required this.definition,
    required this.partOfSpeech,
    required this.synonyms,
    required this.antonyms,
    required this.examples,
  });

  factory Result.fromJson(Map<String, dynamic> data) {
    return Result(
      definition: data['definition'],
      partOfSpeech: data['partOfSpeech'],
      synonyms:
          data['synonyms'] != null ? List<String>.from(data['synonyms']) : [],
      antonyms:
          data['antonyms'] != null ? List<String>.from(data['antonyms']) : [],
      examples:
          data['examples'] != null ? List<String>.from(data['examples']) : [],
    );
  }

  @override
  List<Object?> get props => [
        definition,
        partOfSpeech,
        synonyms,
        antonyms,
        examples,
      ];
}

class Syllables extends Equatable {
  final int count;
  final List<String> list;

  const Syllables({required this.count, required this.list});

  factory Syllables.fromJson(Map<String, dynamic> data) {
    return Syllables(
      count: data['count'],
      list: data['list'] != null ? List<String>.from(data['list']) : [],
    );
  }

  @override
  List<Object?> get props => [count, list];
}

class Pronunciation extends Equatable {
  final String all;

  const Pronunciation({required this.all});

  factory Pronunciation.fromJson(Map<String, dynamic> data) {
    return Pronunciation(all: data['all']);
  }

  @override
  List<Object?> get props => [all];
}
