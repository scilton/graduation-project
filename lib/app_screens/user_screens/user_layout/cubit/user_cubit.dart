import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/cubit/user_states.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/layout_screens/user_home/user_home.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/layout_screens/user_notifications/user_notifications.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/layout_screens/user_settings/user_settings.dart';
import 'package:graduation_project/models/get_all_center_model.dart';
import 'package:graduation_project/models/get_all_stores_model.dart';
import 'package:graduation_project/models/get_product_model.dart';
import 'package:graduation_project/models/get_user_data_model.dart';
import 'package:graduation_project/models/get_user_requests_model.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';

import '../../../../models/notification_model.dart';

class UserAppCubit extends Cubit<UserAppStates> {
  UserAppCubit() : super(AppInitialState());

  static UserAppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  int navBarIndex = 0;
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
    const UserHome(),
    const UserNotifications(),
    const UserSettings(),
  ];

  List<String> navBar= [
    'store',
    'stores',
    'helpers',
  ];

  void changeItems(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBar());
  }

  void changeNavBar(int index) {
    navBarIndex = index;
    emit(ChangeNavBar());
  }



  int? centerStatus;
  var centers=[];
  GetAllCentersModel? getAllCentersModel ;

  void getCenters(){

    emit(UserGetCenterLoading());

    DioHelper.getData(
      url: 'center/get-centers',
      token: CashHelper.getData(key: 'token'),
      query: {
        'state':'accepted',
      }
    ).then((value) {
      centerStatus=value.statusCode;
      print(centerStatus);
      print(value);
      getAllCentersModel = GetAllCentersModel.fromJson(value.data);

      if (centerStatus==200){
        centers = getAllCentersModel!.data!;
        print(centers.length);
        print(centers[0].rating);

      }
      emit(UserGetCenterSuccess());
    }).catchError((error){
      emit(UserGetCenterError(error.toString()));
    });

  }

  int? storeStatus;
  var stores=[];
  GetAllStoresModel? getAllStoresModel ;

  void getStores(){

    emit(UserGetStoreLoading());

    DioHelper.getData(
      url: 'store/get-all-stores',
      token: CashHelper.getData(key: 'token'),
      query: {
        'state':'accepted',
      }
    ).then((value) {
      storeStatus=value.statusCode;
      print(storeStatus);
      print(value);
      getAllStoresModel = GetAllStoresModel.fromJson(value.data);

      if (storeStatus==200){
        stores = getAllStoresModel!.data!;
        print(stores.length);

      }
      emit(UserGetStoreSuccess());
    }).catchError((error){
      emit(UserGetStoreError(error.toString()));
    });

  }


int? bookStatus;
  void CenterBooking ({
    required int centerId,
    required String caseName,
    required String mobile,
    required String bookingDate,
}){
print('object');
    emit(CenterBookingLoading());
    DioHelper.postData(
        url: 'center/center-booking',
      token: CashHelper.getData(key: 'token'),
      data: {
          'center_id':centerId,
          'case_name':caseName,
          'phone':mobile,
          'booking_date':bookingDate,
      }
    ).then((value) {
      print(value);
      if(value.statusCode==200){
        bookStatus=value.statusCode;
        print(value.data);
      }
      emit(CenterBookingsuccess());
    }).catchError((error){
      emit(CenterBookingError(error));
    });

  }

  int? rateStatus;
  void CenterRating ({
    required int centerId,
    required int rate,
  }){

    emit(CenterRatingLoading());
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
      emit(CenterRatingSuccess());
    }).catchError((error){
      emit(CenterRatingError(error));
    });

  }


  GetProductModel? getProductModel;
  var products=[];
  void getProducts({
  required int storeId,
}){

    emit(UserGetProductsLoading());

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
      emit(UserGetProductsSuccess());
    }).catchError((error){
      emit(UserGetProductsError(error.toString()));
    });

  }

  GetUserDataModel? getUserDataModel;
  var userData;
  void getUserData(){
    
    emit(GetUserDataLoading());
    
    DioHelper.getData(
        url: 'me',
      token: CashHelper.getData(key: 'token'),
    ).then((value) {
      print(value);
      if (value.statusCode==200)
        {
          getUserDataModel=value.data;
          userData= getUserDataModel;
        }
      emit(GetUserDataSuccess());
    }).catchError((error){
      emit(GetUserDataError(error));
    });
    
  }

  GetUserRequestsModel? getUserRequestsModel;
  var requests=[];

  void getUserRequests (){

    emit(GetUserRequestsLoading());

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
      emit(GetUserRequestsSuccess());

    }).catchError((error){
      emit(GetUserRequestsError(error));
    });
  }


  int? makeRequestStatus;
  void userMakeVolunteerRequest({
  required String volunteerType,
    required String date,
    String? from,
    String? to,
}){
    emit(UserMakeVolunteerRequestsLoading());

    DioHelper.postData(
        url: 'user/send-volunteer-request',
      token: CashHelper.getData(key: 'token'),
      data: {
          'volunteer_type':volunteerType,
          'date':date,
          'from':from,
          'to':to,
      }
    ).then((value) {
      print(value.statusCode);
      print(value);
      makeRequestStatus=value.statusCode;

      emit(UserMakeVolunteerRequestsSuccess());
    }).catchError((error){
      emit(UserMakeVolunteerRequestsError(error));
    });
  }


  NotificationModel? notificationModel;
  var notifications=[];
  void getNotification (){

    emit(GetUserNotificationsLoading());

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
      emit(GetUserNotificationsSuccess());
    }).catchError((error){
      emit(GetUserNotificationsError(error));
    });

  }


}
