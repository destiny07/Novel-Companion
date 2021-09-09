import 'package:cloud_functions/cloud_functions.dart';
import 'package:project_lyca/models/word.dart';
import 'package:project_lyca/services/contracts/dictionary_service.dart';
import 'package:project_lyca/services/messages/response_message.dart';

class FunctionsDictionaryService implements DictionaryService {
  @override
  Future<ResponseMessage<Word>> searchWord(String word) async {
    try {
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('getWord');
      final response = await callable.call(<String, dynamic>{'word': word});
      final responseData = response.data;

      if (responseData['isSuccess'] == true) {
        return ResponseMessage(
          data: Word.fromJson(
            Map<String, dynamic>.from(responseData['data']),
          ),
        );
      }

      return ResponseMessage(
        isSuccess: false,
        description: responseData['description'],
      );
    } catch (err) {
      return ResponseMessage(
        isSuccess: false,
        description: 'Problem occurred searching $word',
      );
    }
  }
}
