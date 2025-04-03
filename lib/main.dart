import 'package:flutter/material.dart';
import 'package:islami_app_new/provider/radio_manager_provider.dart';
import 'package:provider/provider.dart';

import 'home/home_screen.dart';
import 'home/my_app_themes.dart';
import 'home/tabs/hadith_tab/hadith_details_screen.dart';
import 'home/tabs/quran_tabs/sura_details.dart';
import 'introduction_screens/introduction_screens.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => RadioManagerProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        IntroductionScreens.routeName: (context) => IntroductionScreens(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SuraDetailsScreen.routeName: (context) => SuraDetailsScreen(),
        HadithDetailsScreen.routeName: (context) => HadithDetailsScreen(),
      },
      darkTheme: MyThemeData.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
