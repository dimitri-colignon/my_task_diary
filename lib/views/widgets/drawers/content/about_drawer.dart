import 'package:flutter/material.dart';
import 'package:my_task_diary/libraries/applications_library.dart';
import 'package:my_task_diary/libraries/themes_library.dart';
import 'package:my_task_diary/views/widgets/drawers/interface/header_drawer.dart';

class AboutDrawer extends StatelessWidget {
  const AboutDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width - 30.0,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: const [
          HeaderDrawer(title: "Informations"),
          ListTile(
            title: Text("Nom de l'application"),
            subtitle: Text(
              ApplicationsLibrary.kAppName,
              style: ThemesLibrary.kTextStyleSubTitleDrawer,
            ),
          ),
          ListTile(
            title: Text("Version"),
            subtitle: Text(
              ApplicationsLibrary.kAppVersion,
              style: ThemesLibrary.kTextStyleSubTitleDrawer,
            ),
          ),
          ListTile(
            title: Text("Date de sortie"),
            subtitle: Text(
              ApplicationsLibrary.kAppDate,
              style: ThemesLibrary.kTextStyleSubTitleDrawer,
            ),
          ),
          ListTile(
            title: Text("Auteur"),
            subtitle: Text(
              ApplicationsLibrary.kAppAuthorName,
              style: ThemesLibrary.kTextStyleSubTitleDrawer,
            ),
          ),
        ],
      ),
    );
  }
}
