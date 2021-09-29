import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_lyca/models/user_config.dart';
import 'package:project_lyca/services/contracts/user_config_service.dart';

class FirebaseUserConfigService implements UserConfigService {
  final FirebaseFirestore _firestore;

  FirebaseUserConfigService() : _firestore = FirebaseFirestore.instance;

  @override
  Future<UserConfig?> getUserConfig(String uuid) async {
    final userSnapshot = await _firestore.collection("users").doc(uuid).get();

    if (!userSnapshot.exists) {
      return null;
    }

    final data = userSnapshot.data();
    return UserConfig.fromJson(data!);
  }

  @override
  Future setUserConfig(String uuid, UserConfig userConfig) async {
    final documentReference = _firestore.collection("users").doc(uuid);
    await documentReference.set(userConfig.toJson());
  }
}
