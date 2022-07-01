
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/app_screens/admin_screens/admin_layout/cubit/admin_cubit.dart';
import 'package:graduation_project/app_screens/admin_screens/admin_layout/cubit/admin_states.dart';
import 'package:graduation_project/app_screens/admin_screens/admin_layout/layout_screens/admin_home/admin_center_info.dart';
import 'package:graduation_project/app_screens/admin_screens/admin_layout/layout_screens/admin_home/admin_store_info_and_products.dart';




class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
  create: (context) => AdminAppCubit()..getAcceptedCenters()..getPendingCenters()..getAcceptedStores()..getPendingStores()..getUserRequests(),
  child: BlocConsumer<AdminAppCubit, AdminAppStates>(
        listener: (context, state) {},
    builder: (context, state) {
      var cubit = AdminAppCubit.get(context);
     int navBarIndex=cubit.navBarIndex;
     int pendingNavBarIndex=cubit.pendingNavBarIndex;
     bool c1=state is! AdminGetAcceptedCenterLoading;
     bool c2=state is! AdminGetAcceptedStoreLoading;
     bool c3=state is! AdminGetPendingCenterLoading;
     bool c4=state is! AdminGetPendingStoreLoading;
     bool c5=state is! AdminGetUserRequestsLoading;

      return

        Column(
          children: [
            SizedBox(height: height*.03,),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * .02,
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
                          width: width * .23,
                          height: height * .08,
                          child: Center(
                            child: Text(
                              'Centers',
                              style: TextStyle(
                                color: navBarIndex==0?Colors.white:Colors.black,
                                fontSize: navBarIndex==0?20:16,
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
                          width: width * .23,
                          height: height * .08,
                          child: Center(
                            child: Text(
                              'Stores',
                              style: TextStyle(
                                color: navBarIndex==1?Colors.white:Colors.black,
                                fontSize: navBarIndex==1?20:16,
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
                          width: width * .23,
                          height: height * .08,
                          child: Center(
                            child: Text(
                              'Helpers',
                              style: TextStyle(
                                color: navBarIndex==2?Colors.white:Colors.black,
                                fontSize: navBarIndex==2?20:16,
                                fontWeight: FontWeight.w900,
                              ),
                            ).tr(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: ({int index=3}){
                          cubit.changeNavBar(index);

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:navBarIndex==3? const Color(0xff0d5b49):Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          width: width * .23,
                          height: height * .08,
                          child: Center(
                            child: Text(
                              'Pending',
                              style: TextStyle(
                                color: navBarIndex==3?Colors.white:Colors.black,
                                fontSize: navBarIndex==3?20:16,
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
             SizedBox(
              height:(0<=navBarIndex&&navBarIndex<=2)?20:10,
            ),
            (0<=navBarIndex&&navBarIndex<=2)? const SizedBox(width: 0,):Container(
              height: height * .1,
              width: width*.6,
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
                        cubit.changePendingNavBar(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:pendingNavBarIndex==0? const Color(0xff0d5b49):Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: width * .23,
                        height: height * .08,
                        child: Center(
                          child: Text(
                            'Centers',
                            style: TextStyle(
                              color: pendingNavBarIndex==0?Colors.white:Colors.black,
                              fontSize: pendingNavBarIndex==0?20:16,
                              fontWeight: FontWeight.w900,
                            ),
                          ).tr(),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ({int index=1}){
                        cubit.changePendingNavBar(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:pendingNavBarIndex==1? const Color(0xff0d5b49):Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: width * .23,
                        height: height * .08,
                        child: Center(
                          child: Text(
                            'Stores',
                            style: TextStyle(
                              color: pendingNavBarIndex==1?Colors.white:Colors.black,
                              fontSize: pendingNavBarIndex==1?20:16,
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
            // c1&c2&c3&c4&c5                             Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminCenterInfo(index: index,status: cubit.acceptedCenters[index].status,),),);
            navBarIndex==0? ConditionalBuilder(
              condition: c1&c2&c3&c4&c5,
              builder: (context)=>Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) =>
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminCenterInfo(index: index,status: cubit.acceptedCenters[index].status,),),);                        },
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
                                            backgroundImage: NetworkImage('${cubit.acceptedCenters[index].image}'),
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
                                                '${cubit.acceptedCenters[index].name}',
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
                                              initialRating: cubit.acceptedCenters[index].rating+0.0,
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
                  itemCount: cubit.acceptedCenters.length,
                ),
              ),
              fallback: (context)=>const Center(child: CircularProgressIndicator()),
            )
                :navBarIndex==1 ?
            ConditionalBuilder(
              condition: state is! AdminGetAcceptedStoreLoading,
              builder: (context)=>Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) =>
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminStoreInfo(index: index,status: cubit.acceptedStores[index].status,storeId: cubit.acceptedStores[index].id),),);                        },
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
                                            backgroundImage: NetworkImage('${cubit.acceptedStores[index].image}'),
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
                                                '${cubit.acceptedStores[index].name}',
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
                                                '${cubit.acceptedStores[index].address}',
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
                  itemCount: cubit.acceptedStores.length,
                ),
              ),
              fallback: (context)=>const Center(child: CircularProgressIndicator()),
            )
                :navBarIndex==2? Expanded(
              child: Stack(
                children: [
                  ListView.separated(
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
                                              height: 10,
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
                                                SizedBox(
                                                  width: width*0.02,
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
                                                    SizedBox(
                                                      width: width*0.02,
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
                ],
              ),
            )
                :pendingNavBarIndex==0? Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) =>
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminCenterInfo(index: index,status: cubit.pendingCenters[index].status,),),);                        },
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
                                          backgroundImage: NetworkImage('${cubit.pendingCenters[index].image}'),
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
                                              '${cubit.pendingCenters[index].name}',
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
                                            initialRating: cubit.pendingCenters[index].rating+0.0,
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
                itemCount: cubit.pendingCenters.length,
              ),
            ):Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) =>
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminStoreInfo(index: index,status: cubit.pendingStores[index].status,storeId: cubit.pendingStores[index].id),),);                        },
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
                                          backgroundImage: NetworkImage('${cubit.pendingStores[index].image}'),
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
                                              '${cubit.pendingStores[index].name}',
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
                                              '${cubit.pendingStores[index].address}',
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
                itemCount: cubit.pendingStores.length,
              ),
            ),
          ],
        );
    },
    ),
);
  }
}
