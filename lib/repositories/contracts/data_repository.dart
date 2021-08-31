import 'package:project_lyca/models/models.dart';

abstract class DataRepository {
  Future<UserConfig?> getUserConfig(String uuid);
  Future setUserConfig(String uuid, UserConfig userConfig);
}
