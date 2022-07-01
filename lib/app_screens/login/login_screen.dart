import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/app_screens/admin_screens/admin_layout/admin_home_layout.dart';
import 'package:graduation_project/app_screens/centers_screens/center_layout/center_home_layout.dart';
import 'package:graduation_project/app_screens/signup/sign_up.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/store_home_layout.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/user_home_layout.dart';
import 'package:graduation_project/app_screens/volunteer_screens/volunteer_layout/volunteer_home_layout.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';

import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) async {
          var cubit = LoginCubit.get(context);

          if (state is LoginSuccessState)
            {
              if (cubit.status==200){
               print(cubit.token);
                showToast('Login done successfully'.tr(),
                  context: context,
                  animation: StyledToastAnimation.scale,
                  duration: const Duration(seconds: 5),
                  backgroundColor: const Color(0xff6bc17a),
                  borderRadius: BorderRadius.circular(50),
                  alignment: Alignment.bottomCenter,
                );
                CashHelper.saveData(key: 'token', value: cubit.token).then((value){
                  if(cubit.role=='user'){
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>const UserHomeLayout()), (route) => false);
                  }else if (cubit.role=='center'){
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>const CenterHomeLayout()), (route) => false);
                  }else if (cubit.role=='store'){
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>const StoreHomeLayout()), (route) => false);
                  }else if (cubit.role=='volunteer'){
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>const VolunteerHomeLayout()), (route) => false);
                  }else if (cubit.role=='admin') {
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context) => const AdminHomeLayout()), (route) => false);
                  }

                });
               CashHelper.saveData(key: 'role', value: cubit.role);

               var fcmToken= await FirebaseMessaging.instance.getToken();
               print(fcmToken);
               cubit.updateFcm(fcmToken.toString());

                } else
                  {
                    showToast('Email or Password is incorrect'.tr(),
                      context: context,
                      animation: StyledToastAnimation.scale,
                      duration: const Duration(seconds: 5),
                      backgroundColor: Colors.red,
                      borderRadius: BorderRadius.circular(50),
                      alignment: Alignment.bottomCenter,
                    );
                  }
            }

        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .53,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        'assets/images/signup.png',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.057,
                      start: MediaQuery
                      .of(context)
                      .size
                      .width * 0.7),
                  child: Image(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.266,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.12,
                    image: const AssetImage(
                        'assets/images/logo.png'
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.2),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(65.0),
                        topStart: const Radius.circular(65.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(MediaQuery
                            .of(context)
                            .size
                            .height * 0.038),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                bottom: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.03),
                            child: Form(
                              key: FormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Hello',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 60.0,
                                    ),
                                  ).tr(),
                                  SizedBox(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.013,
                                  ),
                                  Text(
                                    'Login to your account'.tr(),
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.066,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 57,
                                    child: defaultFormField(
                                      controller: emailController,
                                      type: TextInputType.emailAddress,
                                      prefixIcon: Icons.email,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'email must not be empty'.tr();
                                        }
                                      },
                                      label: 'Email'.tr(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.015,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 63,

                                    child: Column(
                                      children: [
                                        defaultFormField(
                                          controller: passwordController,
                                          type: TextInputType.visiblePassword,
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return 'password is too short'.tr();
                                            }
                                          },
                                          label: 'Password'.tr(),
                                          prefixIcon: Icons.lock,
                                          suffixIcon: isPassword ? Icons
                                              .visibility : Icons
                                              .visibility_off,
                                          isPassword: isPassword,
                                          suffixIconPressed: () {
                                            setState(() {
                                              isPassword = !isPassword;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  ConditionalBuilder(
                                      condition: state is! LoginLoadingState,
                                      builder: (context)=>Container(
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                            borderRadius: BorderRadiusDirectional
                                                .circular(27),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/background2.jpg'),
                                                fit: BoxFit.cover)
                                        ),
                                        child: defaultButton(
                                          function: () {
                                            if (FormKey.currentState!.validate()) {
                                              cubit.userLogin(

                                                email: emailController.text,
                                                password: passwordController.text,
                                              );
                                              print(emailController.text);
                                              print(passwordController.text);
                                            }
                                          },
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.4,
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.07,
                                          text: 'LOGIN'.tr(),
                                        ),
                                      ),
                                      fallback: (context)=>Center(child: CircularProgressIndicator()),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      top: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.03,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        const Text(
                                          'Don\'t have an account?',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ).tr(),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                                          },
                                          child: const Text(
                                            'Register Now',
                                          ).tr(),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
