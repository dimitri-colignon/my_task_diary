import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_task_diary/libraries/applications_library.dart';
import 'package:my_task_diary/libraries/themes_library.dart';
import 'package:my_task_diary/providers/interface_provider.dart';
import 'package:my_task_diary/providers/tasks_provider.dart';
import 'package:my_task_diary/views/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then(
    (value) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => InterfaceProvider()),
          ChangeNotifierProvider(create: (_) => TasksProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: ThemesLibrary.kColorDefaultBlack));
    return MaterialApp(
      title: ApplicationsLibrary.kAppName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: ApplicationsLibrary.kLocale,
      supportedLocales: const [
        ApplicationsLibrary.kLocale,
      ],
      theme: ThemesLibrary.kThemeData,
      builder: EasyLoading.init(),
      home: HomeScreen(),
    );
  }
}
