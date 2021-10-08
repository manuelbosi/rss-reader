import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rss_reader/constants/app_constants.dart';
import 'package:rss_reader/models/side_menu_item.dart';
import 'package:rss_reader/pages/settings.dart';

List<SideMenuItem> menuEntries = [
  SideMenuItem(text: "Impostazioni"),
];

class SideMenu extends StatelessWidget {
  const SideMenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Drawer(
    child: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        width: double.infinity,
        height: 150,
        decoration: const BoxDecoration(color: blue),
        child: const Center(
          child: Text(
            "RSS READER",
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: menuEntries.length,
          itemBuilder: (context, index) {
            return RawMaterialButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/settings');
                Navigator.push(context, CupertinoPageRoute(builder: (context) => const Settings()));
              },
              splashColor: Colors.white,
              child: Text(menuEntries[index].text),
            );
          },
        ),
      )
    ])),
  );
  }
}