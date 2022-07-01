
abstract class StoreChangePasswordStates{}
class StoreChangeInitialState extends StoreChangePasswordStates{}

class StoreChangeSuccessState extends StoreChangePasswordStates{
}

class StoreChangePasswordErrorState extends StoreChangePasswordStates{
  final String error ;

  StoreChangePasswordErrorState(this.error);


}

class StoreChangeLoadingState extends StoreChangePasswordStates{}



