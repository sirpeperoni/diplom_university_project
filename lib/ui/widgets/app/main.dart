import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() {
  const app = MainApp();
  runApp(app);
}

class MainApp extends StatelessWidget {
  //final MyAppModel model;
  static final mainNavigation = MainNavigation();
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Color.fromARGB(255, 0, 0, 0)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey 
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', ''),
      ],
      routes: mainNavigation.routes,
      initialRoute: MainNavigationRoutesName.loaderWidget,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
