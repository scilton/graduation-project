import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graduation_project/shared/network/local/shared_pref_repository.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
          () async => Navigator.of(context).pushReplacementNamed(
        await SharedPreferenceRepository.getHomeRoute(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
          height: 150,
          width: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/logo.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
