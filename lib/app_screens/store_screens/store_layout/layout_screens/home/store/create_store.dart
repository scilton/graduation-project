import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/store_home_layout.dart';
import 'package:graduation_project/shared/components/components.dart';

import 'store_cubit.dart';

class CreateStore extends StatefulWidget {
  CreateStore({Key? key}) : super(key: key);

  @override
  State<CreateStore> createState() => _CreateStoreState();
}

class _CreateStoreState extends State<CreateStore> {
  var formKey = GlobalKey<FormState>();

  var storeNameController = TextEditingController();

  var storeAddressController = TextEditingController();

  var storePhoneController = TextEditingController();

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
      create: (context) => StoreCubit(),
      child: BlocConsumer<StoreCubit, StoreState>(
        listener: (context, state) {
          var cubit = StoreCubit.get(context);
          var status = cubit.status;
          if (status==200) {
            showToast('your store has been created'.tr(),
              context: context,
              animation: StyledToastAnimation.scale,
              duration: const Duration(seconds: 5),
              backgroundColor: const Color(0xff6bc17a),
              borderRadius: BorderRadius.circular(50),
              alignment: Alignment.bottomCenter,
            );
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const StoreHomeLayout()), (route) => false);
          }
        },
        builder: (context, state) {
          var cubit = StoreCubit.get(context);
          late File? image = cubit.image;
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
                                      return 'Store name must be not empty'.tr();
                                    }
                                  },
                                  controller: storeNameController,
                                  type: TextInputType.text,
                                  label: 'Store name'.tr(),
                                  width: width * .75,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultFormField(
                                  validate: (value){
                                    if (value!.isEmpty){
                                      return 'phone must be not empty'.tr();
                                    }
                                  },
                                  controller: storePhoneController ,
                                  type: TextInputType.text,
                                  label: 'phone'.tr(),
                                  width: width * .75,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultFormField(

                                  controller: storeAddressController,
                                  type: TextInputType.text,
                                  label: 'Address'.tr(),
                                  width: width * .75,
                                  validate: (value){
                                    if(value!.isEmpty){
                                      return 'Store address must be not empty'.tr();
                                    }
                                  }
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ConditionalBuilder(
                                      condition: state is! StoreLoading,
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
                                                  cubit.CreateStore(
                                                    name: storeNameController.text,
                                                    address: storeAddressController.text,
                                                    phone: storePhoneController.text,
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
                    top:height*.24 ,
                    end:width*.05 ,
                    start: width*.08,
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
                              if(cubit.image.toString()=='null'){
                                return 'Center image is required'.tr();
                              }
                            },
                            enabled: false,
                            label: cubit.image.toString()=='null'?'Image path':cubit.image.toString(),
                          ),
                        ),
                        const Spacer(),
                         Text(
                          image.toString()=='null'?'Upload image'.tr():'Change photo'.tr(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
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
