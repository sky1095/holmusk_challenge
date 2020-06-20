import 'package:flutter/material.dart';
import 'package:holmusk_flutter_challenge/services/chatList.dart';
import 'package:holmusk_flutter_challenge/services/themeChanger.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'dart:developer' as developer;

class HomeScreen extends StatelessWidget {
  final User user;
  HomeScreen({@required this.user});
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final chatList = Provider.of<ChatList>(context);
    final themeData = Provider.of<AppTheme>(context);
    if (chatList.getChatList.isEmpty) chatList.addToChat();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Chats"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              scaffoldKey.currentState.openDrawer();
            }),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Dark Mode"),
                Switch(
                    value: themeData.isDark,
                    onChanged: (value) => themeData.changeTheme(value)),
              ],
            ),
            RaisedButton(
              child: Text("Profile"),
              onPressed: () {
                if (scaffoldKey.currentState.isDrawerOpen)
                  Navigator.pop(context);

                Navigator.of(context).pushNamed("/profile");
              },
            ),
            RaisedButton(
              child: Text("Logout"),
              onPressed: () {
                // TODO: Implement Logout
              },
            )
          ],
        ),
      ),
      body: Center(
        child: chatList.getChatList.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  chatList.addToChat();
                },
                child: ListView.separated(
                    itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              chatList.getChatList[index].avatarUrl,
                            ),
                            onBackgroundImageError: (_, trace) {
                              developer.log(
                                "Failed to load Avatar",
                                time: DateTime.now(),
                                stackTrace: trace,
                              );
                            },
                          ),
                          title: Text(
                            chatList.getChatList[index].name,
                          ),
                          subtitle: Text(
                            chatList.getChatList[index].lastMessage,
                            maxLines: 2,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: chatList.getChatList.length),
              ),
      ),
    );
  }
}
