import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/app_screens/centers_screens/center_layout/cubit/center_cubit.dart';
import 'package:graduation_project/app_screens/centers_screens/center_layout/cubit/center_states.dart';
import 'package:graduation_project/app_screens/centers_screens/center_layout/layout_screens/home/centers/my_center_info.dart';

import 'centers/create_center.dart';

class CenterHome extends StatelessWidget {
  const CenterHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => CenterAppCubit()..getCenters(),
      child: BlocConsumer<CenterAppCubit, CenterAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CenterAppCubit.get(context);
          int navBarIndex = cubit.navBarIndex;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .04,
                  vertical: height * .05,
                ),
                child: Container(
                  height: height * .1,
                  width: width,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.0, -1.156),
                      end: Alignment(0.022, 0.311),
                      colors: [Color(0xff2ad59a), Color(0xff1aa586)],
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: ({int index = 0}) {
                            cubit.changeNavBar(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: navBarIndex == 0
                                  ? const Color(0xff0d5b49)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            width: width * .50,
                            height: height * .08,
                            child: Center(
                              child: Text(
                                'My Center',
                                style: TextStyle(
                                  color: navBarIndex == 0
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: navBarIndex == 0 ? 24 : 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ).tr(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ConditionalBuilder(
                condition: state is! CenterGetCenterLoading,
                builder: (context) => Expanded(
                  child: Stack(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyCenterInfo(index: index)));
                          },
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              bottom: height * .03,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width * .9,
                                    height: height * .2,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(5, 5),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                            start: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(65),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      offset: Offset(3, 5),
                                                    ),
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: NetworkImage(
                                                      '${cubit.centers[index].image}'),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * .05,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: width*.5,
                                                    child: Text(
                                                      '${cubit.centers[index].name}',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 25,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * .02,
                                                  ),
                                                  RatingBar.builder(
                                                    itemSize: width / 7 * .5,
                                                    initialRating:
                                                        cubit.centers[index].rating +
                                                            0.0,
                                                    minRating: 0,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {},
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 20,),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsetsDirectional.only(
                                            start: width*.68,
                                            top: height*.155
                                          ),
                                          child: Container(
                                            color:cubit.centers[index].status=='pending'? Colors.yellow:cubit.centers[index].status=='قيد الانتظار'? Colors.yellow
                                            :const Color(0xf737da97),
                                            width: 60,
                                            height: 20,
                                            child: Center(
                                              child: Text(
                                                '${cubit.centers[index].status}',
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ).tr(),
                                            ),
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
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                        itemCount: cubit.centers.length,
                      ),
                      cubit.centers.length==0? SizedBox(
                        width: width,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: FloatingActionButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateCenter()));
                                },
                                backgroundColor: const Color(0xff1aa586),
                                child: const Icon(
                                  Icons.add,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ):const SizedBox(width: 1),
                    ],
                  ),
                ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        },
      ),
    );
  }
}
