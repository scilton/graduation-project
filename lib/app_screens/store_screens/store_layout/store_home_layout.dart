
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../shared/network/local/cash_helper.dart';
import 'cubit/store_cubit.dart';
import 'cubit/store_states.dart';

class StoreHomeLayout extends StatelessWidget {
  const StoreHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      print(event.data.toString());
      showToast('New notification'.tr(),
        context: context,
        animation: StyledToastAnimation.scale,
        duration: const Duration(seconds: 5),
        backgroundColor: const Color(0xff6bc17a),
        borderRadius: BorderRadius.circular(50),
        alignment: Alignment.center,
      );
    });
    return BlocProvider(
      create: (context) => StoreAppCubit(),
      child: BlocConsumer<StoreAppCubit, StoreAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = StoreAppCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/signup.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: CashHelper.getData(key: 'lang')=='ar'?MainAxisAlignment.end:MainAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'i',
                            style: TextStyle(
                              fontFamily: 'Newton',
                              color: Colors.red,
                            ),
                          ),
                          TextSpan(
                            text: 'c',
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Newton',
                            ),
                          ),
                          TextSpan(
                            text: 'a',
                            style: TextStyle(
                              color: Colors.amber,
                              fontFamily: 'Newton',
                            ),
                          ),
                          TextSpan(
                            text: 'n',
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontFamily: 'Newton',
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: const Color(0xff3100ff),
              selectedFontSize: 18,
              showUnselectedLabels: false,
              iconSize: 25,
              items: cubit.BottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeItems(index);
              },
            ),
          );
        },
      ),
    );
  }
}
