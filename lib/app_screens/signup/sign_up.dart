import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/app_screens/login/login_screen.dart';
import 'package:graduation_project/app_screens/signup/signup_cubit.dart';
import 'package:graduation_project/shared/components/components.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 var formKey = GlobalKey<FormState>();

  var fnController = TextEditingController();

  var lnController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  bool hidePassword = true;

  String role = 'Select your account type'.tr();


  String volunteerType = 'Select type'.tr();

  bool roleClicked = false;

  RegExp regEx = new RegExp(r"(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])\w+");

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          var cubit = SignupCubit.get(context);
          var emailValidation = cubit.emailValidation;
          var passwordValidation = cubit.passwordValidation;
          String errorToast;
          if (emailValidation == 'true') {
            if (passwordValidation == 'true') {
              errorToast = 'Please check your information'.tr();
            } else {
              errorToast = 'The password must be at least 8 characters'.tr();
            }
          } else {
            errorToast = 'The email has already been taken'.tr();
          }

          if (cubit.status == 200) {
            showToast(
              'Account has been created successfully'.tr(),
              context: context,
              animation: StyledToastAnimation.scale,
              duration: const Duration(seconds: 5),
              backgroundColor: const Color(0xff6bc17a),
              borderRadius: BorderRadius.circular(50),
              alignment: Alignment.bottomCenter,
            );
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginScreen()),
                    (route) => false);
          }
          else if(cubit.status == 401) {
            showToast(
          errorToast,
              context: context,
              animation: StyledToastAnimation.scale,
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(50),
              alignment: Alignment.bottomCenter,
            );
          }
        },
        builder: (context, state) {
          var cubit = SignupCubit.get(context);
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  height: height * .5,
                  width: width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/signup.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.057,
                      start: MediaQuery
                          .of(context)
                          .size
                          .width * 0.75),
                  child: Image(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.2,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.1,
                    image: const AssetImage('assets/images/logo.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: height * .17,
                  ),
                  child: Container(
                    width: width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 25.0,
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              defaultFormField(
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter your first name'.tr();
                                  }
                                },
                                width: width * .85,
                                height: 55,
                                controller: fnController,
                                type: TextInputType.text,
                                label: 'First Name'.tr(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter your last name'.tr();
                                  }
                                },
                                width: width * .85,
                                height: 55,
                                controller: lnController,
                                type: TextInputType.text,
                                label: 'Last Name'.tr(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid E-mail Address'.tr();
                                  }
                                },
                                width: width * .85,
                                height: 55,
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                label: 'E-mail Address'.tr(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter your mobile number'.tr();
                                  }
                                },
                                width: width * .85,
                                height: 55,
                                controller: phoneController,
                                type: TextInputType.number,
                                label: 'Mobile Number'.tr(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                errorMaxLines: 2,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Invalid password'.tr();
                                  } else if (regEx.hasMatch(value) ==
                                      false) {
                                    return 'Must contain at least one (Number &(Upper&lower)Letter)'.tr();
                                  }
                                },
                                isPassword: hidePassword,
                                suffixIcon: hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                suffixIconPressed: () {
                                  setState(() {
                                    print(role);
                                    hidePassword = !hidePassword;
                                  });
                                },
                                width: width * .85,
                                height: 55,
                                controller: passController,
                                type: TextInputType.text,
                                label: 'Password'.tr(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Please confirm password'.tr();
                                  }
                                  if (value != passController.text) {
                                    return 'Password does not match'.tr();
                                  }
                                  return null;
                                },
                                isPassword: hidePassword,
                                suffixIcon: hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                suffixIconPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                width: width * .85,
                                height: 55,
                                controller: confirmPasswordController,
                                type: TextInputType.text,
                                label: 'Confirm Password'.tr(),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      DropdownButton<String>(
                                        hint: Text(
                                          role,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        items: <String>[
                                          'User'.tr(),
                                          'Center'.tr(),
                                          'Store'.tr(),
                                          'Volunteer'.tr()
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            if(value=='مستخدم')
                                            {
                                              role='user';
                                            }else if(value=='مركز')
                                            {
                                              role='center';
                                            }else if(value=='متجر')
                                            {
                                              role='store';
                                            }else if(value=='متطوع')
                                            {
                                              role='volunteer';
                                            }else
                                              {
                                                role = value!.toLowerCase();
                                                print(role);
                                                volunteerType = 'Select type'.tr();
                                              }

                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  role == 'volunteer'
                                      ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          DropdownButton<String>(
                                            hint: Text(
                                              volunteerType,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight
                                                      .bold,
                                                  color: Colors.black),
                                            ),
                                            items: <String>[
                                              'Sitter'.tr(),
                                              'Driver'.tr(),
                                            ].map((String value) {
                                              return DropdownMenuItem<
                                                  String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                               if (value=='جليس')
                                                 {
                                                   volunteerType='sitter';
                                                 }else if (value=='سائق')
                                                   {
                                                     volunteerType='driver';
                                                   } else
                                                     {
                                                       volunteerType =
                                                           value!.toLowerCase();
                                                       print(role);
                                                     }

                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                      : const SizedBox(
                                    width: 1,
                                  ),
                                  volunteerType == 'sitter' ? Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              cubit.getImage1();
                                            },
                                            child: defaultFormField(
                                              enabled: false,
                                              prefixIcon: Icons.add_a_photo,
                                              type: TextInputType.text,
                                              label: cubit.image1
                                                  .toString() == 'null'
                                                  ? 'National ID'
                                                  : cubit.image1.toString(),
                                              width: width * .75,
                                            ),
                                          ),
                                          const SizedBox(height: 5,),
                                          Text(cubit.image1
                                              .toString() == 'null'
                                              ?'*required'.tr():''.tr(),style: const TextStyle(color: Colors.red),),
                                        ],
                                      ),
                                    ],
                                  ) : volunteerType == 'driver' ?
                                  Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              cubit.getImage1();
                                            },
                                            child: defaultFormField(
                                              enabled: false,
                                              prefixIcon: Icons.add_a_photo,
                                              type: TextInputType.text,
                                              label: cubit.image1
                                                  .toString() == 'null'
                                                  ? 'National ID'.tr()
                                                  : cubit.image1.toString(),
                                              width: width * .75,
                                            ),
                                          ),
                                          const SizedBox(height: 5,),
                                           Text(cubit.image1
                                              .toString() == 'null'
                                              ?'*required'.tr():''.tr(),style: const TextStyle(color: Colors.red),),
                                          const SizedBox(height: 10,),
                                          InkWell(
                                            onTap: (){
                                              cubit.getImage2();

                                            },
                                            child: defaultFormField(
                                              enabled: false,
                                              prefixIcon: Icons.add_a_photo,
                                              type: TextInputType.text,
                                              label: cubit.image2
                                                  .toString() == 'null'
                                                  ? 'License ID'.tr()
                                                  : cubit.image2.toString(),
                                              width: width * .75,
                                            ),
                                          ),
                                          const SizedBox(height: 5,),
                                          Text(cubit.image2
                                              .toString() == 'null'
                                              ?'*required'.tr():''.tr(),style: const TextStyle(color: Colors.red),),
                                        ],
                                      ),
                                    ],
                                  ) : const SizedBox(width: 1,),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ).tr(),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, 'login');
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ).tr(),
                                  ),
                                ],
                              ),
                              ConditionalBuilder(
                                condition: state is! SignupLoading,
                                builder: (context) =>
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(30),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/background2.jpg'),
                                            fit: BoxFit.cover,
                                          )),
                                      child: defaultButton(
                                        function: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (role == 'volunteer') {
                                              if (volunteerType ==
                                                  'sitter') {
                                                cubit.UserSignupSitter(
                                                    firstName: fnController
                                                        .text,
                                                    lastName: lnController
                                                        .text,
                                                    email: emailController
                                                        .text,
                                                    password: passController
                                                        .text,
                                                    confirmPassword:
                                                    confirmPasswordController
                                                        .text,
                                                    phone: phoneController
                                                        .text,
                                                    role: role,
                                                    volunteerType: volunteerType);
                                              }
                                              else if (volunteerType ==
                                                  'driver') {
                                                cubit.UserSignupDriver(
                                                    firstName: fnController
                                                        .text,
                                                    lastName: lnController
                                                        .text,
                                                    email: emailController
                                                        .text,
                                                    password: passController
                                                        .text,
                                                    confirmPassword:
                                                    confirmPasswordController
                                                        .text,
                                                    phone: phoneController
                                                        .text,
                                                    role: role,
                                                    volunteerType: volunteerType);
                                              }
                                            }
                                            else {cubit.userSignup(
                                              firstName: fnController
                                                  .text,
                                              lastName: lnController.text,
                                              email: emailController.text,
                                              password: passController
                                                  .text,
                                              confirmPassword:
                                              confirmPasswordController
                                                  .text,
                                              phone: phoneController.text,
                                              role: role,
                                            );
                                            }

                                          }
                                        },
                                        text: 'SIGN UP'.tr(),
                                        width: width * .4,
                                        height: height * .07,
                                      ),
                                    ), fallback: (context) =>
                              const Center(
                                  child: CircularProgressIndicator()),
                              ),
                            ],
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
