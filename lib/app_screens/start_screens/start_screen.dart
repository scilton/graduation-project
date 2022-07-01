
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/app_screens/login/login_screen.dart';
import 'package:graduation_project/app_screens/signup/sign_up.dart';
import 'package:graduation_project/shared/components/components.dart';

class StartScreen extends StatelessWidget  {
  const StartScreen({Key? key}) : super(key: key);

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
            child: Stack(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      bottom: 100,
                    ),
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      width: 170.0,
                      height: 175.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 200,
                  ),
                  child: Center(
                    child: defaultButton(
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      text: 'LOGIN'.tr(),
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.white,
                      width: 300,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 350,
                  ),
                  child: Center(
                    child: defaultButton(
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  const SignUp()));
                      },
                      text: 'SIGN UP'.tr(),
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.white,
                      width: 300,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
}

}
