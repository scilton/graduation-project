import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/cubit/user_cubit.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/cubit/user_states.dart';
import 'package:intl/intl.dart';

class UserBooking extends StatelessWidget {
   UserBooking({Key? key,required this.index}) : super(key: key);
int index;
   var caseNameController = TextEditingController();
   var mobileController = TextEditingController();
   var dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
  create: (context) => UserAppCubit()..getCenters(),
  child: BlocConsumer<UserAppCubit, UserAppStates>(
      listener: (context, state) {
        var cubit = UserAppCubit.get(context);
        if (cubit.bookStatus == 200) {
          showToast(
            'Booked successfully'.tr(),
            context: context,
            animation: StyledToastAnimation.scale,
            duration: const Duration(seconds: 5),
            backgroundColor: const Color(0xff6bc17a),
            borderRadius: BorderRadius.circular(50),
            alignment: Alignment.bottomCenter,
          );
          Navigator.pop(context);
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UserAppCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: state is! UserGetCenterLoading,
            builder: (context)=>SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: height,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/background2.jpg',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height,
                    width: width,
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * .7,
                          child: Padding(
                            padding:
                            const EdgeInsets
                                .only(
                                top: 20),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .center,
                              children: [
                                TextFormField(
                                  controller:
                                  caseNameController,
                                  decoration:
                                   InputDecoration(
                                    labelText:
                                    'Case name'.tr(),
                                    prefixIcon: const Icon(
                                        Icons
                                            .account_circle_outlined,
                                        color: Color(
                                            0xff1b4b35)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller:
                                  mobileController,
                                  keyboardType:
                                  TextInputType
                                      .phone,
                                  onFieldSubmitted:
                                      (String
                                  value) {
                                    print(
                                        value);
                                  },
                                  decoration:
                                   InputDecoration(
                                    labelText:
                                    'Mobile'.tr(),
                                    prefixIcon: const Icon(
                                        Icons
                                            .phone_android_outlined,
                                        color: Color(
                                            0xff1b4b35)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  onTap: (){
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2022-12-31'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  controller:
                                  dateController,
                                  keyboardType:
                                  TextInputType
                                      .text,
                                  onFieldSubmitted:
                                      (String
                                  value) {
                                    print(
                                        value);
                                  },
                                  decoration:
                                   InputDecoration(
                                    labelText:
                                    'Date'.tr(),
                                    prefixIcon:
                                    const Icon(
                                      Icons
                                          .date_range_rounded,
                                      color: Color(
                                          0xff1b4b35),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 150,
                                  child:
                                  ConditionalBuilder(
                                    condition: state
                                    is! CenterBookingLoading,
                                    builder:
                                        (context) =>
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(50)),
                                          color: const Color(
                                              0xf737da97),
                                          onPressed:
                                              () {
                                            cubit
                                                .CenterBooking(
                                              centerId: cubit
                                                  .centers[index]
                                                  .id,
                                              caseName:
                                              caseNameController.text,
                                              mobile:
                                              mobileController.text,
                                              bookingDate:dateController.text ,
                                            );
                                          },
                                          child:
                                          const Text(
                                            "BOOK",
                                            style: TextStyle(
                                                fontSize:
                                                25,
                                                color:
                                                Colors.white),
                                          ).tr(),
                                        ),
                                    fallback: (context) =>
                                    const Center(
                                        child:
                                        CircularProgressIndicator()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            fallback: (context)=>const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    ),
);
  }
}
