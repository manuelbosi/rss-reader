import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rss_reader/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:rss_reader/models/setting_keyword.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _keywordController = TextEditingController();

  @override
  void initState() {
    _getKeyword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
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
}
