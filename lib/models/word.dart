import 'package:equatable/equatable.dart';
import 'package:project_lyca/models/models.dart';

class Word extends Equatable {
  final String name;
  final List<Phonetics>? phonetics;
  final List<Meaning> meanings;

  const Word({
    required this.name,
    required this.meanings,
    this.phonetics,
  });

  factory Word.fromJson(Map<String, dynamic> data) {
    return Word(
      name: data['name'],
      phonetics: (data['phonetics'] as List<dynamic>)
          .map((phonetic) => Phonetics.fromJson(phonetic))
          .toList(),
      meanings: (data['meanings'] as List<dynamic>)
          .map((e) => Meaning.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [name, phonetics, meanings];
}
