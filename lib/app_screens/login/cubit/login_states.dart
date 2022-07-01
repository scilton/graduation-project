import 'package:graduation_project/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LogoutLoadingState extends LoginStates {}

class LogoutSuccessState extends LoginStates {}


class LoginSuccessState extends LoginStates {
  final LoginModel loginModel ;

  LoginSuccessState(this.loginModel);

}

class LoginErrorState extends LoginStates {
  final String error ;

  LoginErrorState(this.error);
}

class LogoutErrorState extends LoginStates {
  final String error ;

  LogoutErrorState(this.error);
}
