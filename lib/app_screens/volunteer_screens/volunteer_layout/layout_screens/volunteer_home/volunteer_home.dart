
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/app_screens/volunteer_screens/volunteer_layout/cubit/volunteer_cubit.dart';
import 'package:graduation_project/app_screens/volunteer_screens/volunteer_layout/cubit/volunteer_states.dart';
import 'package:graduation_project/app_screens/volunteer_screens/volunteer_layout/volunteer_home_layout.dart';
import 'package:graduation_project/shared/components/components.dart';



class VolunteerHome extends StatefulWidget {
  const VolunteerHome({Key? key}) : super(key: key);

  @override
  State<VolunteerHome> createState() => _VolunteerHomeState();
}

class _VolunteerHomeState extends State<VolunteerHome> {
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
  create: (context) => VolunteerAppCubit()..getUserRequests()..getAcceptedRequest(),
  child: BlocConsumer<VolunteerAppCubit, VolunteerAppStates>(
        listener: (context, state) {
          var cubit = VolunteerAppCubit.get(context);

          if(cubit.acceptStatus==200){
            showToast('Request accepted successfully'.tr(),
              context: context,
              animation: StyledToastAnimation.scale,
              duration: const Duration(seconds: 5),
              backgroundColor: const Color(0xff6bc17a),
              borderRadius: BorderRadius.circular(50),
              alignment: Alignment.bottomCenter,
            );
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context)=>const VolunteerHomeLayout()), (route) => false);
          }
          if(cubit.acceptStatus==401){
            showToast(' You are busy \n finish your trip first'.tr(),
              context: context,
              animation: StyledToastAnimation.scale,
              duration: const Duration(seconds: 5),
              backgroundColor:  Colors.red,
              borderRadius: BorderRadius.circular(50),
              alignment: Alignment.bottomCenter,
            );
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context)=>const VolunteerHomeLayout()), (route) => false);
          }

          if(cubit.finishStatus==200){
            showToast('Trip finished successfully'.tr(),
              context: context,
              animation: StyledToastAnimation.scale,
              duration: const Duration(seconds: 5),
              backgroundColor:  const Color(0xff6bc17a),
              borderRadius: BorderRadius.circular(50),
              alignment: Alignment.bottomCenter,
            );
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context)=>const VolunteerHomeLayout()), (route) => false);
          }
        },
    builder: (context, state) {
      var cubit = VolunteerAppCubit.get(context);
      int navBarIndex=cubit.volunteerNavBarIndex;
      bool c1=state is! VolunteerGetUserRequestsLoading;
      bool c2=state is! VolunteerGetAcceptedRequestsLoading;

      return

        Column(
          children: [
            SizedBox(
              height: height*.04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * .04,
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
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff0d5b49),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: width * .45,
                        height: height * .08,
                        child:  Center(
                          child: const Text(
                            'Help Requests',
                            style: TextStyle(
                              color: Colors.white,

                              fontSize:20,
                              fontWeight: FontWeight.w900,
                            ),
                          ).tr(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(
                vertical: height*.02,
              ),
              child: Container(
                height: height * .1,
                width: width*.92,
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
                          cubit.changeVolunteerNavBar(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:navBarIndex==0? const Color(0xff0d5b49):Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          width: width * .25,
                          height: height * .08,
                          child: Center(
                            child: Text(
                              'Pending',
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
                          cubit.changeVolunteerNavBar(index);
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
                              'Accepted',
                              style: TextStyle(
                                color: navBarIndex==1?Colors.white:Colors.black,
                                fontSize: navBarIndex==1?20:16,
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
                 condition: c1&c2,
                 builder: (context)=>Expanded(
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
                                       height:cubit.requests[index].volunteerType=='driver'? 200:150,
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
                                                       'Phone:',
                                                       style: TextStyle(fontSize: 15,
                                                           color: Colors.black54,
                                                           fontWeight:FontWeight.bold),
                                                     ).tr(),
                                                     const SizedBox(width: 8,),
                                                     Text(
                                                       '${cubit.requests[index].userPhone}',
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
                                             padding:  EdgeInsetsDirectional.only(
                                               start: width*.68,
                                               top: height*.03,
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
                                           Padding(
                                             padding: const EdgeInsetsDirectional.only(
                                               bottom: 15,
                                             ),
                                             child: SizedBox(
                                               width: width,
                                               child: Column(
                                                 mainAxisAlignment: MainAxisAlignment.end,
                                                 crossAxisAlignment: CrossAxisAlignment.center,
                                                 children: [
                                                   ConditionalBuilder(
                                                     condition: state is! VolunteerAcceptRequestsLoading,
                                                     builder: (context) =>
                                                         Container(
                                                           decoration: BoxDecoration(
                                                             color: const Color(
                                                                 0xf737da97),
                                                               borderRadius: BorderRadiusDirectional
                                                                   .circular(27),
                                                           ),
                                                           child: defaultButton(
                                                             function: () {
                                                               bool yes =true;
                                                               cubit.volunteerAcceptRequest(cubit.requests[index].id);
                                                             },
                                                             width: MediaQuery
                                                                 .of(context)
                                                                 .size
                                                                 .width * 0.4,
                                                             height: MediaQuery
                                                                 .of(context)
                                                                 .size
                                                                 .height * 0.07,
                                                             text: 'Accept'.tr(),
                                                           ),
                                                         ),
                                                     fallback: (context) =>
                                                     const Center(
                                                         child: CircularProgressIndicator()),
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
                             ),
                         separatorBuilder: (context, index) =>
                         const SizedBox(
                           height: 5,
                         ),
                         itemCount: cubit.requests.length,
                       ),
                     ],
                   ),
                 ),
                 fallback: (context)=>const Center(child: CircularProgressIndicator()),
             )
                 :ConditionalBuilder(
               condition: c1&c2,
               builder: (context)=>Expanded(
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
                                     height:cubit.acceptedRequests[index].volunteerType=='driver'? 200:150,
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
                                                 child: Text('${cubit.acceptedRequests[index].userName}',
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
                                                     'Phone:',
                                                     style: TextStyle(fontSize: 15,
                                                         color: Colors.black54,
                                                         fontWeight:FontWeight.bold),
                                                   ).tr(),
                                                   const SizedBox(width: 8,),
                                                   Text(
                                                     '${cubit.acceptedRequests[index].userPhone}',
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
                                                     '${cubit.acceptedRequests[index].date}',
                                                     style: const TextStyle(fontSize: 18,
                                                         color: Colors.black,
                                                         fontWeight:FontWeight.bold),
                                                   ),
                                                 ],
                                               ),
                                               cubit.acceptedRequests[index].volunteerType=='driver'? Column(
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
                                                         '${cubit.acceptedRequests[index].from}',
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
                                                         '${cubit.acceptedRequests[index].to}',
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
                                           padding:  EdgeInsetsDirectional.only(
                                             start: width*.68,
                                             top: height*.03,
                                           ),
                                           child: Container(
                                             color:cubit.acceptedRequests[index].status=='accepted'? Colors.yellow:cubit.acceptedRequests[index].status=='تمت الموافقة'? Colors.yellow
                                             :const Color(0xf737da97),
                                             width: 60,
                                             height: 20,
                                             child: Center(
                                               child: Text(
                                                 '${cubit.acceptedRequests[index].status}',
                                                 style: const TextStyle(
                                                   fontSize: 10,
                                                 ),
                                               ).tr(),
                                             ),
                                           ),
                                         ),
                                         cubit.acceptedRequests[index].status != 'finished'?
                                         Padding(
                                           padding: const EdgeInsetsDirectional.only(
                                             bottom: 15,
                                           ),
                                           child: SizedBox(
                                             width: width,
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment.end,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 ConditionalBuilder(
                                                   condition: state is! VolunteerFinishRequestsLoading,
                                                   builder: (context) =>
                                                       Container(
                                                         decoration: BoxDecoration(
                                                           color: const Color(
                                                               0xf737da97),
                                                           borderRadius: BorderRadiusDirectional
                                                               .circular(27),
                                                         ),
                                                         child: defaultButton(
                                                           function: () {
                                                             cubit.volunteerFinishRequest(cubit.acceptedRequests[index].id);
                                                           },
                                                           width: MediaQuery
                                                               .of(context)
                                                               .size
                                                               .width * 0.4,
                                                           height: MediaQuery
                                                               .of(context)
                                                               .size
                                                               .height * 0.07,
                                                           text: 'Finish trip'.tr(),
                                                         ),
                                                       ),
                                                   fallback: (context) =>
                                                   const Center(
                                                       child: CircularProgressIndicator()),
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ):
                                         Padding(
                                           padding: const EdgeInsetsDirectional.only(
                                             bottom: 15,
                                           ),
                                           child: SizedBox(
                                             width: width,
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment.end,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children:  [
                                                 Container(
                                                   width: 60,
                                                   height: 50,
                                                   decoration: const BoxDecoration(
                                                     color: Color(0xe537da97),
                                                     shape: BoxShape.circle,
                                                   ),
                                                   child: const Icon(
                                                     Icons.done,
                                                     size: 40,
                                                     color: Colors.white,
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
                           ),
                       separatorBuilder: (context, index) =>
                       const SizedBox(
                         height: 5,
                       ),
                       itemCount: cubit.acceptedRequests.length,
                     ),
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
