import 'package:flutter/material.dart';
import 'package:holmusk_flutter_challenge/api/api.dart';
import 'package:holmusk_flutter_challenge/models/user.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiService().fetchProfile(),
        builder: (context, AsyncSnapshot snapshot) {
          
          if (snapshot.hasData) {
            debugPrint(snapshot.data.body);
            final profileData = userFromJson(snapshot.data.body);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CircleAvatar(
                    radius: size.width / 4,
                  ),
                  // Spacer(),
                  Text(profileData.name),
                  // Spacer(),
                  FloatingActionButton.extended(
                    onPressed: () {
                      ApiService().updateProfile(dummyUser);
                    },
                    label: Text("Update"),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
