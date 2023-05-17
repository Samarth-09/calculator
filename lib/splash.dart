import 'package:flutter/material.dart';


//creates the splash screen
class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    next();
  }

  void next() async {
    await Future.delayed(Duration(seconds: 3));
    await Navigator.pushNamed(context, '/home.dart');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/calc.jpg', width: 200, height: 200),
            Text('My Cal C',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.2)),
          ]),
    ));
  }
}
