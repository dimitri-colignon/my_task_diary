import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_task_diary/libraries/themes_library.dart';

class HeaderDrawer extends StatelessWidget {
  final String title;

  const HeaderDrawer({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(gradient: ThemesLibrary.kBackgroundLinearGradientInterface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton.filled(
            tooltip: "Fermer",
            onPressed: () => Navigator.pop(context),
            icon: const FaIcon(FontAwesomeIcons.arrowLeft),
            style: ThemesLibrary.kIconButtonCircle,
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(title, style: const TextStyle(color: ThemesLibrary.kColorDefaultOnPrimary, fontSize: 24.0, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
