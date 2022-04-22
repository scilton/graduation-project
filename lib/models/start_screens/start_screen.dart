import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(
        child: Text(
          'Start Screen',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
    );
  }
}
