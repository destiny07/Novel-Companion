import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:project_lyca/models/word.dart';
import 'package:project_lyca/services/contracts/dictionary_service.dart';
import 'package:project_lyca/constants.dart' as constants;

class FunctionsDictionaryService implements DictionaryService {
  @override
  Future<List<Word>> searchWord(String word) async {
    final url = Uri.parse('${constants.dictionaryApiUrl}/$word');
    final response = await http.get(url);
    final words = (jsonDecode(response.body) as List<dynamic>);
    return words.map((e) => Word.fromJson(e)).toList();
  }
}
