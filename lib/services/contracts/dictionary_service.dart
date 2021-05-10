import 'package:project_lyca/models/models.dart';

abstract class DictionaryService {
  Future<Word> getWord(String word);
}
