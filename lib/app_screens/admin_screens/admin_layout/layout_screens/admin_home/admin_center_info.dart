import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' '';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/app_screens/admin_screens/admin_layout/admin_home_layout.dart';
import 'package:graduation_project/app_screens/admin_screens/admin_layout/cubit/admin_cubit.dart';
import 'package:graduation_project/app_screens/admin_screens/admin_layout/cubit/admin_states.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminCenterInfo extends StatelessWidget {
  int index;
  String status;

  AdminCenterInfo({required this.index,required this.status});

  @override
  Widget build(BuildContext context) {
    var rate = 3;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AdminAppCubit()..getAcceptedCenters()..getPendingCenters())
      ],
      child: BlocConsumer<AdminAppCubit, AdminAppStates>(
        listener: (context, state) {
          var cubit = AdminAppCubit.get(context);
          if (cubit.rateStatus == 200) {
            showToast(
              'rating has been submitted'.tr(),
              context: context,
              animation: StyledToastAnimation.scale,
              duration: const Duration(seconds: 5),
              backgroundColor: const Color(0xff6bc17a),
              borderRadius: BorderRadius.circular(50),
              alignment: Alignment.bottomCenter,
            );
          }
          if (cubit.approveCenterStatus == 200) {
            showToast(
              'Center approved'.tr(),
              context: context,
              animation: StyledToastAnimation.scale,
              duration: const Duration(seconds: 5),
              backgroundColor: const Color(0xff6bc17a),
              borderRadius: BorderRadius.circular(50),
              alignment: Alignment.bottomCenter,
            );
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const AdminHomeLayout()), (route) => false);
          }

          if (cubit.rejectCenterStatus == 200) {
            showToast(
              'Center rejected'.tr(),
              context: context,
              animation: StyledToastAnimation.scale,
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(50),
              alignment: Alignment.bottomCenter,
            );
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const AdminHomeLayout()), (route) => false);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AdminAppCubit.get(context);
          bool c1= state is! AdminGetAcceptedCenterLoading;
          bool c2= state is! AdminGetPendingCenterLoading;

          return Scaffold(
            body: ConditionalBuilder(
              condition:c1&c2,
              builder: (context) =>status=='accepted'? Stack(
                children: [
                  Container(
                    height: height * .36,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('${cubit.acceptedCenters[index].image}'),
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
                                      '${cubit.acceptedCenters[index].name}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_call),
                                    onPressed: () => launch(
                                        'tel:${cubit.acceptedCenters[index].phoneNumber}'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: width * .7,
                                child: Text(
                                  '${cubit.acceptedCenters[index].address}',
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
                                '${cubit.acceptedCenters[index].phoneNumber}',
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
                                        cubit.acceptedCenters[index].rating + 0.0,
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
                                      condition: state is! AdminRatingLoading,
                                      builder: (context) => defaultButton(
                                        width: width * .2,
                                        radius: 0,
                                        backgroundColor:
                                            const Color(0xf737da97),
                                        function: () {
                                          cubit.CenterRating(
                                              centerId: cubit.acceptedCenters[index].id,
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
                                height: 10,
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
                                        '${cubit.acceptedCenters[index].about}',
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ):Stack(
                children: [
                  Container(
                    height: height * .36,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('${cubit.pendingCenters[index].image}'),
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
                            top: 15,
                            start: 20,
                            end: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ConditionalBuilder(
                                    condition: state is! AdminRejectCenterLoading,
                                    builder: (context) => defaultButton(
                                      width: width * .25,
                                      radius: 0,
                                      backgroundColor:
                                      Colors.red,
                                      function: () {
                                        cubit.rejectCenter(
                                          centerId: cubit.pendingCenters[index].id,
                                        );
                                      },
                                      text: 'Reject'.tr(),
                                      fontSize: 14,
                                      height: height*.07,
                                    ),
                                    fallback: (context) => const Center(
                                        child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child:
                                            CircularProgressIndicator())),
                                  ),
                                  SizedBox(width: width*.1,),
                                  ConditionalBuilder(
                                    condition: state is! AdminApproveCenterLoading,
                                    builder: (context) => defaultButton(
                                      width: width * .25,
                                      radius: 0,
                                      backgroundColor:
                                      const Color(0xf737da97),
                                      function: () {
                                        cubit.approveCenter(
                                          centerId: cubit.pendingCenters[index].id,
                                        );
                                      },
                                      text: 'Accept'.tr(),
                                      fontSize: 14,
                                      height: height*.07,
                                    ),
                                    fallback: (context) => const Center(
                                        child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child:
                                            CircularProgressIndicator())),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: width * .7,
                                    child: Text(
                                      '${cubit.pendingCenters[index].name}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_call),
                                    onPressed: () => launch(
                                        'tel:${cubit.pendingCenters[index].phoneNumber}'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: width * .7,
                                child: Text(
                                  '${cubit.pendingCenters[index].address}',
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
                                '${cubit.pendingCenters[index].phoneNumber}',
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
                                    cubit.pendingCenters[index].rating + 0.0,
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
                                      condition: state is! AdminRatingLoading,
                                      builder: (context) => defaultButton(
                                        width: width * .2,
                                        radius: 0,
                                        backgroundColor:
                                        const Color(0xf737da97),
                                        function: () {
                                          cubit.CenterRating(
                                              centerId: cubit.pendingCenters[index].id,
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
                                height: 10,
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
                                        '${cubit.pendingCenters[index].about}',
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
