import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/app_screens/user_screens/user_layout/layout_screens/user_settings/change_password/cubit/user_change_password_states.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';



class UserChangePasswordCubit extends Cubit<UserChangePasswordStates> {
 UserChangePasswordCubit() : super(ChangeInitialState());
  static UserChangePasswordCubit get(context) => BlocProvider.of(context);
  int? status ;
  void userChangePassword({
    required String password,
    required String new_password,
    required String new_password_confirmation,

  }) {
    emit(ChangeLoadingState());
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
      emit(ChangeSuccessState());
    }).catchError((error){
      print(error);
      emit(ChangePasswordErrorState(error.toString()));
    });
  }

}
