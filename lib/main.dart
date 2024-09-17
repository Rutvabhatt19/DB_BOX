import 'package:db_box/Controller/Themecontroller.dart';
import 'package:db_box/View/Homepage.dart';
import 'package:db_box/View/Splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeController(),),
  ],child: const MyApp(),));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController=Provider.of<ThemeController>(context);
    return MaterialApp(
      theme:themeController.isDarkTheme ?ThemeData.dark():ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

