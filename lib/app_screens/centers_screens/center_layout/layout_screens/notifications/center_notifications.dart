
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cubit/center_cubit.dart';
import '../../cubit/center_states.dart';

class CenterNotifications extends StatefulWidget {
  const CenterNotifications({Key? key}) : super(key: key);

  @override
  State<CenterNotifications> createState() => _CenterNotificationsState();
}

class _CenterNotificationsState extends State<CenterNotifications> {


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) =>
      CenterAppCubit()
        ..getNotification(),
      child: BlocConsumer<CenterAppCubit, CenterAppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = CenterAppCubit.get(context);


          return Stack(
            children: [
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/images/background2.jpg',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 20,
                ),
                child: ConditionalBuilder(
                  condition: state is! CenterGetNotificationsLoading,
                  builder: (context) => Stack(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {

                          var content =cubit.notifications[index].data.content;
                          var phone= content.replaceAll(new RegExp(r'[^0-9]'),'');
                          return cubit.notifications[index].data.title=='Center Booking'
                              ? Stack(
                                children: [
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
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: width * .05,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: width*.7,
                                                  child: Text(
                                                    '${cubit.notifications[index].data.title}',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                  width: width*.7,
                                                  child: Text(
                                                    '${cubit.notifications[index].data.content}',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                            ),
                          ),
                                  Padding(
                                    padding:  EdgeInsetsDirectional.only(
                                      start: width*.8,
                                      top: 10,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.add_call),
                                      onPressed: () => launch(
                                          'tel:${phone.substring(0,11)}'),
                                      iconSize: 30,
                                    ),
                                  ),
                                ],
                              )
                              :Padding(
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
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width * .05,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: width*.7,
                                              child: Text(
                                                '${cubit.notifications[index].data.title}',
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              width: width*.7,
                                              child: Text(
                                                '${cubit.notifications[index].data.content}',
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                        itemCount: cubit.notifications.length,
                      ),
                      cubit.notifications.length==0? SizedBox(
                        width: width,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'No notifications yet',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold

                              ),
                            ).tr(),
                          ],
                        ),
                      ):const SizedBox(width: 1),
                    ],
                  ),
                  fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}
