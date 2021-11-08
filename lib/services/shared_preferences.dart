import 'package:shared_preferences/shared_preferences.dart';

Future<void> setKeyword(String keyword) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('KEYWORD', keyword);
}

Future<String> getKeyword() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String keyword = prefs.getString('KEYWORD') ?? '';
  return keyword;
}

Future<void> setNotificationsPreference(bool notificationPref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('ENABLE_NOTIFICATIONS', notificationPref);
}

Future<bool> getNotificationsPreference() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final notificationsPref = prefs.getBool('ENABLE_NOTIFICATIONS') ?? false;
  return notificationsPref;
}
