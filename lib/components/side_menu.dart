import 'package:flutter/material.dart';
import 'package:rss_reader/constants/app_constants.dart';
import 'package:rss_reader/models/side_menu_item.dart';
import 'package:rss_reader/pages/settings_page.dart';

List<SideMenuItem> menuEntries = [
  SideMenuItem(text: "Impostazioni"),
];

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.symmetric(horizontal: 5),
            itemCount: menuEntries.length,
            itemBuilder: (context, index) {
              return SettingButton(
                icon: Icons.settings,
                name: menuEntries[index].text,
              );
            },
          ),
        )
      ])),
    );
  }
}

class SettingButton extends StatelessWidget {
  const SettingButton({Key? key, required this.icon, required this.name})
      : super(key: key);

  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 26,
          color: Colors.black87,
        ),
        const SizedBox(
          width: 8,
        ),
        RawMaterialButton(
          highlightColor: Colors.transparent,
          onPressed: () {
            // Navigator.pushNamed(context, '/settings');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Settings()));
          },
          splashColor: Colors.transparent,
          child: Text(
            name,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        )
      ],
    );
  }
}
