import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/cubit/store_cubit.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/cubit/store_states.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/layout_screens/home/store/create_store.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/layout_screens/home/store/my_store_info_and_products.dart';



class StoreHome extends StatelessWidget {
  const StoreHome({Key? key}) : super(key: key);

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
  create: (context) => StoreAppCubit()..getStores(),
  child: BlocConsumer<StoreAppCubit, StoreAppStates>(
        listener: (context, state) {},
    builder: (context, state) {
      var cubit = StoreAppCubit.get(context);
     int navBarIndex=cubit.navBarIndex;

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
                          width: width * .50,
                          height: height * .08,
                          child: Center(
                            child: Text(
                              'Your Store',
                              style: TextStyle(
                                color: navBarIndex==0?Colors.white:Colors.black,
                                fontSize: navBarIndex==0?24:18,
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
                condition: state is! StoreGetStoreLoading,
                builder: (context)=>Expanded(
                  child: Stack(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) =>
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyStoreInfo(index: index,storeId: cubit.stores[index].id,)));
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
                                        height: height * .23,
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
                                                      borderRadius: BorderRadius.circular(65),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.black12,
                                                          offset: Offset(3, 5),
                                                        ),
                                                      ],
                                                    ),
                                                    child:  CircleAvatar(
                                                      radius: 55,
                                                      backgroundColor: Colors.white,
                                                      backgroundImage: NetworkImage('${cubit.stores[index].image}'),

                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width * .03,
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
                                                            fontSize: 22,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                      ),
                                                       ),
                                                      SizedBox(
                                                        height: height * .01,
                                                      ),
                                                       SizedBox(
                                                         width: width*.5,
                                                         child: Text(
                                                          '${cubit.stores[index].address}',
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis ,
                                                          style: const TextStyle(
                                                            fontSize: 16,
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
                                            Padding(
                                              padding:  EdgeInsetsDirectional.only(
                                                start: width*.67,
                                                top: height*.19,
                                              ),
                                              child: Container(
                                                color:cubit.stores[index].status=='pending'? Colors.yellow:cubit.stores[index].status=='قيد الانتظار'? Colors.yellow
                                                :const Color(0xf737da97),
                                                width: 60,
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    '${cubit.stores[index].status}',
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
                        separatorBuilder: (context, index) =>
                        const SizedBox(
                          height: 5,
                        ),
                        itemCount: cubit.stores.length,
                      ),
                      cubit.stores.length==0?  SizedBox(
                        width: width,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: FloatingActionButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateStore()));
                                },
                                backgroundColor: const Color(0xff1aa586),
                                child: const Icon(
                                  Icons.add,
                                ),

                              ),
                            ),
                          ],
                        ),
                      ):const SizedBox(width: 1,),
                    ],
                  ),

                ),
                fallback: (context)=>const Center(child: CircularProgressIndicator()),
            ),
          ],
        );
    },
    ),
);
  }
}
