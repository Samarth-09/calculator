import 'package:flutter/material.dart';
import 'package:my_flutter_app/splash.dart';
import 'package:my_flutter_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,initialRoute: '/', home: splash(), routes: {
      '/splash.dart': (context) => splash(),
      '/home.dart':(context) => home()
    });
  }
}
