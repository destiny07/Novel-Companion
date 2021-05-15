import 'package:equatable/equatable.dart';

class Description extends Equatable {
  final List<String> definitions;
  final List<String>? examples;
  final List<String>? synonyms;

  const Description({required this.definitions, this.examples, this.synonyms});

  factory Description.fromJson(Map<String, dynamic> data) {
    return Description(
      definitions: data['definitions'] != null
          ? (data['definitions'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          : [],
      examples: data['examples'] != null
          ? (data['examples'] as List<dynamic>).map((e) => e as String).toList()
          : [],
      synonyms: data['synonyms'] != null
          ? (data['synonyms'] as List<dynamic>).map((e) => e as String).toList()
          : [],
    );
  }

  @override
  List<Object?> get props => [definitions, examples, synonyms];
}
