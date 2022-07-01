
abstract class UserChangePasswordStates{}
class ChangeInitialState extends UserChangePasswordStates{}

class ChangeSuccessState extends UserChangePasswordStates{
}

class ChangePasswordErrorState extends UserChangePasswordStates{
  final String error ;

  ChangePasswordErrorState(this.error);
}

class ChangeLoadingState extends UserChangePasswordStates{}



