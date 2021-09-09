import 'package:project_lyca/models/models.dart';
import 'package:project_lyca/services/messages/response_message.dart';

abstract class DictionaryService {
  Future<ResponseMessage<Word>> searchWord(String word);
}