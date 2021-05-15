import 'package:equatable/equatable.dart';
import 'package:project_lyca/models/models.dart';

class Meaning extends Equatable {
  final String partOfSpeech;
  final List<Description> descriptions;

  const Meaning({required this.partOfSpeech, required this.descriptions});

  factory Meaning.fromJson(Map<String, dynamic> data) {
    return Meaning(
        partOfSpeech: data['partOfSpeech'],
        descriptions: (data['descriptions'] as List<dynamic>)
            .map((e) => Description.fromJson(e))
            .toList());
  }

  @override
  List<Object?> get props => [partOfSpeech, descriptions];
}
