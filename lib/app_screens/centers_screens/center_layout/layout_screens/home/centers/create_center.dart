
import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/app_screens/centers_screens/center_layout/center_home_layout.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'centers_cubit.dart';
import 'centers_state.dart';

class CreateCenter extends StatelessWidget {
  CreateCenter({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  var centerNameController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var aboutController = TextEditingController();
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
      create: (context) => CentersCubit(),
      child: BlocConsumer<CentersCubit, CentersState>(
        listener: (context, state) {
          var cubit = CentersCubit.get(context);
          var status = cubit.status;
          if (status==200)
            {
              showToast('your center has been created'.tr(),
                context: context,
                animation: StyledToastAnimation.scale,
                duration: const Duration(seconds: 5),
                backgroundColor: const Color(0xff6bc17a),
                borderRadius: BorderRadius.circular(50),
                alignment: Alignment.bottomCenter,
              );
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>CenterHomeLayout()), (route) => false);
            }else if (status==500){
            showToast('Duplicate Information, you can create only one center'.tr(),
              context: context,
              animation: StyledToastAnimation.scale,
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(50),
              alignment: Alignment.bottomCenter,
            );
            Navigator.pop(context);
          }


        },
        builder: (context, state) {
          var cubit = CentersCubit.get(context);
          late File? image = cubit.profileImage;
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .36,
                  // decoration:  const BoxDecoration(
                  //   image: DecorationImage(
                  //     fit: BoxFit.fill,
                  //     image:AssetImage('assets/images/background2.jpg'),
                  //   ),
                  // ),
                  child: (image!=null)?Image.file(image,fit: BoxFit.fill,):Image.asset('assets/images/background2.jpg',fit: BoxFit.fill,),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: height * .30,
                  ),
                  child: Container(
                    width: width,
                    height: height * .70,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: height * .05,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * .12,
                        ),
                        child: SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultFormField(
                                  validate: (value){
                                    if (value!.isEmpty){
                                      return 'Center name must be not empty'.tr();
                                    }
                                  },
                                  controller: centerNameController,
                                  type: TextInputType.text,
                                  label: 'center name'.tr(),
                                  width: width * .75,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultFormField(
                                  controller: addressController,
                                  type: TextInputType.text,
                                  label: 'Address'.tr(),
                                  width: width * .75,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultFormField(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  label: 'Mobile Number'.tr(),
                                  width: width * .75,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                 Text(
                                  'About'.tr(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultFormField(
                                  validate: (value){
                                    if (value!.isEmpty){
                                      return 'Enter your center details'.tr();
                                    }
                                  },
                                  label: '',
                                  circular: 0,
                                  maxLines: 3,
                                  controller: aboutController,
                                  type: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ConditionalBuilder(
                                      condition: state is! CentersLoading,
                                      builder: (context) =>
                                          Container(
                                            decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                                borderRadius: BorderRadiusDirectional
                                                    .circular(27),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/background2.jpg'),
                                                    fit: BoxFit.cover)
                                            ),
                                            child: defaultButton(
                                              function: () {
                                                if(formKey.currentState!.validate())
                                                {
                                                  cubit.CreateCenter(
                                                      name: centerNameController.text,
                                                      about: aboutController.text,
                                                    phone: phoneController.text,
                                                    address: addressController.text,
                                                  );
                                                }
                                              },
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.4,
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.07,
                                              text: 'Create'.tr(),
                                            ),
                                          ),
                                      fallback: (context) =>
                                      const Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top:height*.2 ,
                    end:width*.05 ,
                    bottom: height*.08,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      cubit.getImage();
                      },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                      SizedBox(
                        width: width*.6,
                        height: height*.05,
                        child:   noBorderFormField(
                          Validate: (value){
                            if(cubit.profileImage.toString()=='null'){
                              return 'Center image is required'.tr();
                            }
                          },
                          enabled: false,
                          label: cubit.profileImage.toString()=='null'?'Image path':cubit.profileImage.toString(),
                        ),
                      ),
                        const Spacer(),
                        const Text(
                          'Upload photo',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ).tr(),
                        const SizedBox(width: 3,),
                        const Icon(Icons.add_a_photo,color: Colors.black,),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
