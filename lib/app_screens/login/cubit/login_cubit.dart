import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/login_model.dart';
import 'package:graduation_project/shared/network/end_points.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  int? status ;
  int? logoutStatus ;
  var token;
  var role;

  LoginModel? loginModel ;
  void userLogin({
  required String email,
  required String password,
}) {
    emit(LoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
      data: {
          'email':email,
          'password':password,
        },
    ).then((value) {
      status=value.statusCode;
      loginModel = LoginModel.fromJson(value.data);
      if (status==200){
        token = loginModel!.data.token;
        role = loginModel!.data.role;
      }
      emit(LoginSuccessState(loginModel!));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }

  void userLogout() {
    emit(LogoutLoadingState());

    DioHelper.postData(
      url: 'auth/logout',
      token: CashHelper.getData(key: 'token'),
    ).then((value) {
      logoutStatus=value.statusCode;
      print(logoutStatus);
      print(CashHelper.getData(key: 'token'));
      print(value.data);
      emit(LogoutSuccessState());
    }).catchError((error){
      print(error);
      emit(LogoutErrorState(error.toString()));
    });
  }

  void updateFcm(fcmToken){

    DioHelper.patchData(
        url: 'update-token',token: CashHelper.getData(key: 'token'),
      query: {
          'token':fcmToken,
      }
    ).then((value) {
      print(value.statusCode);
      print('test');
      print(value);
    });

  }

}
