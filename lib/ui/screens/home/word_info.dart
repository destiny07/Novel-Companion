import 'package:flutter/material.dart';
import 'package:project_lyca/models/models.dart';

class WordInfo extends StatelessWidget {
  final Word word;

  WordInfo({required this.word});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(this.word.name),
              Text(this.word.pronunciation!.all),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _getSingleResult(word.results[index]);
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: this.word.results.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getSingleResult(Result result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(result.partOfSpeech),
        Text(result.definition),
        result.synonyms.isEmpty ? Container() : Text('Synonyms'),
        result.synonyms.isEmpty
            ? Container()
            : Text(result.synonyms.join(', ')),
        result.antonyms.isEmpty ? Container() : Text('Antonyms'),
        result.antonyms.isEmpty
            ? Container()
            : Text(result.antonyms.join(', ')),
        result.examples.isEmpty ? Container() : Text('Examples'),
        result.examples.isEmpty
            ? Container()
            : Text(result.examples.join('; ')),
      ],
    );
  }
}
