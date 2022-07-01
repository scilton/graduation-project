import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/cubit/store_states.dart';
import 'package:graduation_project/shared/components/components.dart';

import '../../../cubit/store_cubit.dart';
import 'my_store_info_and_products.dart';

class StoreChangeProductPrice extends StatelessWidget {
   StoreChangeProductPrice({Key? key,required this.index,required this.storeId}) : super(key: key);

  int index;
  int storeId;
   var newPriceController = TextEditingController();

   @override
  Widget build(BuildContext context) {


    return BlocProvider(
  create: (context) => StoreAppCubit()..getProducts(storeId: storeId),
  child: BlocConsumer<StoreAppCubit, StoreAppStates>(
  listener: (context, state) {
    var cubit=StoreAppCubit.get(context);

    if (cubit.updatePriceStatus==200)
      {
        showToast('Price Updated'.tr(),
          context: context,
          animation: StyledToastAnimation.scale,
          duration: const Duration(seconds: 5),
          backgroundColor: const Color(0xff6bc17a),
          borderRadius: BorderRadius.circular(50),
          alignment: Alignment.bottomCenter,
        );
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) =>  MyStoreInfo(index: 0,storeId: storeId,)), (route) => false);
      }
  },
  builder: (context, state) {
    var cubit=StoreAppCubit.get(context);
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Scaffold(
    body: ConditionalBuilder(
      condition: state is! getProductLoading,
      builder: (context)=>Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background2.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width*.8,
                height: height*.25,
                child: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    '${cubit.products[index].image}',
                  ),
                ),
              ),
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsetsDirectional.only(
                      start: width*.1,
                    ),
                    child: Text(
                      '${cubit.products[index].name}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsetsDirectional.only(
                      start: width*.1,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${cubit.products[index].price}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                        const Text(
                          ' EGP',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,

                          ),
                        ).tr(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    defaultFormField(controller: newPriceController ,type: TextInputType.number, label: 'New price'.tr()),
                    const SizedBox(height: 10,),
                    ConditionalBuilder(
                      condition: state is! updateProductPriceLoading,
                      builder: (context)=>defaultButton(
                        function: (){
                          cubit.updateProductPrice(
                            productId: cubit.products[index].id,
                            productPrice: newPriceController.text,
                          );
                        },
                        text: 'Save'.tr(),
                        width: width*.3,
                        height: 40,
                        radius: 10,
                      ),
                      fallback: (context)=>const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      fallback: (context)=>const Center(child: CircularProgressIndicator()),
    ),
  );
  },
),
);
  }
}
