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
          if (state.word != null) {
            return _cardContainer(state.word!);
          }
          return Container();
        },
      ),
    );
  }

  Widget _cardContainer(Word word) {
    return Card(
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        Text(
                          word.name,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Icon(Icons.volume_up),
                      ],
                    ),
                    onTap: () {
                      flutterTts.stop();
                      flutterTts.speak(word.name);
                    },
                  ),
                  InkWell(
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).buttonColor,
                    ),
                    onTap: () {
                      BlocProvider.of<HomeBloc>(context).add(
                        HomeToggleWordInfo(false),
                      );
                    },
                  ),
                ],
              ),
              _pronunciation(word.pronunciation),
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

  Widget _pronunciation(Pronunciation? pronunciation) {
    return pronunciation != null
        ? Text(
            pronunciation.all,
            style: Theme.of(context).textTheme.bodyText1,
          )
        : Container();
  }

  Widget _getSingleResult(Result result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          result.partOfSpeech,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          result.definition,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        result.synonyms.isEmpty
            ? Container()
            : Text(
                'Synonyms',
                style: Theme.of(context).textTheme.bodyText1,
              ),
        result.synonyms.isEmpty
            ? Container()
            : Text(
                result.synonyms.join(', '),
                style: Theme.of(context).textTheme.bodyText1,
              ),
        result.antonyms.isEmpty
            ? Container()
            : Text(
                'Antonyms',
                style: Theme.of(context).textTheme.bodyText1,
              ),
        result.antonyms.isEmpty
            ? Container()
            : Text(
                result.antonyms.join(', '),
                style: Theme.of(context).textTheme.bodyText1,
              ),
        result.examples.isEmpty
            ? Container()
            : Text(
                'Examples',
                style: Theme.of(context).textTheme.bodyText1,
              ),
        result.examples.isEmpty
            ? Container()
            : Text(
                result.examples.join('; '),
                style: Theme.of(context).textTheme.bodyText1,
              ),
      ],
    );
  }
}
