abstract class StoreAppStates {}

 class StoreAppInitialState extends StoreAppStates {}

class StoreChangeBottomNavBar extends StoreAppStates {}

class StoreChangeNavBar extends StoreAppStates {}

class StoreProfileImagePicker extends StoreAppStates {}

class StoreGetStoreLoading extends StoreAppStates{}

class StoreGetStoreSuccess extends StoreAppStates{}

class StoreGetStoreError extends StoreAppStates{
 final error;

  StoreGetStoreError(this.error);
}

class getProductLoading extends StoreAppStates {}

class getProductSuccess extends StoreAppStates {
}
class getProductError extends StoreAppStates {
 final error ;

 getProductError(this.error);


}


class deleteProductLoading extends StoreAppStates {}

class deleteProductSuccess extends StoreAppStates {
}
class deleteProductError extends StoreAppStates {
 final error ;

  deleteProductError(this.error);



}


class updateProductPriceLoading extends StoreAppStates {}

class updateProductPriceSuccess extends StoreAppStates {
}
class updateProductPriceError extends StoreAppStates {
 final error ;

  updateProductPriceError(this.error);



}



class GetNotificationsLoading extends StoreAppStates{}

class GetNotificationsSuccess extends StoreAppStates{}

class GetNotificationsError extends StoreAppStates{
 final error;

  GetNotificationsError(this.error);


}
