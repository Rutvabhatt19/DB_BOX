import 'package:db_box/MixinFun.dart';
import 'package:db_box/View/Homepage.dart';
import 'package:db_box/View/IntroScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with GlobalFun {
  @override
  void initState() {
    super.initState();
    _checkIfIntroScreenSeen();
  }
  Future<void> _checkIfIntroScreenSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? seenIntro = prefs.getBool('seenIntro') ?? false;

    await Future.delayed(Duration(seconds: 3));

    if (seenIntro) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => IntroScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text1('DB_BOX_PROJECT',20,FontWeight.bold)
      ),
    );
  }
}
