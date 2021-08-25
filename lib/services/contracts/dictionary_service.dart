import 'package:project_lyca/models/models.dart';

abstract class DictionaryService {
  Future<Word> searchWord(String word);
}