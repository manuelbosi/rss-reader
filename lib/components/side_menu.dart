import 'package:flutter/material.dart';
import 'package:rss_reader/models/side_menu_item.dart';

List<SideMenuItem> menuEntries = [
  SideMenuItem(text: "Impostazioni"),
];

Widget sideMenu(BuildContext context) {
  return Drawer(
    child: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(color: Colors.greenAccent.shade200),
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
              onPressed: () {},
              splashColor: Colors.white,
              child: Text(menuEntries[index].text),
            );
          },
        ),
      )
    ])),
  );
}
