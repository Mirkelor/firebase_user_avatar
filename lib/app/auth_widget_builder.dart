import 'package:firebase_user_avatar/app/auth_widget.dart';
import 'package:firebase_user_avatar/services/firebase_auth_service.dart';
import 'package:firebase_user_avatar/services/firebase_storage_service.dart';
import 'package:firebase_user_avatar/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Used to create user-dependant objects that need to be accessible by all widgets
/// This widget should live above the [MaterialApp].
/// See [AuthWidget], a descendant widget that consumes the snapshot generated by this builder
class AuthWidgetBuilder extends StatelessWidget {
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;

  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('AuthWidgetBuilder build');
    final authService =
        Provider.of<FirebaseAuthService>(context, listen: false);
    return StreamBuilder<User>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        print('StreamBuilder: ${snapshot.connectionState}');
        final user = snapshot.data;
        if (user != null) {
          return MultiProvider(
            providers: [
              Provider<User>.value(value: user),
              Provider<FirebaseStorageService>(
                create: (_) => FirebaseStorageService(uid: user.uid),
              ),
              Provider<FirestoreService>(
                create: (_) => FirestoreService(uid: user.uid),
              ),
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
