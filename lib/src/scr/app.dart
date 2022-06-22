import 'package:flutter/material.dart';
import 'package:gomez_todo/src/scr/auth/auth.dart';
import 'package:splashscreen/splashscreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          seconds: 8,
          navigateAfterSeconds: AuthScreen(),
          title: new Text(
            'To-Do App - written by Daryll Gomez',
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white),
          ),
        ));
  }
}
