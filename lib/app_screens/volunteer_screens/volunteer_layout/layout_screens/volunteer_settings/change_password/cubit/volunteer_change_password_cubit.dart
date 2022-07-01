import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/app_screens/volunteer_screens/volunteer_layout/layout_screens/volunteer_settings/change_password/cubit/volunteer_change_password_states.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';



class VolunteerChangePasswordCubit extends Cubit<VolunteerChangePasswordStates> {
 VolunteerChangePasswordCubit() : super(VolunteerChangeInitialState());
  static VolunteerChangePasswordCubit get(context) => BlocProvider.of(context);
  int? status ;
  void VolunteerChangePassword({
    required String password,
    required String new_password,
    required String new_password_confirmation,

  }) {
    emit(VolunteerChangeLoadingState());
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
      emit(VolunteerChangeSuccessState());
    }).catchError((error){
      print(error);
      emit(VolunteerChangePasswordErrorState(error.toString()));
    });
  }

}
