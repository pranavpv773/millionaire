import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static const _userToken = "user_token";
  static const _clientUrl = "_client";
  static const _transactionId = "transactionId";
  static const _countryName = "countryName";
  static const _bankName = "bankName";
  static const _raffleId = "raffleId";
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

  static String get countryName => _preference.getString(_countryName) ?? "";
  static set countryName(String value) =>
      _preference.setString(_countryName, value);
  static String get bankName => _preference.getString(_bankName) ?? "";
  static set bankName(String value) => _preference.setString(_bankName, value);
  static String get raffleId => _preference.getString(_raffleId) ?? "";
  static set raffleId(String value) => _preference.setString(_raffleId, value);
}
