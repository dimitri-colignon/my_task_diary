import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:my_task_diary/libraries/applications_library.dart';
import 'package:my_task_diary/libraries/themes_library.dart';
import 'package:my_task_diary/models/interface_bottom_navigation_bar_model.dart';
import 'package:my_task_diary/providers/interface_provider.dart';
import 'package:my_task_diary/views/widgets/drawers/content/about_drawer.dart';
import 'package:my_task_diary/views/widgets/drawers/content/configuration_drawer.dart';
import 'package:my_task_diary/views/widgets/forms/tasks_form_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _listDrawer = [
    const ConfigurationDrawer(),
    const AboutDrawer(),
  ];

  void _openDrawer({required BuildContext context, required int index}) {
    if (index > _listDrawer.length) return;
    context.read<InterfaceProvider>().changeDrawer(index);
    _scaffoldKey.currentState!.openDrawer();
  }

  void _insertTask({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      constraints: BoxConstraints.tight(Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.9)),
      builder: (ctx) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const SingleChildScrollView(
            child: TasksFormWidget(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int drawerIndex = context.watch<InterfaceProvider>().indexDrawer;
    int bottomNavIndex = context.watch<InterfaceProvider>().indexButtonBottomNavigationBar;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ThemesLibrary.kColorDefaultOnPrimary,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(left: 0.0, top: 0.0, right: 0.0, child: Container(height: 110.0, decoration: const BoxDecoration(gradient: ThemesLibrary.kBackgroundLinearGradientInterface))),
            const Positioned(left: 10.0, top: 15.0, child: Text(ApplicationsLibrary.kAppName, style: TextStyle(color: ThemesLibrary.kColorDefaultOnPrimary, fontSize: 30.0, fontWeight: FontWeight.w700))),
            const Positioned(left: 10.0, top: 55.0, child: Text("Bienvenue ...", style: TextStyle(color: ThemesLibrary.kColorDefaultGrey, fontSize: 22.0))),
            Positioned(
              top: 25.0,
              right: 60.0,
              child: IconButton.filled(
                tooltip: "Configuration",
                onPressed: () => _openDrawer(context: context, index: 0),
                icon: const FaIcon(FontAwesomeIcons.gear),
                style: ThemesLibrary.kIconButtonCircle,
              ),
            ),
            Positioned(
              top: 25.0,
              right: 10.0,
              child: IconButton.filled(
                tooltip: "Informations",
                onPressed: () => _openDrawer(context: context, index: 1),
                icon: const FaIcon(FontAwesomeIcons.info),
                style: ThemesLibrary.kIconButtonCircle,
              ),
            ),
            Positioned(
              left: 0.0,
              top: 90.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: ThemesLibrary.kColorDefaultOnPrimary,
                ),
                child: listInterfaceBottomNavigationBar[bottomNavIndex].child,
              ),
            ),
          ],
        ),
      ),
      drawer: _listDrawer[drawerIndex],
      drawerEnableOpenDragGesture: false,
      floatingActionButton: FloatingActionButton(
        tooltip: "Ajouter une tâche",
        child: const Icon(Icons.add),
        onPressed: () => _insertTask(context: context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          activeIndex: bottomNavIndex,
          itemCount: listInterfaceBottomNavigationBar.length,
          tabBuilder: (index, isActive) {
            return Tooltip(
              message: listInterfaceBottomNavigationBar[index].title,
              child: DecoratedIcon(
                icon: Icon(listInterfaceBottomNavigationBar[index].icon, color: isActive ? ThemesLibrary.kColorDefaultPrimary : ThemesLibrary.kColorDefaultGrey, size: 20.0),
                decoration: const IconDecoration(
                  border: IconBorder(color: ThemesLibrary.kColorDefaultOnPrimary, width: 2.0),
                ),
              ),
            );
          },
          onTap: (p0) => context.read<InterfaceProvider>().changeButtonBottomNavigationBar(p0),
          gapLocation: GapLocation.end,
          notchSmoothness: NotchSmoothness.smoothEdge,
          leftCornerRadius: 32.0,
          rightCornerRadius: 0.0,
          splashColor: ThemesLibrary.kColorDefaultPrimarySplashColor,
          backgroundGradient: ThemesLibrary.kBackgroundLinearGradientInterface),
    );
  }
}
