import 'package:project_lyca/models/models.dart';

abstract class DictionaryService {
  Future<List<Word>> searchWord(String word);
}