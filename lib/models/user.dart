import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.userid,
    this.name,
    this.username,
    this.avatar,
  });

  final int userid;
  String name;
  String username;
  String avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userid: json["userid"],
        name: json["name"],
        username: json["username"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "name": name,
        "username": username,
        "avatar": avatar,
      };
}

User dummyUser = User(
  userid: DateTime.now().millisecondsSinceEpoch,
  name: "Sudhanshu",
  username: "sky1095",
  avatar: "",
);
