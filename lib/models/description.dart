import 'package:equatable/equatable.dart';

class Description extends Equatable {
  final List<String> definitions;
  final List<String>? examples;
  final List<String>? synonyms;

  const Description({required this.definitions, this.examples, this.synonyms});

  factory Description.fromJson(Map<String, dynamic> data) {
    return Description(
      definitions: data['definitions'],
      examples: data['examples'],
      synonyms: data['synonyms'],
    );
  }

  @override
  List<Object?> get props => [definitions, examples, synonyms];
}
