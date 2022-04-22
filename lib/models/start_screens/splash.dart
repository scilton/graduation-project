import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background2.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 15,
                      top: 15,
                    ),
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      width: 140.0,
                      height: 145.0,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
