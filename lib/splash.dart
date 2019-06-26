import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _startTimer();
  }

  void _startTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tok = prefs.getString("UserToken") ?? "Not found";

    if (tok == "Not found") {
      prefs.setString("UserToken", "660b8770b881fc9754148ff823d0f989ac231821");
    }
    new Timer(Duration(seconds: 3), _onDone);
    // else {
    //   print('test');
    // }
  }

  void _onDone() {
    // Navigator.of(context).pushReplacementNamed('/test');
    Navigator.of(context).pushReplacementNamed('/account');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Splash')),
    );
  }
}
