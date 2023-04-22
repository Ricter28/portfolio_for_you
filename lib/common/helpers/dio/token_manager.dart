import 'package:flutter_template/common/constants/keys/hive_keys.dart';
import 'package:flutter_template/common/helpers/error/hive/hive.helper.dart';
import 'package:flutter_template/modules/presentation/facebook/bloc/app_setting.dart';

class TokenManager {
  const TokenManager();

  //
  Future<bool> checkActiveLogin() async {
    return DateTime.now().isAfter(activeLogin);
  }
  //

  Future<String?> getAccessToken() async {
    return await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.accessToken,
    );
  }

  Future<String> getRefreshToken() async {
    return await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.refreshToken,
    )??'';
  }

  Future<DateTime?> getTokenExpiredTime() async {
    String expiredTime = await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.expiresIn,
    );
    return DateTime.parse(expiredTime);
  }

  Future<void> setAccessToken(String accessToken) async {
    await HiveHelper.put(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.accessToken,
      value: accessToken,
    );
  }

  Future<void> setRefreshToken(String refreshToken) async {
    await HiveHelper.put(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.refreshToken,
      value: refreshToken,
    );
  }

  Future<void> setTokenExpiredTime(int expiredTime) async {
    await HiveHelper.put(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.expiresIn,
      value:
          DateTime.now().add(Duration(seconds: expiredTime)).toIso8601String(),
    );
  }

  Future<bool> isAccessTokenInvalid() async {
    try {
      DateTime? expiredTime = await getTokenExpiredTime();
      if (DateTime.now()
          .toUtc()
          .add(const Duration(seconds: 10))
          .isAfter(expiredTime!)) {
        return true;
      }
      return false;
    } catch (_) {
      return true;
    }
  }

  Future<void> cleanAuthBox() async {
    await HiveHelper.clear(boxName: HiveKeys.authBox);
  }
}
