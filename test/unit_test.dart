import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:holmusk_flutter_challenge/api/api.dart';
import 'package:holmusk_flutter_challenge/models/friend.dart';
import 'package:holmusk_flutter_challenge/models/user.dart';
import 'package:holmusk_flutter_challenge/services/chatList.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  test("Testing Login Api", () async {
    final apiService = ApiService();
    apiService.http = MockClient((request) async {
      final response = {
        "token": DateTime.now().millisecondsSinceEpoch,
      };
      return Response(json.encode(response), 200);
    });
    final loginResponse = await apiService.verifyLogin(dummyUser);
    expect(loginResponse.statusCode, 200);
  });

  test("Testing Register Api", () async {
    final apiService = ApiService();
    apiService.http = MockClient((request) async {
      final response = {
        "token": DateTime.now().millisecondsSinceEpoch,
      };
      return Response(json.encode(response), 200);
    });
    final loginResponse = await apiService.createUser(dummyUser);
    expect(loginResponse.statusCode, 200);
  });

  test("Testing fetch ChatsList Api", () async {
    final apiService = ApiService();
    apiService.http = MockClient((request) async {
      final response = ChatList().getChatList;
      return Response(friendToJson(response), 200);
    });
    final loginResponse = await apiService.fetchFriends(1);
    expect(loginResponse.statusCode, 200);
  });

  test("Testing fetch profile Api", () async {
    final apiService = ApiService();
    apiService.http = MockClient((request) async {
      return Response(json.encode(userToJson(dummyUser)), 200);
    });
    final loginResponse = await apiService.fetchProfile();
    expect(loginResponse.statusCode, 200);
  });

  test("Testing update profile Api", () async {
    final apiService = ApiService();
    apiService.http = MockClient((request) async {
      return Response(userToJson(dummyUser), 200);
    });
    final loginResponse = await apiService.updateProfile(dummyUser);
    expect(userFromJson(loginResponse.body).name, dummyUser.name);
  });
}
