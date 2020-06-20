import 'package:flutter/cupertino.dart';
import 'package:holmusk_flutter_challenge/api/api.dart';
import 'package:holmusk_flutter_challenge/models/friend.dart';

class ChatList extends ChangeNotifier {
  final List<Friend> _chatList = [];

  List<Friend> get getChatList => _chatList;

  void addToChat() async {
    final fetchedList = await ApiService().fetchFriends(1);
    _chatList.addAll(friendFromJson(fetchedList.body));
    notifyListeners();
  }
}


