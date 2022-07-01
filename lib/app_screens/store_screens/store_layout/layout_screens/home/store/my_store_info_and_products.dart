
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' '';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/cubit/store_cubit.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/cubit/store_states.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/layout_screens/home/store/change_product_price.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/layout_screens/home/store/create_product.dart';
import 'package:graduation_project/shared/components/components.dart';

class MyStoreInfo extends StatefulWidget {
  int index;
  int storeId;

  MyStoreInfo({Key? key, required this.index,required this.storeId}) : super(key: key);

  @override
  State<MyStoreInfo> createState() => _MyStoreInfoState();
}

class _MyStoreInfoState extends State<MyStoreInfo> {
  var popupItemKey=GlobalKey<PopupMenuItemState>();
  bool c3 = false;
  bool isVisible = true;
  var newPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => StoreAppCubit()
        ..getStores()
        ..getProducts(storeId: widget.storeId),
      child: BlocConsumer<StoreAppCubit, StoreAppStates>(
        listener: (context, state) {
          var cubit = StoreAppCubit.get(context);
          if(cubit.deleteStatus==200)
            {
              showToast('Product deleted'.tr(),
                context: context,
                animation: StyledToastAnimation.scale,
                duration: const Duration(seconds: 5),
                backgroundColor: const Color(0xff6bc17a),
                borderRadius: BorderRadius.circular(50),
                alignment: Alignment.bottomCenter,
              );
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) =>  MyStoreInfo(index: widget.index,storeId: widget.storeId,)), (route) => false);
            }
        },
        builder: (context, state) {
          bool c1 = state is! StoreGetStoreLoading;
          bool c2 = state is! getProductLoading;

          var cubit = StoreAppCubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
              condition: c1 & c2,
              builder: (context) => Stack(
                children: [
                  Container(
                    height: height * .36,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage('${cubit.stores[widget.index].image}'),
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
                      child: Stack(
                        children: [
                          Container(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: width * .7,
                                        child: Text(
                                          '${cubit.stores[widget.index].name}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 29.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: width * .7,
                                    child: Text(
                                      '${cubit.stores[widget.index].address}',
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
                                    '${cubit.stores[widget.index].phoneNumber}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Visibility(
                                    visible: c3,
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
                                      child: SingleChildScrollView(
                                        child: ConditionalBuilder(
                                          condition:
                                              state is! getProductLoading,
                                          builder: (context) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                childAspectRatio: 1 / 1,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                crossAxisCount: 2,
                                                children: List.generate(
                                                  cubit.products.length,
                                                  (index) => Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
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
                                                                    children: <Widget>[
                                                                      const Icon(Icons.delete),
                                                                      const SizedBox(width: 5,),
                                                                      const Text("Delete").tr(),
                                                                    ],
                                                                  ),
                                                                ),
                                                                PopupMenuItem(
                                                                  key: popupItemKey,
                                                                  value: 2,
                                                                  onTap: () async {
                                                                    final navigator = Navigator.of(context);
                                                                    await Future.delayed(Duration.zero);
                                                                    navigator.push(MaterialPageRoute(builder: (context)=>StoreChangeProductPrice(index: index,storeId: cubit.stores[widget.index].id,)));
                                                                  },
                                                                  child: Row(
                                                                    children:  <Widget>[
                                                                      const Icon(Icons.edit),
                                                                      const SizedBox(width: 5,),
                                                                      const Text("Edit price").tr(),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            useRootNavigator: true,
                                                          );
                                                        },
                                                        onTap: (){
                                                          showOverlay(
                                                            context: context,
                                                            design: Container(
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
                                                          );
                                                        },
                                                        child: SizedBox(
                                                          width: width * .4,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Image(
                                                                image: NetworkImage(
                                                                    '${cubit.products[index].image}'),
                                                                height: 100,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                '${cubit.products[index].name}',
                                                                style: const TextStyle(
                                                                    fontSize: 15,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '${cubit.products[index].price}',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      fontSize: 12,
                                                                      color: Color(
                                                                          0xf737da97),
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                    ' EGP',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      fontSize: 12,
                                                                      color: Color(
                                                                          0xf737da97),
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
                                          fallback: (context) =>
                                              const CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width,
                            height: height * .68,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateProduct(
                                                    StoreID: cubit
                                                        .stores[widget.index]
                                                        .id,
                                                    index: widget.index,
                                                  )));
                                    },
                                    backgroundColor: const Color(0xff1aa586),
                                    child: const Icon(
                                      Icons.add,
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


