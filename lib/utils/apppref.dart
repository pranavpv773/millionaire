import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static const _userToken = "user_token";
  static const _clientUrl = "_client";
  static const _transactionId = "transactionId";
  static late final SharedPreferences _preference;

  void reloadPreference() async {
    await _preference.reload();
  }

  static Future<void> init() async {
    _preference = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    await _preference.clear();
  }

  //User Token
  static String get userToken => _preference.getString(_userToken) ?? "";
  static set userToken(String value) =>
      _preference.setString(_userToken, value);
  //Client Url
  static String get clientUrl => _preference.getString(_clientUrl) ?? "";
  static set clientUrl(String value) =>
      _preference.setString(_clientUrl, value);
  //Transaction Id
  static String get transactionId =>
      _preference.getString(_transactionId) ?? "";
  static set transactionId(String value) =>
      _preference.setString(_transactionId, value);
}
