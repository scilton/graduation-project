
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/local/cash_helper.dart';
import 'cubit/admin_cubit.dart';
import 'cubit/admin_states.dart';

class AdminHomeLayout extends StatelessWidget {
  const AdminHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminAppCubit(),
      child: BlocConsumer<AdminAppCubit, AdminAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AdminAppCubit.get(context);

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
