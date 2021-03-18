import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepsal/screens/bookings.dart';
import 'package:nepsal/screens/check.dart';
import 'package:nepsal/screens/history.dart';
import 'package:nepsal/screens/login.dart';
import 'package:nepsal/screens/home.dart';
import 'package:nepsal/screens/splash.dart';
import 'package:nepsal/screens/register.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      // theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),        
        '/check': (context) => Check(),
        '/bookings': (context) => BookingsScreen(),
        '/history': (context) => HistoryScreen(),
      },
    );
  }
}
