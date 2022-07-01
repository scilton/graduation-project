
abstract class CenterChangePasswordStates{}
class CenterChangeInitialState extends CenterChangePasswordStates{}

class CenterChangeSuccessState extends CenterChangePasswordStates{
}

class CenterChangePasswordErrorState extends CenterChangePasswordStates{
  final String error ;

  CenterChangePasswordErrorState(this.error);

}

class CenterChangeLoadingState extends CenterChangePasswordStates{}



