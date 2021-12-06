import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import 'package:mise_news/constants/app_constants.dart';
import 'package:mise_news/services/shared_preferences.dart';
import 'package:mise_news/components/animated_switch.dart';

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
    _initNotificationsPreference();
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text("PAROLA CHIAVE"),
                    subtitle: Column(
                      children: [
                        const Text(
                            "L'applicazione aggiorna in background la lista di feed e invia una notifica quando trova un feed che contiene quella parola impostata."),
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller: _keywordController,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            hintText: 'Scrivi una parola...',
                          ),
                          onChanged: (_) {
                            _onChangeKeyword(_keywordController.text);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text("NOTIFICHE"),
                    subtitle: const Text(
                        "Abilita o disabilita la ricezione di notifiche"),
                    trailing: AnimatedSwitch(
                      value: enableNotifications,
                      leftText: 'ON',
                      rightText: 'OFF',
                      onChanged: (value) =>
                          _updateNotificationsPreference(value),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onChangeKeyword(String keyword) async {
    await setKeyword(keyword);
  }

  void _getKeyword() async {
    final String keyword = await getKeyword();
    _keywordController.text = keyword;
  }

  void _updateNotificationsPreference(bool notificationPref) async {
    await setNotificationsPreference(notificationPref);
    if (notificationPref && enableNotifications != true) {
      Workmanager().registerPeriodicTask(
        "NEW_FEED",
        "newFeedNotification",
        existingWorkPolicy: ExistingWorkPolicy.replace,
      );
    } else {
      Workmanager().cancelByUniqueName("NEW_FEED");
    }

    setState(() {
      enableNotifications = notificationPref;
    });
  }

  void _initNotificationsPreference() async {
    final bool notificationsPref = await getNotificationsPreference();
    setState(() {
      enableNotifications = notificationsPref;
    });
  }

  Widget showActiveKeywordLabel() {
    return _keywordController.text.isNotEmpty
        ? Column(
            children: [
              Row(
                children: [
                  Text(
                    "Active keyword:",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900),
                  ),
                  Text(
                    " ${_keywordController.text}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          )
        : Row();
  }
}
