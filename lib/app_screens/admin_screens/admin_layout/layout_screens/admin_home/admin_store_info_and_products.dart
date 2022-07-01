import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' '';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/app_screens/admin_screens/admin_layout/cubit/admin_cubit.dart';
import 'package:graduation_project/app_screens/admin_screens/admin_layout/cubit/admin_states.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../admin_home_layout.dart';

class AdminStoreInfo extends StatefulWidget {
  int index;
  int storeId;
  String status;

  AdminStoreInfo({required this.index,required this.status,required this.storeId});

  @override
  State<AdminStoreInfo> createState() => _AdminStoreInfoState();
}

class _AdminStoreInfoState extends State<AdminStoreInfo> {
  bool c3 = false;
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminAppCubit()..getAcceptedStores()..getProducts(storeId: widget.storeId)..getPendingStores(),
        )
      ],
      child: BlocConsumer<AdminAppCubit, AdminAppStates>(
        listener: (context, state) {
          var cubit = AdminAppCubit.get(context);
          if (cubit.approveStoreStatus == 200) {
            showToast(
              'Store approved'.tr(),
              context: context,
              animation: StyledToastAnimation.scale,
              duration: const Duration(seconds: 5),
              backgroundColor: const Color(0xff6bc17a),
              borderRadius: BorderRadius.circular(50),
              alignment: Alignment.bottomCenter,
            );
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const AdminHomeLayout()), (route) => false);
          }

          if (cubit.rejectStoreStatus == 200) {
            showToast(
              'Store rejected'.tr(),
              context: context,
              animation: StyledToastAnimation.scale,
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(50),
              alignment: Alignment.bottomCenter,
            );
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const AdminHomeLayout()), (route) => false);
          }

          if(cubit.deleteStatus==200)
          {
            showToast('Product deleted successfully'.tr(),
              context: context,
              animation: StyledToastAnimation.scale,
              duration: const Duration(seconds: 5),
              backgroundColor: const Color(0xff6bc17a),
              borderRadius: BorderRadius.circular(50),
              alignment: Alignment.bottomCenter,
            );
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) =>  AdminStoreInfo(index: widget.index, status: widget.status,storeId: widget.storeId,)), (route) => false);
          }

          // TODO: implement listener
        },
        builder: (context, state) {
          bool c1 = state is! AdminGetAcceptedStoreLoading;
          bool c4 = state is! AdminGetPendingStoreLoading;
          bool c2 = state is! AdminGetProductsLoading;
          var cubit = AdminAppCubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
              condition: c1 & c2 & c4,
              builder: (context) =>widget.status=='accepted' ?Stack(
                children: [
                  Container(
                    height: height * .36,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('${cubit.acceptedStores[widget.index].image}'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: height * .32,
                      ),
                      child: Container(
                        height: height * .71,
                        width: width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 25,
                            start: 20,
                            end: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: width*.7,
                                    child: Text(
                                      '${cubit.acceptedStores[widget.index].name}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_call),
                                    onPressed: () =>launch('tel:${cubit.acceptedStores[widget.index].phoneNumber}'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                               SizedBox(
                                 width: width*.7,
                                 child: Text(
                                  '${cubit.acceptedStores[widget.index].address}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                              ),
                               ),
                              const SizedBox(
                                height: 10,
                              ),
                               Text(
                                '${cubit.acceptedStores[widget.index].phoneNumber}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Visibility(
                                visible: c3 ,
                                replacement: Visibility(
                                  visible: isVisible,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      top: height * .15,
                                    ),
                                    child: Center(
                                      child: defaultButton(
                                        width: width * .4,
                                        radius: 0,
                                        backgroundColor:
                                        const Color(0xf737da97),
                                        function: () {
                                          setState(() {
                                            c3 = !c3;
                                            isVisible = !isVisible;
                                            print(widget.index);
                                          });
                                        },
                                        text: 'Show Products'.tr(),
                                        fontSize: 14,
                                        height: height * .07,
                                      ),
                                    ),
                                  ),
                                ),
                                child: Expanded(
                                  child: ConditionalBuilder(
                                    condition:c2 ,
                                    builder: (context)=>SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Products',
                                            style: TextStyle(
                                              color: Color(0xff25258f),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0,
                                            ),
                                          ).tr(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GridView.count(
                                            mainAxisSpacing: 2.0,
                                            crossAxisSpacing: 10.0,
                                            childAspectRatio: 1/1,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            crossAxisCount: 2,
                                            children: List.generate(
                                              cubit.products.length, (index) => Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children:  [
                                                GestureDetector(
                                                  onLongPress: (){
                                                    showMenu(
                                                      context: context,
                                                      position: RelativeRect.fromLTRB(width*.3, height*.65, width*.3, height*.35),
                                                      items: <PopupMenuEntry>[
                                                        PopupMenuItem(
                                                          value: 1,
                                                          onTap: (){
                                                            cubit.deleteProduct(cubit.products[index].id);
                                                          },
                                                          child: Row(
                                                            children:  <Widget>[
                                                              const Icon(Icons.delete),
                                                              const SizedBox(width: 5,),
                                                              const Text("Delete").tr(),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  onTap: (){
                                                    showOverlay(
                                                        context: context,
                                                        design: Material(
                                                          child: Container(
                                                            width: width,
                                                            height: height*.59,
                                                            decoration: const BoxDecoration(
                                                              image: DecorationImage(
                                                                image: AssetImage(
                                                                  'assets/images/background2.jpg',
                                                                ),
                                                                fit: BoxFit.fill,
                                                              ),
                                                              borderRadius: BorderRadius.vertical(
                                                                bottom: Radius.circular(40),
                                                              ),
                                                            ),
                                                            child: SingleChildScrollView(
                                                              physics: const BouncingScrollPhysics(),
                                                              child: Padding(
                                                                padding: const EdgeInsetsDirectional.only(
                                                                  top: 30,
                                                                ),
                                                                child: Column(
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
                                                                          Text(
                                                                            '${cubit.products[index].description}',
                                                                            style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.bold,

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
                                                        ),
                                                    );
                                                  },
                                                  child: SizedBox(
                                                    width: width*.4,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:  [
                                                        Image(
                                                          image: NetworkImage('${cubit.products[index].image}'),
                                                          height: 100,
                                                        ),
                                                        const SizedBox(height: 10,),
                                                        Text(
                                                          '${cubit.products[index].name}',

                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),

                                                        const SizedBox(width: 10,),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '${cubit.products[index].price}',
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.w900,
                                                                fontSize: 12,
                                                                color: Color(0xf737da97),
                                                              ),
                                                            ),
                                                            const Text(
                                                              ' EGP',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w900,
                                                                fontSize: 12,
                                                                color: Color(0xf737da97),
                                                              ),
                                                            ).tr(),
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
                                        ],
                                      ),
                                    ),
                                    fallback: (context)=>const Center(child: CircularProgressIndicator()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ):Stack(
                children: [
                  Container(
                    height: height * .36,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('${cubit.pendingStores[widget.index].image}'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: height * .32,
                      ),
                      child: Container(
                        height: height * .71,
                        width: width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 15,
                            start: 20,
                            end: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ConditionalBuilder(
                                    condition: state is! AdminRejectStoreLoading,
                                    builder: (context) => defaultButton(
                                      width: width * .25,
                                      radius: 0,
                                      backgroundColor:
                                      Colors.red,
                                      function: () {
                                        cubit.rejectStore(
                                          storeId: cubit.pendingStores[widget.index].id,
                                        );
                                      },
                                      text: 'Reject'.tr(),
                                      fontSize: 14,
                                      height: height*.07,
                                    ),
                                    fallback: (context) => const Center(
                                        child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child:
                                            CircularProgressIndicator())),
                                  ),
                                  SizedBox(width: width*.1,),
                                  ConditionalBuilder(
                                    condition: state is! AdminApproveStoreLoading,
                                    builder: (context) => defaultButton(
                                      width: width * .25,
                                      radius: 0,
                                      backgroundColor:
                                      const Color(0xf737da97),
                                      function: () {
                                        cubit.approveStore(
                                          storeId: cubit.pendingStores[widget.index].id,
                                        );
                                      },
                                      text: 'Accept'.tr(),
                                      fontSize: 14,
                                      height: height*.07,
                                    ),
                                    fallback: (context) => const Center(
                                        child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child:
                                            CircularProgressIndicator())),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: width*.7,
                                    child: Text(
                                      '${cubit.pendingStores[widget.index].name}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_call),
                                    onPressed: () =>launch('tel:${cubit.pendingStores[widget.index].phoneNumber}'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: width*.7,
                                child: Text(
                                  '${cubit.pendingStores[widget.index].address}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${cubit.pendingStores[widget.index].phoneNumber}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Products',
                                style: TextStyle(
                                  color: Color(0xff25258f),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ),
                              ).tr(),
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  top: height * .1,
                                ),
                                child:  Center(
                                  child:const Text(
                                    'No products yet \n because this store \n is still pending',
                                    style: TextStyle(
                                      color: Color(0xff727070),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ).tr() ,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
