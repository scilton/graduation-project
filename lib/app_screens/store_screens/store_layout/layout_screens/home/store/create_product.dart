import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/layout_screens/home/store/my_store_info_and_products.dart';
import 'package:graduation_project/shared/components/components.dart';

import 'store_cubit.dart';
class CreateProduct extends StatelessWidget {
  CreateProduct({Key? key,required this.StoreID,required this.index}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var productNameController = TextEditingController();
  var productPriceController = TextEditingController();
  var productInfoController = TextEditingController();
  int StoreID;
  int index;

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
          if (status==200)
            {
              showToast('Product created successfully'.tr(),
                context: context,
                animation: StyledToastAnimation.scale,
                duration: const Duration(seconds: 5),
                backgroundColor: const Color(0xff6bc17a),
                borderRadius: BorderRadius.circular(50),
                alignment: Alignment.bottomCenter,
              );
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyStoreInfo(index: index,storeId: StoreID,)), (route) => false);
            };

        },
        builder: (context, state) {
          var cubit = StoreCubit.get(context);

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
                      .height * .53,
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
                  padding: EdgeInsetsDirectional.only(
                    top: height * .25,
                  ),
                  child: Container(
                    width: width,
                    height: height * .75,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: height * .08,
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
                                      return 'Product name must be not empty'.tr();
                                    }
                                  },
                                  controller: productNameController,
                                  type: TextInputType.text,
                                  label: 'Product name'.tr(),
                                  width: width * .75,
                                  onTap: (){
                                    print(index);
                                  }
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  validate: (value){
                                    if (value!.isEmpty){
                                      return 'Product price must be not empty'.tr();
                                    };
                                  },
                                  controller: productPriceController,
                                  type: TextInputType.text,
                                  label: 'Product price'.tr(),
                                  width: width * .75,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  circular: 5,
                                  maxLines: 3,
                                  validate: (value){
                                    if (value!.isEmpty){
                                      return 'Product information must be not empty'.tr();
                                    }
                                  },
                                  controller: productInfoController,
                                  type: TextInputType.text,
                                  label: 'Product description'.tr(),
                                  width: width * .75,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: (){
                                    cubit.getImage();
                                  },
                                  child: defaultFormField(
                                    enabled: false,
                                    prefixIcon: Icons.add_a_photo,
                                    type: TextInputType.text,
                                    label: cubit.image.toString()=='null' ? 'Upload image':cubit.image.toString(),
                                    width: width * .75,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ConditionalBuilder(
                                      condition: state is! productLoading,
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
                                                  cubit.CreateProduct(
                                                      name: productNameController.text,
                                                      price: double.parse(productPriceController.text),
                                                       info: productInfoController.text,
                                                      id: StoreID,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
