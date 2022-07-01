import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/layout_screens/home/store_home.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/layout_screens/notifications/store_notifications.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/layout_screens/settings/store_settings.dart';
import 'package:graduation_project/models/get_all_stores_model.dart';
import 'package:graduation_project/models/get_product_model.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';

import '../../../../models/notification_model.dart';
import 'store_states.dart';

class StoreAppCubit extends Cubit<StoreAppStates> {
  StoreAppCubit() : super(StoreAppInitialState());

  static StoreAppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  int navBarIndex = 0;

  List<BottomNavigationBarItem> BottomItems = [
     BottomNavigationBarItem(
      label: 'Home'.tr(),
      icon: const Icon(
        Icons.home,
      ),
    ),
     BottomNavigationBarItem(
      label: 'Notifications'.tr(),
      icon: const Icon(
        Icons.notifications,
      ),
    ),
     BottomNavigationBarItem(
      label: 'Settings'.tr(),
      icon: const Icon(
        Icons.settings,
      ),
    ),
  ];

  List<Widget> screens = [
    const StoreHome(),
    const StoreNotifications(),
    const StoreSettings(),
  ];

  List<String> navBar= [
    'store',
  ];

  void changeItems(int index) {
    currentIndex = index;
    emit(StoreChangeBottomNavBar());
  }

  void changeNavBar(int index) {
    navBarIndex = index;
    emit(StoreChangeNavBar());
  }

  // File? profileImage;
  // var picker =ImagePicker();
  //
  // Future<void> getImage() async{
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile!=null){
  //     profileImage=File(pickedFile.path);
  //     emit(StoreProfileImagePicker());
  //   }
  // }


  int? storeStatus;
  var stores=[];
  GetAllStoresModel? getAllStoresModel ;

  void getStores(){

    emit(StoreGetStoreLoading());

    DioHelper.getData(
      url: 'store/get-all-stores',
      token: CashHelper.getData(key: 'token'),
    ).then((value) {
      storeStatus=value.statusCode;
      print(storeStatus);
      print(value);
      getAllStoresModel = GetAllStoresModel.fromJson(value.data);

      if (storeStatus==200){
        stores = getAllStoresModel!.data!;
        print(stores.length);
        print(stores[0].name);

      }
      emit(StoreGetStoreSuccess());
    }).catchError((error){
      emit(StoreGetStoreError(error.toString()));
    });

  }

  GetProductModel? getProductModel;
  var products=[];
  void getProducts(
    {
      required int storeId,
    }
      ){

    emit(getProductLoading());

    DioHelper.getData(
      url: 'product/get-products',
      token: CashHelper.getData(key: 'token'),
      query: {
        'store_id':storeId,
      }
    ).then((value) {
      print(value.statusCode);
      print(value);
      getProductModel = GetProductModel.fromJson(value.data);

      if (value.statusCode ==200){
        products = getProductModel!.data!;
        print(products.length);
        print(products[0].name);

      }
      emit(getProductSuccess());
    }).catchError((error){
      emit(getProductError(error.toString()));
    });

  }

  int? deleteStatus;
  void deleteProduct(productId){
  emit(deleteProductLoading());
    DioHelper.deleteData(
        url: 'product/product-delete',
      token: CashHelper.getData(key: 'token'),
      query: {
          'id':productId,
      }
    ).then((value) {
      deleteStatus=value.statusCode;
      print(value);
      emit(deleteProductSuccess());
    }).catchError((error){emit(deleteProductError(error));});
  }



 int? updatePriceStatus;
  void updateProductPrice({
    required productId,
    required productPrice,
  }){
    emit(updateProductPriceLoading());
    DioHelper.putData(
        url: 'product/product-update',
        token: CashHelper.getData(key: 'token'),
        query: {
          'id':productId,
          'price':productPrice,
        }
    ).then((value) {
      print(value);
      updatePriceStatus=value.statusCode;
      emit(updateProductPriceSuccess());
    }).catchError((error){
      emit(updateProductPriceError(error));
    });
  }


  NotificationModel? notificationModel;
  var notifications=[];
  void getNotification (){

    emit(GetNotificationsLoading());

    DioHelper.getData(
      url: 'get-user-notifications',
      token: CashHelper.getData(key: 'token'),
    ).then((value) {
      print(value.statusCode);
      print(value);
      if (value.statusCode==200)
      {
        notificationModel = NotificationModel.fromJson(value.data);
        notifications = notificationModel!.data!;
      }
      emit(GetNotificationsSuccess());
    }).catchError((error){
      emit(GetNotificationsError(error));
    });

  }

}
