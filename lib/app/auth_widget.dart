import 'package:firebase_user_avatar/app/home/home_page.dart';
import 'package:firebase_user_avatar/app/sign_in/sign_in_page.dart';
import 'package:firebase_user_avatar/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatelessWidget {
  final AsyncSnapshot<User> userSnapshot;

  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? HomePage() : SignInPage();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
