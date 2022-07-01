import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';

import 'center_change_password_states.dart';



class CenterChangePasswordCubit extends Cubit<CenterChangePasswordStates> {
 CenterChangePasswordCubit() : super(CenterChangeInitialState());
  static CenterChangePasswordCubit get(context) => BlocProvider.of(context);
  int? status ;
  void userChangePassword({
    required String password,
    required String new_password,
    required String new_password_confirmation,

  }) {
    emit(CenterChangeLoadingState());
    DioHelper.postData(
      url: 'auth/change-password',
      token: CashHelper.getData(key: 'token'),
      data: {
        'password':password,
        'new_password':new_password,
        'new_password_confirmation':new_password_confirmation,
      },
    ).then((value) {
      status=value.statusCode;
      print(status);
      print(CashHelper.getData(key: 'token'));
      print(value);
      emit(CenterChangeSuccessState());
    }).catchError((error){
      print(error);
      emit(CenterChangePasswordErrorState(error.toString()));
    });
  }

}
