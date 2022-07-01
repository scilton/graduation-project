import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';

import 'store_change_password_states.dart';



class StoreChangePasswordCubit extends Cubit<StoreChangePasswordStates> {
 StoreChangePasswordCubit() : super(StoreChangeInitialState());
  static StoreChangePasswordCubit get(context) => BlocProvider.of(context);
  int? status ;
  void userChangePassword({
    required String password,
    required String new_password,
    required String new_password_confirmation,

  }) {
    emit(StoreChangeLoadingState());
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
      emit(StoreChangeSuccessState());
    }).catchError((error){
      print(error);
      emit(StoreChangePasswordErrorState(error.toString()));
    });
  }

}
