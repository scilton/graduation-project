
abstract class AdminChangePasswordStates{}
class AdminChangeInitialState extends AdminChangePasswordStates{}

class AdminChangeSuccessState extends AdminChangePasswordStates{
}

class AdminChangePasswordErrorState extends AdminChangePasswordStates{
  final String error ;

  AdminChangePasswordErrorState(this.error);
}

class AdminChangeLoadingState extends AdminChangePasswordStates{}



