import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:project_lyca/models/models.dart';
import 'package:project_lyca/services/contracts/contracts.dart';
import 'package:project_lyca/constants.dart' as Constants;

class WordsApiService implements DictionaryService {
  @override
  Future<Word> getWord(String word) async {
    final response =
        await http.get(Uri.https(Constants.dictionaryApiUrl, 'words/$word'));
    return Word.fromJson(jsonDecode(response.body));
  }
}
