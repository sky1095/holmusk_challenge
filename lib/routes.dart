import 'package:flutter/material.dart';
import 'package:holmusk_flutter_challenge/screens/homeScreen.dart';
import 'package:holmusk_flutter_challenge/screens/profileScreen.dart';
import './screens/authScreen.dart';
import './screens/splashScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final List<Object> args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case '/home':
        return MaterialPageRoute(
            builder: (_) => HomeScreen(
                  user: args[0],
                ));
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
