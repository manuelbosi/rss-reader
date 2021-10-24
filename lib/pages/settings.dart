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
  bool isSaved = false;
  late Icon buttonText;

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
    prefs.setString('keyword', _keywordController.text);
    setState(() {
      isSaved = true;
    });
    Navigator.pop(context);
  }

  void _getKeyword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String keyword = prefs.getString('keyword') ?? '';
    _keywordController.text = keyword;
  }

  // Open modal bottom sheet to add keyword
  // void _onClickAddKeyword(BuildContext context) {
  //   showModalBottomSheet(
  //       backgroundColor: Colors.transparent,
  //       context: context,
  //       isScrollControlled: true,
  //       builder: (BuildContext context) {
  //         return SingleChildScrollView(
  //             child: Container(
  //           padding: EdgeInsets.only(
  //               bottom: MediaQuery.of(context).viewInsets.bottom),
  //           child: Container(
  //             padding: const EdgeInsets.all(16),
  //             decoration: const BoxDecoration(
  //               color: blue,
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(20.0),
  //                 topRight: Radius.circular(20.0),
  //               ),
  //             ),
  //             child: Column(
  //               children: [
  //                 Row(
  //                   children: const [
  //                     Icon(
  //                       Icons.info,
  //                       color: Colors.white,
  //                       // size: 18 ,
  //                     ),
  //                     SizedBox(
  //                       width: 8,
  //                     ),
  //                     Expanded(
  //                       child: Text(
  //                         'Add your keyword typing in the textfield and tap the save button',
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 15,
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //                 const SizedBox(
  //                   height: 16,
  //                 ),
  //                 TextFormField(
  //                   style: const TextStyle(color: Colors.white),
  //                   cursorColor: Colors.blueAccent,
  //                   controller: _keywordController,
  //                   decoration: InputDecoration(
  //                     contentPadding: const EdgeInsets.symmetric(
  //                         horizontal: 10, vertical: 0),
  //                     focusedBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(5.0),
  //                       borderSide: const BorderSide(
  //                         color: Colors.blueAccent,
  //                         width: 1.0,
  //                       ),
  //                     ),
  //                     enabledBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(5.0),
  //                       borderSide: const BorderSide(
  //                         color: Colors.blueAccent,
  //                         width: 1.0,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 8,
  //                 ),
  //                 MaterialButton(
  //                     minWidth: double.infinity,
  //                     color: Colors.greenAccent,
  //                     child: const Text('SAVE'),
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     })
  //               ],
  //             ),
  //           ),
  //         ));
  //       });
  // }

}

class SettingRow extends StatelessWidget {
  const SettingRow({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}
