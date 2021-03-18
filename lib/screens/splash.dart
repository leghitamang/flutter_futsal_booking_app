import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), stopLoading);
  }

  stopLoading() async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = jsonDecode(localStorage.get('token'));
      token == null
          ? Navigator.pushReplacementNamed(context, '/login')
          : Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff232525),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Center(
              child: FlutterLogo(
                size: 120,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}
