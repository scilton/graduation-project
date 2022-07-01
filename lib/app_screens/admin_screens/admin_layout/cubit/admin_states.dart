abstract class AdminAppStates {}

 class AdminAppInitialState extends AdminAppStates {}

class AdminChangeBottomNavBar extends AdminAppStates {}

class AdminChangeNavBar extends AdminAppStates {}

class AdminGetAcceptedCenterLoading extends AdminAppStates {}
class AdminGetAcceptedCenterSuccess extends AdminAppStates {}
class AdminGetAcceptedCenterError extends AdminAppStates {

 final String error;

  AdminGetAcceptedCenterError(this.error);

}

class AdminGetAcceptedStoreLoading extends AdminAppStates {}
class AdminGetAcceptedStoreSuccess extends AdminAppStates {}
class AdminGetAcceptedStoreError extends AdminAppStates {
 final String error;

  AdminGetAcceptedStoreError(this.error);


}

class AdminGetPendingCenterLoading extends AdminAppStates {}
class AdminGetPendingCenterSuccess extends AdminAppStates {}
class AdminGetPendingCenterError extends AdminAppStates {

  final String error;

  AdminGetPendingCenterError(this.error);

}

class AdminGetPendingStoreLoading extends AdminAppStates {}
class AdminGetPendingStoreSuccess extends AdminAppStates {}
class AdminGetPendingStoreError extends AdminAppStates {
  final String error;

  AdminGetPendingStoreError(this.error);


}


class AdminGetProductsLoading extends AdminAppStates {}

class AdminGetProductsSuccess extends AdminAppStates {}

class AdminGetProductsError extends AdminAppStates {
  final String error;

  AdminGetProductsError(this.error);

}

class AdminRatingLoading extends AdminAppStates{}

class AdminRatingSuccess extends AdminAppStates{}

class AdminRatingError extends AdminAppStates{
  final error;

  AdminRatingError(this.error);

}



class AdminGetUserRequestsLoading extends AdminAppStates{}

class AdminGetUserRequestsSuccess extends AdminAppStates{}

class AdminGetUserRequestsError extends AdminAppStates{
  final error ;

  AdminGetUserRequestsError(this.error);
}


class AdminApproveCenterLoading extends AdminAppStates{}

class AdminApproveCenterSuccess extends AdminAppStates{}

class AdminApproveCenterError extends AdminAppStates{
  final error ;

  AdminApproveCenterError(this.error);
}


class AdminRejectCenterLoading extends AdminAppStates{}

class AdminRejectCenterSuccess extends AdminAppStates{}

class AdminRejectCenterError extends AdminAppStates{
  final error ;

  AdminRejectCenterError(this.error);

}



class AdminApproveStoreLoading extends AdminAppStates{}

class AdminApproveStoreSuccess extends AdminAppStates{}

class AdminApproveStoreError extends AdminAppStates{
  final error ;

  AdminApproveStoreError(this.error);

}


class AdminRejectStoreLoading extends AdminAppStates{}

class AdminRejectStoreSuccess extends AdminAppStates{}

class AdminRejectStoreError extends AdminAppStates{
  final error ;

  AdminRejectStoreError(this.error);


}


class deleteProductLoading extends AdminAppStates {}

class deleteProductSuccess extends AdminAppStates {
}
class deleteProductError extends AdminAppStates {
  final error ;

  deleteProductError(this.error);



}


class GetNotificationsLoading extends AdminAppStates{}

class GetNotificationsSuccess extends AdminAppStates{}

class GetNotificationsError extends AdminAppStates{
  final error;

  GetNotificationsError(this.error);


}
