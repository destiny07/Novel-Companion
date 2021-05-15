import 'package:project_lyca/models/models.dart';

abstract class WordRepository {
  Future<List<Word>> searchWord(String word);
}
