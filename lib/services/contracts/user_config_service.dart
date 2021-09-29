import 'package:project_lyca/models/models.dart';

abstract class UserConfigService {
  Future<UserConfig?> getUserConfig(String uuid);
  Future setUserConfig(String uuid, UserConfig userConfig);
}
