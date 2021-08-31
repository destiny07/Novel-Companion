import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/models/models.dart';

class WordInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WordInfoState();
}

class _WordInfoState extends State<WordInfo> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    flutterTts.setCompletionHandler(() {
      setState(() {
        BlocProvider.of<HomeBloc>(context).add(HomeToggleTts(false));
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        BlocProvider.of<HomeBloc>(context).add(HomeToggleTts(false));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (previous, current) {
        if (current.isTtsReading) {
          flutterTts.speak(current.word!.name);
        } else {
          flutterTts.stop();
        }
      },
      listenWhen: (previous, current) =>
          previous.isTtsReading != current.isTtsReading,
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => previous.word != current.word,
        builder: (context, state) {
          if (state.isShowWordInfo) {
            return _cardContainer(state.word!);
          }
          return Container();
        },
      ),
    );
  }

  Widget _cardContainer(Word word) {
    return Card(
      color: Colors.blue,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: Row(
                  children: [Text(word.name), Icon(Icons.volume_up)],
                ),
                onTap: () {
                  flutterTts.stop();
                  flutterTts.speak(word.name);
                },
              ),
              Text(word.pronunciation!.all),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _getSingleResult(word.results[index]);
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: word.results.length,
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
