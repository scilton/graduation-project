import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/app_screens/centers_screens/center_layout/layout_screens/home/center_home.dart';
import 'package:graduation_project/app_screens/centers_screens/center_layout/layout_screens/notifications/center_notifications.dart';
import 'package:graduation_project/app_screens/centers_screens/center_layout/layout_screens/settings/center_settings.dart';
import 'package:graduation_project/models/get_all_center_model.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';

import '../../../../models/notification_model.dart';
import 'center_states.dart';

class Test
{
 static bool newN=false;

}

class CenterAppCubit extends Cubit<CenterAppStates> {
  CenterAppCubit() : super(CenterAppInitialState());


  static CenterAppCubit get(context) => BlocProvider.of(context);
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
    const CenterHome(),
    const CenterNotifications(),
    const CenterSettings(),
  ];

  List<String> navBar= [
    'store',
  ];

  void changeItems(int index) {
    currentIndex = index;
    emit(CenterChangeBottomNavBar());
  }

  void changeNavBar(int index) {
    navBarIndex = index;
    emit(CenterChangeNavBar());
  }

  // File? profileImage;
  // var picker =ImagePicker();
  //
  // Future<void> getImage() async{
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile!=null){
  //     profileImage=File(pickedFile.path);
  //     emit(CenterProfileImagePicker());
  //   }
  // }

  var centers=[];
  GetAllCentersModel? getAllCentersModel ;

  void getCenters(){

    emit(CenterGetCenterLoading());

    DioHelper.getData(
      url: 'center/get-centers',
      token: CashHelper.getData(key: 'token'),
    ).then((value) {
      print(value);
      getAllCentersModel = GetAllCentersModel.fromJson(value.data);
      if (value.statusCode==200){
        centers=getAllCentersModel!.data!;
      }
      emit(CenterGetCenterSuccess());
    }).catchError((error){
      emit(CenterGetCenterError(error.toString()));
    });

  }



  NotificationModel? notificationModel;
  var notifications=[];
  void getNotification (){

    emit(CenterGetNotificationsLoading());
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
        print(notifications[0].data.content);
      }
      emit(CenterGetNotificationsSuccess());
    }).catchError((error){
      emit(CenterGetNotificationsError(error));
    });

  }

}
