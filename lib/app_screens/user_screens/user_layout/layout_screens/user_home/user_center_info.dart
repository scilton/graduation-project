import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' '';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/cubit/user_cubit.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/cubit/user_states.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/layout_screens/user_home/user_booking.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:url_launcher/url_launcher.dart';

class UserCenterInfo extends StatelessWidget {
  int index;
  var caseNameController = TextEditingController();
  var mobileController = TextEditingController();
  var dateController = TextEditingController();

  UserCenterInfo({required this.index});

  @override
  Widget build(BuildContext context) {
    var rate = 3;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserAppCubit()..getCenters())
      ],
      child: BlocConsumer<UserAppCubit, UserAppStates>(
        listener: (context, state) {
          var cubit = UserAppCubit.get(context);
          if (cubit.rateStatus == 200) {
            showToast(
              'rating has been submitted'.tr(),
              context: context,
              animation: StyledToastAnimation.scale,
              duration: Duration(seconds: 5),
              backgroundColor: Color(0xff6bc17a),
              borderRadius: BorderRadius.circular(50),
              alignment: Alignment.bottomCenter,
            );
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = UserAppCubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
              condition: state is! UserGetCenterLoading,
              builder: (context) => Stack(
                children: [
                  Container(
                    height: height * .36,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('${cubit.centers[index].image}'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: height * .32,
                      ),
                      child: Container(
                        height: height * .71,
                        width: width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 25,
                            start: 20,
                            end: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: width * .7,
                                    child: Text(
                                      '${cubit.centers[index].name}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 29.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_call),
                                    onPressed: () => launch(
                                        'tel:${cubit.centers[index].phoneNumber}'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: width * .7,
                                child: Text(
                                  '${cubit.centers[index].address}',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${cubit.centers[index].phoneNumber}',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating:
                                        cubit.centers[index].rating + 0.0,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemSize: 30,
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                      rate = rating.round();
                                    },
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      end: 10,
                                    ),
                                    child: ConditionalBuilder(
                                      condition: state is! CenterRatingLoading,
                                      builder: (context) => defaultButton(
                                        width: width * .2,
                                        radius: 0,
                                        backgroundColor:
                                            const Color(0xf737da97),
                                        function: () {
                                          cubit.CenterRating(
                                              centerId: cubit.centers[index].id,
                                              rate: rate);
                                        },
                                        text: 'Submit'.tr(),
                                        fontSize: 10,
                                        height: 35,
                                      ),
                                      fallback: (context) => const Center(
                                          child: SizedBox(
                                              width: 20,
                                              height: 20,
                                              child:
                                                  CircularProgressIndicator())),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'About',
                                        style: TextStyle(
                                          color: Color(0xff25258f),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0,
                                        ),
                                      ).tr(),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '${cubit.centers[index].about}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width * .4,
                                      height: height * .07,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>UserBooking(index: index)));
                                        },
                                        color: const Color(0xe537da97),
                                        child: const Text(
                                          'BOOK',
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                          ),
                                        ).tr(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
