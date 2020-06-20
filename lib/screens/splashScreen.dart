import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  void routeTo(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.popAndPushNamed(context, "/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    routeTo(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Welcome to Chat APP 🤗"),
        ),
      ),
    );
  }
}
