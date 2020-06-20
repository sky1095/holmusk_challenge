import 'package:flutter/material.dart';
import 'package:holmusk_flutter_challenge/routes.dart';
import 'package:holmusk_flutter_challenge/services/chatList.dart';
import 'package:holmusk_flutter_challenge/services/themeChanger.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ChatList>(create: (context) => ChatList()),
      ChangeNotifierProvider<AppTheme>(create: (context) => AppTheme()),
    ],
    child: ChatApp(),
  ));
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<AppTheme>(context);
    return MaterialApp(
      theme: themeData.isDark ? ThemeData.dark() : ThemeData.light(),
      title: "Chat-App",
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: "/",
    );
  }
}
