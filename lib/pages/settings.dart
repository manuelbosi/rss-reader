import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rss_reader/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
// import 'package:rss_reader/models/setting_keyword.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _keywordController = TextEditingController();
  bool enableNotifications = false;

  @override
  void initState() {
    _getNotificationsPreference();
    _getKeyword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "YOUR KEYWORD",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _keywordController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: 'Type here...',
              ),
            ),
            MaterialButton(
              minWidth: double.infinity,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              elevation: 0,
              highlightElevation: 2,
              onPressed: () {
                _onClickSave();
              },
              color: blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text(
                  "NOTIFICATIONS",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(child: Container()),
                Switch(
                  activeColor: blue,
                  value: enableNotifications,
                  onChanged: (value) => _updateNotificationsPreference(value),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onClickSave() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('KEYWORD', _keywordController.text);
    Navigator.pop(context);
  }

  void _getKeyword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String keyword = prefs.getString('KEYWORD') ?? '';
    _keywordController.text = keyword;
  }

  void _updateNotificationsPreference(bool notificationPref) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('ENABLE_NOTIFICATIONS', notificationPref);

    if (notificationPref) {
      Workmanager().registerPeriodicTask(
        "NEW_FEED",
        "newFeedNotification",
        existingWorkPolicy: ExistingWorkPolicy.replace,
      );
      log("NOTIFICATION ON");
    } else {
      Workmanager().cancelByUniqueName("NEW_FEED");
      log("NOTIFICATION OFF");
    }

    setState(() {
      enableNotifications = notificationPref;
    });
  }

  void _getNotificationsPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final notificationsPref = prefs.getBool('ENABLE_NOTIFICATIONS') ?? false;

    setState(() {
      enableNotifications = notificationsPref;
    });
  }
}
