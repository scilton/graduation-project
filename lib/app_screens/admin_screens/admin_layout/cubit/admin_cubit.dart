import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/app_screens/admin_screens/admin_layout/layout_screens/admin_home/admin_home.dart';
import 'package:graduation_project/app_screens/admin_screens/admin_layout/layout_screens/admin_notifications/admin_notifications.dart';
import 'package:graduation_project/app_screens/admin_screens/admin_layout/layout_screens/admin_settings/admin_settings.dart';
import 'package:graduation_project/models/get_all_center_model.dart';
import 'package:graduation_project/models/get_all_stores_model.dart';
import 'package:graduation_project/models/get_product_model.dart';
import 'package:graduation_project/models/get_user_requests_model.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';

import '../../../../models/notification_model.dart';
import 'admin_states.dart';

class AdminAppCubit extends Cubit<AdminAppStates> {
  AdminAppCubit() : super(AdminAppInitialState());

  static AdminAppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  int navBarIndex = 0;
  int pendingNavBarIndex = 0;
  int BookIndex = 0;

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
    const AdminHome(),
    const AdminNotifications(),
    const AdminSettings(),
  ];

  List<String> navBar= [
    'store',
    'stores',
    'helpers',
  ];

  void changeItems(int index) {
    currentIndex = index;
    emit(AdminChangeBottomNavBar());
  }

  void changeNavBar(int index) {
    navBarIndex = index;
    emit(AdminChangeNavBar());
  }

  void changePendingNavBar(int index) {
    pendingNavBarIndex = index;
    emit(AdminChangeNavBar());
  }



  int? centerStatus;
  var acceptedCenters=[];
  GetAllCentersModel? getAcceptedCentersModel ;

  void getAcceptedCenters(){

    emit(AdminGetAcceptedCenterLoading());

    DioHelper.getData(
      url: 'center/get-centers',
      token: CashHelper.getData(key: 'token'),
      query: {
        'state':'accepted',
      },

    ).then((value) {
      centerStatus=value.statusCode;
      print(centerStatus);
      print(value);
      getAcceptedCentersModel = GetAllCentersModel.fromJson(value.data);

      if (centerStatus==200){
        acceptedCenters = getAcceptedCentersModel!.data!;
        print(acceptedCenters.length);
        print(acceptedCenters[0].rating);

      }
      emit(AdminGetAcceptedCenterSuccess());
    }).catchError((error){
      emit(AdminGetAcceptedCenterError(error.toString()));
    });

  }

  int? storeStatus;
  var acceptedStores=[];
  GetAllStoresModel? getAcceptedStoresModel ;

  void getAcceptedStores(){

    emit(AdminGetAcceptedStoreLoading());

    DioHelper.getData(
      url: 'store/get-all-stores',
      token: CashHelper.getData(key: 'token'),
      query: {
        'state':'accepted'
      }
    ).then((value) {
      storeStatus=value.statusCode;
      print(storeStatus);
      print(value);
      getAcceptedStoresModel = GetAllStoresModel.fromJson(value.data);

      if (storeStatus==200){
        acceptedStores = getAcceptedStoresModel!.data!;
        print(acceptedStores.length);

      }
      emit(AdminGetAcceptedStoreSuccess());
    }).catchError((error){
      emit(AdminGetAcceptedStoreError(error.toString()));
    });

  }



  var pendingCenters=[];
  GetAllCentersModel? getPendingCentersModel ;

  void getPendingCenters(){

    emit(AdminGetPendingCenterLoading());

    DioHelper.getData(
      url: 'center/get-centers',
      token: CashHelper.getData(key: 'token'),
      query: {
        'state':'pending',
      },

    ).then((value) {
      centerStatus=value.statusCode;
      print(centerStatus);
      print(value);
      getPendingCentersModel = GetAllCentersModel.fromJson(value.data);

      if (centerStatus==200){
        pendingCenters = getPendingCentersModel!.data!;
        print(pendingCenters.length);
        print(pendingCenters[0].rating);

      }
      emit(AdminGetPendingCenterSuccess());
    }).catchError((error){
      emit(AdminGetPendingCenterError(error.toString()));
    });

  }

  var pendingStores=[];
  GetAllStoresModel? getPendingStoresModel ;

  void getPendingStores(){

    emit(AdminGetPendingStoreLoading());

    DioHelper.getData(
        url: 'store/get-all-stores',
        token: CashHelper.getData(key: 'token'),
        query: {
          'state':'pending'
        }
    ).then((value) {
      storeStatus=value.statusCode;
      print(storeStatus);
      print(value);
      getPendingStoresModel = GetAllStoresModel.fromJson(value.data);

      if (storeStatus==200){
        pendingStores = getPendingStoresModel!.data!;
        print(pendingStores.length);

      }
      emit(AdminGetPendingStoreSuccess());
    }).catchError((error){
      emit(AdminGetPendingStoreError(error.toString()));
    });

  }



  int? rateStatus;
  void CenterRating ({
    required int centerId,
    required int rate,
  }){

    emit(AdminRatingLoading());
    DioHelper.postData(
        url: 'center/center-evaluation',
        token: CashHelper.getData(key: 'token'),
        data: {
          'center_id':centerId,
          'rate':rate,
        }
    ).then((value) {
      if(value.statusCode==200){
        rateStatus =value.statusCode;
        print(value);
      }
      emit(AdminRatingSuccess());
    }).catchError((error){
      emit(AdminRatingError(error));
    });

  }


  GetProductModel? getProductModel;
  var products=[];
  void getProducts({
  required int storeId,
}){

    emit(AdminGetProductsLoading());

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
      emit(AdminGetProductsSuccess());
    }).catchError((error){
      emit(AdminGetProductsError(error.toString()));
    });

  }

  GetUserRequestsModel? getUserRequestsModel;
  var requests=[];

  void getUserRequests (){

    emit(AdminGetUserRequestsLoading());

    DioHelper.getData(
        url: 'volunteer/get-user-requests',
        token: CashHelper.getData(key: 'token'),
    ).then((value) {
      print(value);
      getUserRequestsModel = GetUserRequestsModel.fromJson(value.data);

      if(value.statusCode==200)
      {
        requests = getUserRequestsModel!.data!;
      }
      emit(AdminGetUserRequestsSuccess());

    }).catchError((error){
      emit(AdminGetUserRequestsError(error));
    });
  }


  int? approveCenterStatus;
  void approveCenter ({
  required int centerId,
}){

    emit(AdminApproveCenterLoading());
    DioHelper.postData(
        url: 'center/approve-center',
      token: CashHelper.getData(key: 'token'),
        data: {
          'status': true,
          'center_id': centerId,
    },
    ).then((value) {
      print(value.statusCode);
      approveCenterStatus=value.statusCode;
      print(value);
      emit(AdminApproveCenterSuccess());
    }).catchError((error){
      emit(AdminApproveCenterError(error));
    });

  }

  int? rejectCenterStatus;
  void rejectCenter ({
    required int centerId,
  }){

    emit(AdminRejectCenterLoading());
    DioHelper.postData(
      url: 'center/approve-center',
      token: CashHelper.getData(key: 'token'),
      data: {
        'status': false,
        'center_id': centerId,
      },
    ).then((value) {
      print(value.statusCode);
      rejectCenterStatus=value.statusCode;
      print(value);
      emit(AdminRejectCenterSuccess());
    }).catchError((error){
      emit(AdminRejectCenterError(error));
    });

  }


  int? approveStoreStatus;
  void approveStore ({
    required int storeId,
  }){

    emit(AdminApproveStoreLoading());
    DioHelper.postData(
      url: 'approve-store',
      token: CashHelper.getData(key: 'token'),
      data: {
        'status': true,
        'store_id': storeId,
      },
    ).then((value) {
      print(value.statusCode);
      approveStoreStatus=value.statusCode;
      print(value);
      emit(AdminApproveStoreSuccess());
    }).catchError((error){
      emit(AdminApproveStoreError(error));
    });

  }

  int? rejectStoreStatus;
  void rejectStore ({
    required int storeId,
  }){

    emit(AdminRejectStoreLoading());
    DioHelper.postData(
      url: 'approve-store',
      token: CashHelper.getData(key: 'token'),
      data: {
        'status': false,
        'store_id': storeId,
      },
    ).then((value) {
      print(value.statusCode);
      rejectStoreStatus=value.statusCode;
      print(value);
      emit(AdminRejectStoreSuccess());
    }).catchError((error){
      emit(AdminRejectStoreError(error));
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
