import 'package:db_box/MixinFun.dart';
import 'package:db_box/View/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatelessWidget with GlobalFun {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text1('Welcome to the TODO App', 20, FontWeight.bold),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                _setSeen();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text1('Get Started', 15, FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenIntro', true);
  }
}
