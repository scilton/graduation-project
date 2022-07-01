import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/cubit/user_cubit.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/cubit/user_states.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/user_home_layout.dart';
import 'package:intl/intl.dart';

class UserMakeVolunteerRequest extends StatefulWidget {
   UserMakeVolunteerRequest({Key? key}) : super(key: key);

  @override
  State<UserMakeVolunteerRequest> createState() => _UserMakeVolunteerRequestState();
}

class _UserMakeVolunteerRequestState extends State<UserMakeVolunteerRequest> {
  var dateController = TextEditingController();
  String volunteerType='Volunteer Type'.tr();
  String from='nothing';
  String to='nothing';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
  create: (context) => UserAppCubit(),
  child: BlocConsumer<UserAppCubit, UserAppStates>(
  listener: (context, state) {
    var cubit = UserAppCubit.get(context);
    if(cubit.makeRequestStatus==200)
      {
        showToast(
          'Request was successfully created'.tr(),
          context: context,
          animation: StyledToastAnimation.scale,
          duration: const Duration(seconds: 5),
          backgroundColor: const Color(0xff6bc17a),
          borderRadius: BorderRadius.circular(50),
          alignment: Alignment.bottomCenter,
        );
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const UserHomeLayout()), (route) => false);
      }
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = UserAppCubit.get(context);

    return Scaffold(
      body: SingleChildScrollView(
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
                          DropdownButton<String>(
                            hint: Text(
                              volunteerType,
                              style: const TextStyle(
                                  fontWeight: FontWeight
                                      .bold,
                                  color: Colors.black),
                            ),
                            items: <String>[
                              'Sitter'.tr(),
                              'Driver'.tr(),
                            ].map((String value) {
                              return DropdownMenuItem<
                                  String>(
                                value: value,
                                child: Text(value).tr(),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                value=='جليس'?
                                volunteerType ='sitter':
                                    value=='سائق'?
                                        volunteerType = 'driver'
                                        :
                                volunteerType =
                                    value!.toLowerCase();
                                print(volunteerType);
                              });
                            },
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
                            height: 20,
                          ),
                          volunteerType=='driver'? Column(
                            children: [
                              TextFormField(
                                onChanged: (value){
                                  from=value;
                                } ,
                                decoration:
                                 InputDecoration(
                                  labelText:
                                  'From'.tr(),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onChanged: (value){
                                  to=value;
                                } ,
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
                                  'To'.tr(),
                                ),
                              ),
                            ],
                          ):const SizedBox(width: 1,),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 50,
                            width: width*.5,
                            child:
                            ConditionalBuilder(
                              condition: state
                              is! UserMakeVolunteerRequestsLoading,
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
                                      volunteerType=='driver'?
                                   cubit.userMakeVolunteerRequest(
                                       volunteerType: volunteerType,
                                       date: dateController.text,
                                     from: from,
                                     to: to,
                                   ):cubit.userMakeVolunteerRequest(
                                        volunteerType: volunteerType,
                                        date: dateController.text,
                                        from: from,
                                        to: to,
                                      );
                                    },
                                    child:
                                    const Text(
                                      "Make request",
                                      style: TextStyle(
                                          fontSize:
                                          20,
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
    );
  },
),
);
  }
}
