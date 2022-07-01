import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/app_screens/volunteer_screens/volunteer_layout/cubit/volunteer_states.dart';
import 'package:graduation_project/app_screens/volunteer_screens/volunteer_layout/layout_screens/volunteer_home/volunteer_home.dart';
import 'package:graduation_project/app_screens/volunteer_screens/volunteer_layout/layout_screens/volunteer_notifications/volunteer_notifications.dart';
import 'package:graduation_project/app_screens/volunteer_screens/volunteer_layout/layout_screens/volunteer_settings/volunteer_settings.dart';
import 'package:graduation_project/models/get_user_requests_model.dart';
import 'package:graduation_project/models/get_volunteer_accepted_requests.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';

import '../../../../models/notification_model.dart';

class VolunteerAppCubit extends Cubit<VolunteerAppStates> {
  VolunteerAppCubit() : super(VolunteerAppInitialState());

  static VolunteerAppCubit get(context) => BlocProvider.of(context);
  int navBarIndex = 0;
  int volunteerNavBarIndex = 0;
  int currentIndex = 0;


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
    const VolunteerHome(),
    const VolunteerNotifications(),
    const VolunteerSettings(),
  ];



  void changeNavBar(int index) {
    navBarIndex = index;
    emit(VolunteerChangeNavBar());
  }

  void changeVolunteerNavBar(int index) {
    volunteerNavBarIndex = index;
    emit(VolunteerChangeVolunteerNavBar());
  }

  void changeItems(int index) {
    currentIndex = index;
    emit(VolunteerChangeBottomNavBar());
  }


  GetUserRequestsModel? getUserRequestsModel;
  var requests=[];

  void getUserRequests (){

    emit(VolunteerGetUserRequestsLoading());

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
      emit(VolunteerGetUserRequestsSuccess());

    }).catchError((error){
      emit(VolunteerGetUserRequestsError(error));
    });
  }

  int? acceptStatus;
  void volunteerAcceptRequest (requestID){

    emit(VolunteerAcceptRequestsLoading());

    DioHelper.postData(
        url: 'volunteer/accept-user-request',
      token: CashHelper.getData(key: 'token'),
      data: {
          'request_id':requestID,
      }
    ).then((value) {
      acceptStatus=value.statusCode!;
      print(acceptStatus);
      print(value);
      emit(VolunteerAcceptRequestsSuccess());
    }).catchError((error){
      emit(VolunteerAcceptRequestsError(error));
    });
  }

  GetVolunteerAcceptedRequests? getVolunteerAcceptedRequests;
  var acceptedRequests=[];
  void getAcceptedRequest (){

    emit(VolunteerGetAcceptedRequestsLoading());

    DioHelper.getData(
        url: 'volunteer/get-my-trip',
        token: CashHelper.getData(key: 'token'),
    ).then((value) {
      print(value.statusCode);
      print(value);
      getVolunteerAcceptedRequests = GetVolunteerAcceptedRequests.fromJson(value.data);
      acceptedRequests= getVolunteerAcceptedRequests!.data!;
      emit(VolunteerGetAcceptedRequestsSuccess());
    }).catchError((error){
      emit(VolunteerGetAcceptedRequestsError(error));
    });
  }

  int? finishStatus;
  void volunteerFinishRequest (requestID){

    emit(VolunteerFinishRequestsLoading());

    DioHelper.postData(
        url: 'end-volunteering',
        token: CashHelper.getData(key: 'token'),
        data: {
          'request_id':requestID,
        }
    ).then((value) {
      finishStatus=value.statusCode!;
      print(finishStatus);
      print(value);
      emit(VolunteerFinishRequestsSuccess());
    }).catchError((error){
      emit(VolunteerFinishRequestsError(error));
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
