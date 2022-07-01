import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/app_screens/login/cubit/login_cubit.dart';
import 'package:graduation_project/app_screens/login/cubit/login_states.dart';
import 'package:graduation_project/app_screens/start_screens/start_screen.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/user_home_layout.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';

import '../../../../../language/lang_cubit.dart';
import 'change_password/user_change_password.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  bool dark = false;
  bool notification = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(  create: (context) => LoginCubit(),),
        BlocProvider(  create: (context) => LangCubit(),),
      ],
      child: BlocConsumer<LangCubit, LangState>(
  listener: (context, state) {

    if (state is LanguageChange)
    {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const UserHomeLayout()), (route) => false);
    }
  },
  builder: (context, state) {
    return BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          var cubit = LoginCubit.get(context);

          if (state is LogoutSuccessState) {
            if (cubit.logoutStatus == 200) {
              showToast(
                'You\'ve been logged out'.tr(),
                context: context,
                animation: StyledToastAnimation.scale,
                duration: const Duration(seconds: 5),
                backgroundColor: Colors.yellow,
                borderRadius: BorderRadius.circular(50),
                alignment: Alignment.bottomCenter,
              );
              CashHelper.removeData(key: 'role');
              CashHelper.removeData(key: 'token').then((value) {
                if (value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StartScreen()),
                      (route) => false);
                }
              });
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: Container(
              padding: EdgeInsets.only(left: 22, top: 23, right: 5),
              child: ListView(
                children: [
                  Text(
                    'Settings'.tr(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 15,
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: Colors.green[900],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Account'.tr(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900],
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserChangePassword()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '   Change password'.tr(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: (){
                      showMenu(
                        context: context,
                        position:CashHelper.getData(key: 'lang')=='ar'? RelativeRect.fromLTRB(0, height*.45, width, height*.55)
                            :RelativeRect.fromLTRB(width, height*.45, 0, height*.55),
                        items: <PopupMenuEntry>[
                          PopupMenuItem(
                            value: 1,
                            onTap: (){
                             LangCubit.get(context).changeLanguage(context, 'en');
                             CashHelper.saveData(key: 'lang', value: 'en');

                            },
                            child: Row(
                              children: const <Widget>[
                                Icon(Icons.language),
                                SizedBox(width: 5,),
                                Text("English"),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            onTap: () async {
                              LangCubit.get(context).changeLanguage(context, 'ar');
                               CashHelper.saveData(key: 'lang', value: 'ar');

                            },
                            child: Row(
                              children: const <Widget>[
                                Icon(Icons.language),
                                SizedBox(width: 5,),
                                Text("العربية"),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '   Language',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ).tr(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.volume_up,
                        color: Colors.green[900],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Notification'.tr(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900],
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.notifications),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: const Text(
                          'Allow notification',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ).tr(),
                      ),
                      Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: notification,
                            onChanged: (bool v) {
                              setState(() {
                                notification = v;
                              });
                            },
                          ))
                    ],
                  ),

                  const SizedBox(
                    height: 70,
                  ),
                  Center(
                    // child: Container(
                    //   color: Colors.green,

                    child: ConditionalBuilder(
                      condition: state is! LogoutLoadingState,
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      builder: (context) => OutlinedButton(
                          // style: ButtonStyle(
                          //   padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(17)),
                          // ),
                          style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: const Color(0xe537da97),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.only(
                                left: 60,
                                right: 60,
                                top: 15,
                                bottom: 15,
                              )),
                          onPressed: () {
                            cubit.updateFcm(null);
                            cubit.userLogout();
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                letterSpacing: 1),
                          ).tr(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          );
        },
      );
  },
),
    );
  }
}
