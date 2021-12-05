import 'package:flutter/material.dart';
import 'package:intern_challenges/screen/login.dart';

import 'post_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 200),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return const Center(
              child: Text('Hello'),
            );
          },
          onEnd: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LogIN()));
          },
        ),
      ),
    );
  }
}
