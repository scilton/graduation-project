abstract class UserAppStates {}

 class AppInitialState extends UserAppStates {}

class ChangeBottomNavBar extends UserAppStates {}

class ChangeNavBar extends UserAppStates {}

class UserGetCenterLoading extends UserAppStates {}

class UserGetCenterSuccess extends UserAppStates {}

class UserGetCenterError extends UserAppStates {
 final String error;

  UserGetCenterError(this.error);

}

class UserGetStoreLoading extends UserAppStates {}

class UserGetStoreSuccess extends UserAppStates {}

class UserGetStoreError extends UserAppStates {
 final String error;

  UserGetStoreError(this.error);

}

class UserGetProductsLoading extends UserAppStates {}

class UserGetProductsSuccess extends UserAppStates {}

class UserGetProductsError extends UserAppStates {
  final String error;

  UserGetProductsError(this.error);


}

class CenterBookingLoading extends UserAppStates{}

class CenterBookingsuccess extends UserAppStates{}

class CenterBookingError extends UserAppStates{
  final error;

  CenterBookingError(this.error);
}

class CenterRatingLoading extends UserAppStates{}

class CenterRatingSuccess extends UserAppStates{}

class CenterRatingError extends UserAppStates{
  final error;

  CenterRatingError(this.error);

}

class GetUserDataLoading extends UserAppStates{}

class GetUserDataSuccess extends UserAppStates{}

class GetUserDataError extends UserAppStates{
  final error;

  GetUserDataError(this.error);
}


class GetUserNotificationsLoading extends UserAppStates{}

class GetUserNotificationsSuccess extends UserAppStates{}

class GetUserNotificationsError extends UserAppStates{
  final error;

  GetUserNotificationsError(this.error);

}


class GetUserRequestsLoading extends UserAppStates{}

class GetUserRequestsSuccess extends UserAppStates{}

class GetUserRequestsError extends UserAppStates{
  final error ;

  GetUserRequestsError(this.error);
}



class UserMakeVolunteerRequestsLoading extends UserAppStates{}

class UserMakeVolunteerRequestsSuccess extends UserAppStates{}

class UserMakeVolunteerRequestsError extends UserAppStates{
  final error ;

  UserMakeVolunteerRequestsError(this.error);

}

