import 'dart:convert';
import 'package:flutter/material.dart';
import '../api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'dart:developer' as developer;


enum AuthState { login, register }

class AuthScreen extends StatelessWidget {
  final pageController = PageController(initialPage: 0);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          AuthPage(
            state: AuthState.login,
            controller: pageController,
          ),
          AuthPage(
            state: AuthState.register,
            controller: pageController,
          ),
        ],
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String field;
  InputField({this.field});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: field,
        ),
      ),
    );
  }
}

class AuthPage extends StatelessWidget {
  final AuthState state;
  final PageController controller;
  AuthPage({this.state, this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          state == AuthState.login
              ? Container()
              : InputField(field: dummyUser.name),
          InputField(field: dummyUser.username),
          InputField(field: "*********"),
          FloatingActionButton.extended(
            onPressed: () async {
              try {
                state == AuthState.login
                    ? await AuthBackend(context).login()
                    : await AuthBackend(context).register();
              } catch (e) {
                developer.log("Something wrong with login/Regsiter",
                    time: DateTime.now(), stackTrace: StackTrace.current);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(e.toString()),
                ));
              }
            },
            label: Text(state == AuthState.login ? "Login" : "Register"),
          ),
          FlatButton(
            child: state == AuthState.login
                ? Text("Not Registered? click here ")
                : Text("Already Registered? Login"),
            onPressed: () {
              controller.jumpToPage(state == AuthState.login ? 1 : 0);
            },
          )
        ],
      ),
    );
  }
}

class AuthBackend {
  final BuildContext context;
  AuthBackend(this.context);

  login() async {
    final response = await ApiService().verifyLogin(dummyUser);
    final responseBody = json.decode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", responseBody["token"]);
    Navigator.popAndPushNamed(context, "/home", arguments: [dummyUser]);
  }

  register() async {
    final response = await ApiService().createUser(dummyUser);
    final responseBody = json.decode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", responseBody["token"]);
    Navigator.popAndPushNamed(context, "/home", arguments: [dummyUser]);
  }
}
