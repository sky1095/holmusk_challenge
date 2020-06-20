import 'dart:convert';

List<Friend> friendFromJson(String str) => List<Friend>.from(json.decode(str).map((x) => Friend.fromJson(x)));

String friendToJson(List<Friend> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Friend {
    Friend({
        this.id,
        this.name,
        this.avatarUrl,
        this.lastMessage,
    });

    int id;
    String name;
    String avatarUrl;
    String lastMessage;

    factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        id: json["id"],
        name: json["name"],
        avatarUrl: json["avatarUrl"],
        lastMessage: json["lastMessage"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatarUrl": avatarUrl,
        "lastMessage": lastMessage,
    };
}

List<Friend> friendsList = List.generate(
  10,
  (index) => Friend(
      id: index + 1,
      name: "Friend ${index+1}",
      avatarUrl: "https://picsum.photos/200/300?random=$index",
      lastMessage: "loream ipsum dolar..."),
);
 
