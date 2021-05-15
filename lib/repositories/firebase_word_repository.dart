import 'package:cloud_functions/cloud_functions.dart';
import 'package:project_lyca/models/word.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';

class FirebaseWordRepository implements WordRepository {
  @override
  Future<List<Word>> searchWord(String word) async {
    final callable =
        FirebaseFunctions.instance.httpsCallable('app/words/$word');
    final results = (await callable() as List<dynamic>);
    return results.map((e) => Word.fromJson(e)).toList();
  }
}
