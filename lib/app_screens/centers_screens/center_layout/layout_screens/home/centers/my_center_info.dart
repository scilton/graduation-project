import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' '';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/app_screens/centers_screens/center_layout/cubit/center_cubit.dart';
import 'package:graduation_project/app_screens/centers_screens/center_layout/cubit/center_states.dart';

class MyCenterInfo extends StatelessWidget {
  int index;

  MyCenterInfo({required this.index});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CenterAppCubit()..getCenters(),
        )
      ],
      child: BlocConsumer<CenterAppCubit, CenterAppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = CenterAppCubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
              condition: state is! CenterGetCenterLoading,
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: width*.8,
                                    child: Text(
                                      '${cubit.centers[index].name}',
                                      maxLines: 3,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                               Text(
                                '${cubit.centers[index].address}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                              const SizedBox(height: 10.0,),
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
                              RatingBar.builder(
                                initialRating: cubit.centers[index].rating + 0.0,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemSize: 30,
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
