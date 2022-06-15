import 'package:flutter/material.dart';
import 'package:flutterloginapp/models/user.dart';
import 'package:flutterloginapp/screens/wrapper.dart';
import 'package:flutterloginapp/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

