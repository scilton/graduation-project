abstract class VolunteerAppStates {}

 class VolunteerAppInitialState extends VolunteerAppStates {}

class VolunteerChangeBottomNavBar extends VolunteerAppStates {}

class VolunteerChangeNavBar extends VolunteerAppStates {}

class VolunteerChangeVolunteerNavBar extends VolunteerAppStates {}

class VolunteerGetUserRequestsLoading extends VolunteerAppStates{}

class VolunteerGetUserRequestsSuccess extends VolunteerAppStates{}

class VolunteerGetUserRequestsError extends VolunteerAppStates{
  final error ;

  VolunteerGetUserRequestsError(this.error);

}

class VolunteerGetAcceptedRequestsLoading extends VolunteerAppStates{}

class VolunteerGetAcceptedRequestsSuccess extends VolunteerAppStates{}

class VolunteerGetAcceptedRequestsError extends VolunteerAppStates{
  final error ;

  VolunteerGetAcceptedRequestsError(this.error);


}


class VolunteerAcceptRequestsLoading extends VolunteerAppStates{}

class VolunteerAcceptRequestsSuccess extends VolunteerAppStates{}

class VolunteerAcceptRequestsError extends VolunteerAppStates{
  final error ;

  VolunteerAcceptRequestsError(this.error);
}



class VolunteerFinishRequestsLoading extends VolunteerAppStates{}

class VolunteerFinishRequestsSuccess extends VolunteerAppStates{}

class VolunteerFinishRequestsError extends VolunteerAppStates{
  final error ;

  VolunteerFinishRequestsError(this.error);

}


class GetNotificationsLoading extends VolunteerAppStates{}

class GetNotificationsSuccess extends VolunteerAppStates{}

class GetNotificationsError extends VolunteerAppStates{
  final error;

  GetNotificationsError(this.error);


}