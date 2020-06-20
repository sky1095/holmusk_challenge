import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:holmusk_flutter_challenge/models/friend.dart';
import 'package:holmusk_flutter_challenge/models/user.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final _host = "com.simple.chat";
  final _port = 433;

  String url(String path) => Uri(
        host: _host,
        port: _port,
        path: path,
        scheme: "https",
      ).toString();
}

class Header {
  get fetchHeader async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {"Authorization": "Basic ${prefs.getString("token")}"};
  }
}

/// Service class to have all necessary [Api] endpoints require inside the App
class ApiService {
  Client http = Client();
  Api api = Api();
  // User Login ApiService
  verifyLogin(User credentials) async {
    final url = Api().url("login");
    final body = credentials.toJson();

    debugPrint("calling : $url");
    debugPrint("Logging in with: $body");

    // final response = await http.post(url, body: body);
    Response response = Response(
      json.encode({
        "token": DateTime.now().millisecondsSinceEpoch.toString(),
      }),
      200,
    );
    if (response.statusCode == 200) return response;
    // else things didn't go well
    throw Exception(
        ExceptionError(exceptionCode: response.statusCode).toString());
  }

  createUser(User credentials) async {
    final url = Api().url("create");
    final body = credentials.toJson();

    debugPrint("calling : $url");
    debugPrint("Registering with: $body");

    // final response = await http.post(url, body: body);
    Response response = Response(
      json.encode({
        "token": DateTime.now().millisecondsSinceEpoch.toString(),
      }),
      200,
    );
    if (response.statusCode == 200) return response;

    throw Exception(
        ExceptionError(exceptionCode: response.statusCode).toString());
  }

  fetchFriends(int page) async {
    final url = Api().url("friends/$page");
    final header = await Header().fetchHeader;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // final header = {"Authorization": "Basic ${prefs.getString("token")}"};
    debugPrint("calling : $url");

    // final response = await http.get(url, headers: header);
    Response response = Response(friendToJson(friendsList), 200);
    if (response.statusCode == 200) return response;

    throw Exception(
        ExceptionError(exceptionCode: response.statusCode).toString());
  }

  fetchProfile() async {
    final url = Api().url("profile");
    final header = await Header().fetchHeader;
    debugPrint("calling : $url");
    // final response = await http.get(url, headers: header);
    Response response = Response(userToJson(dummyUser), 200);
    if (response.statusCode == 200) return response;

    throw Exception(
        ExceptionError(exceptionCode: response.statusCode).toString());
  }

  updateProfile(User user) async {
    final url = Api().url("profile");
    final header = await Header().fetchHeader;
    debugPrint("calling update profile: $url");

    // final response = await http.put(url, headers: header, body: userToJson(user));
    Response response = Response(userToJson(dummyUser), 200);
    if (response.statusCode == 200) return response;

    throw Exception(
        ExceptionError(exceptionCode: response.statusCode).toString());
  }
}

class ExceptionError {
  final int exceptionCode;
  ExceptionError({this.exceptionCode});

  @override
  String toString() {
    switch (exceptionCode) {
      case 400:
        return "Bad request parameters: Whoa! choose wisely";
      case 401:
        return "Session Expired : Please Login Again!";
      case 404:
        return "Endpoint not Found! Are you lost?";
      case 500:
        return "Interval server error : Just a Glitch!";
      default:
        return "Unknown error!";
    }
  }
}
