
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/cubit/user_cubit.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/cubit/user_states.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/layout_screens/user_home/store_info_and_products.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/layout_screens/user_home/user_center_info.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/layout_screens/user_home/user_make_volunteer_request.dart';



class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  bool sign = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return BlocProvider(
  create: (context) => UserAppCubit()..getCenters()..getStores()..getUserData()..getUserRequests(),
  child: BlocConsumer<UserAppCubit, UserAppStates>(
        listener: (context, state) {},
    builder: (context, state) {
      var cubit = UserAppCubit.get(context);
     int navBarIndex=cubit.navBarIndex;
     bool c1=state is! UserGetCenterLoading;
     bool c2=state is! UserGetStoreLoading;
     bool c3=state is! GetUserDataLoading;
     bool c4=state is! GetUserRequestsLoading;

      return

        Column(
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
                    begin: Alignment(0.0,-1.156),
                    end: Alignment(0.022,0.311),
                    colors: [Color(0xff2ad59a),Color(0xff1aa586)],
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: ({int index=0}){
                          cubit.changeNavBar(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:navBarIndex==0? const Color(0xff0d5b49):Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          width: width * .29,
                          height: height * .08,
                          child: Center(
                            child: Text(
                              'Centers',
                              style: TextStyle(
                                color: navBarIndex==0?Colors.white:Colors.black,
                                fontSize: navBarIndex==0?24:18,
                                fontWeight: FontWeight.w900,
                              ),
                            ).tr(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: ({int index=1}){
                          cubit.changeNavBar(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:navBarIndex==1? const Color(0xff0d5b49):Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          width: width * .29,
                          height: height * .08,
                          child: Center(
                            child: Text(
                              'Stores',
                              style: TextStyle(
                                color: navBarIndex==1?Colors.white:Colors.black,
                                fontSize: navBarIndex==1?24:18,
                                fontWeight: FontWeight.w900,
                              ),
                            ).tr(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: ({int index=2}){
                          cubit.changeNavBar(index);

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:navBarIndex==2? const Color(0xff0d5b49):Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          width: width * .29,
                          height: height * .08,
                          child: Center(
                            child: Text(
                              'Helpers',
                              style: TextStyle(
                                color: navBarIndex==2?Colors.white:Colors.black,

                                fontSize: navBarIndex==2?24:18,
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
            navBarIndex==0? ConditionalBuilder(
              condition: c1&c2&c3&c4,
              builder: (context)=>Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) =>
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserCenterInfo(index: index,),),);
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
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      start: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(65),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(3, 5),
                                              ),
                                            ],
                                          ),
                                          child:  CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage('${cubit.centers[index].image}'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * .05,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
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
                                              height: height * .04,
                                            ),
                                            RatingBar.builder(
                                              itemSize: width / 7 * .5,
                                              initialRating: cubit.centers[index].rating+0.0,
                                              minRating: 1,
                                              direction: Axis.horizontal,
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

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) =>
                  const SizedBox(
                    height: 5,
                  ),
                  itemCount: cubit.centers.length,
                ),
              ),
              fallback: (context)=>const Center(child: CircularProgressIndicator()),
            )
                :navBarIndex==1 ?
            ConditionalBuilder(
              condition: state is! UserGetStoreLoading,
              builder: (context)=>Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) =>
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserStoreInfo(index: index,storeId: cubit.stores[index].id,),),);
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
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      start: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(65),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(3, 5),
                                              ),
                                            ],
                                          ),
                                          child:  CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage('${cubit.stores[index].image}'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * .05,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: width*.5,
                                              child: Text(
                                                '${cubit.stores[index].name}',
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * .04,
                                            ),
                                            SizedBox(
                                              width: width*.5,
                                              child: Text(
                                                '${cubit.stores[index].address}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),

                                          ],
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
                  separatorBuilder: (context, index) =>
                  const SizedBox(
                    height: 5,
                  ),
                  itemCount: cubit.stores.length,
                ),
              ),
              fallback: (context)=>const Center(child: CircularProgressIndicator()),
            )
                : Expanded(
              child: Stack(
                children: [
                  ListView.separated(
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) =>
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            bottom: height * .03,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * .9,
                                  height:cubit.requests[index].volunteerType=='driver'? 150:110,
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
                                          start: 20,
                                          top: 5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsetsDirectional.only(top:height*0.01),
                                              child: Text('${cubit.requests[index].userName}',
                                                style: const TextStyle(fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ) ,
                                            Row(
                                              children: [
                                                const Text(
                                                    'Volunteer:',
                                                  style: TextStyle(fontSize: 15,
                                                      color: Colors.black54,
                                                      fontWeight:FontWeight.bold),
                                                ).tr(),
                                                const SizedBox(width: 8,),
                                                Text(
                                                  '${cubit.requests[index].volunteerType}',
                                                  style: const TextStyle(fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:FontWeight.bold),
                                                ),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                const Text(
                                                  'Date:',
                                                  style: TextStyle(fontSize: 15,
                                                      letterSpacing: 2,
                                                      color: Colors.black54,
                                                      fontWeight:FontWeight.bold),
                                                ).tr(),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  '${cubit.requests[index].date}',
                                                  style: const TextStyle(fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:FontWeight.bold),
                                                ),
                                              ],
                                            ),

                                            cubit.requests[index].volunteerType=='driver'? Column(
                                              children: [
                                                Row(
                                                  children:  [
                                                    const Text(
                                                      'From:',
                                                      style: TextStyle(fontSize: 15,
                                                          letterSpacing: 2,
                                                          color: Colors.black54,
                                                          fontWeight:FontWeight.bold),
                                                    ).tr(),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      '${cubit.requests[index].from}',
                                                      style: const TextStyle(fontSize: 18,
                                                          color: Colors.black,
                                                          fontWeight:FontWeight.bold),
                                                    ),
                                                  ],
                                                ),

                                                Row(
                                                  children: [
                                                    const Text(
                                                      'To:',
                                                      style: TextStyle(fontSize: 15,
                                                          letterSpacing: 2,
                                                          color: Colors.black54,
                                                          fontWeight:FontWeight.bold),
                                                    ).tr(),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      '${cubit.requests[index].to}',
                                                      style: const TextStyle(fontSize: 18,
                                                          color: Colors.black,
                                                          fontWeight:FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ):const SizedBox(width: 1,),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                          start: width*.77,
                                          top: height*.02
                                        ),
                                        child: Icon(
                                          cubit.requests[index].status=='accepted' ? Icons.check_box_outlined:cubit.requests[index].status=='تمت الموافقة' ? Icons.check_box_outlined
                                              :cubit.requests[index].status=='finished' ? Icons.check_box_outlined :cubit.requests[index].status=='منتهي' ? Icons.check_box_outlined
                                              : Icons.check_box_outline_blank,
                                          color: Colors.green,
                                          size: 30,
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsetsDirectional.only(
                                            start: width*.68,
                                            top: cubit.requests[index].volunteerType=='driver'? 110:80,
                                        ),
                                        child: Container(
                                          color:cubit.requests[index].status=='pending'? Colors.yellow:cubit.requests[index].status=='قيد الانتظار'? Colors.yellow
                                              :const Color(0xf737da97),
                                          width: 60,
                                          height: 20,
                                          child: Center(
                                            child: Text(
                                              '${cubit.requests[index].status}',
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
                    separatorBuilder: (context, index) =>
                    const SizedBox(
                      height: 5,
                    ),
                    itemCount: cubit.requests.length,
                  ),
                  SizedBox(
                    width: width,
                    height: height * .68,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: FloatingActionButton(
                            onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserMakeVolunteerRequest()));
                            },
                            backgroundColor: const Color(0xff1aa586),
                            child: const Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
    },
    ),
);
  }
}
