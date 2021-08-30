import 'package:cloud_functions/cloud_functions.dart';
import 'package:project_lyca/models/word.dart';
import 'package:project_lyca/services/contracts/dictionary_service.dart';

class FunctionsDictionaryService implements DictionaryService {
  @override
  Future<Word> searchWord(String word) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('getWord');
    final response = await callable.call(<String, dynamic>{'word': word});
    final responseData = response.data;

    if (responseData['isSuccess'] == true) {
      return Word.fromJson(Map<String, dynamic>.from(responseData['data']));
    }

    throw Exception();
  }
}
