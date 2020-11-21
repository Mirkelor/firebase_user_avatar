import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_user_avatar/app/auth_widget_builder.dart';
import 'package:firebase_user_avatar/services/firebase_auth_service.dart';
import 'package:firebase_user_avatar/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/auth_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<FirebaseAuthService>(
            create: (_) => FirebaseAuthService(),
          ),
          Provider<ImagePickerService>(
            create: (_) => ImagePickerService(),
          ),
        ],
        child: AuthWidgetBuilder(
          builder: (context, userSnapshot) {
            return MaterialApp(
              theme: ThemeData(primarySwatch: Colors.indigo),
              home: AuthWidget(userSnapshot: userSnapshot),
            );
          },
        ));
  }
}
