abstract class CenterAppStates {}

 class CenterAppInitialState extends CenterAppStates {}

class CenterChangeBottomNavBar extends CenterAppStates {}

class CenterChangeRedDot extends CenterAppStates {}

class CenterChangeNavBar extends CenterAppStates {}

class CenterProfileImagePicker extends CenterAppStates {}

class CenterGetCenterLoading extends CenterAppStates{}

class CenterGetCenterSuccess extends CenterAppStates{}

class CenterGetCenterError extends CenterAppStates{
 final error;

  CenterGetCenterError(this.error);
}



class CenterGetNotificationsLoading extends CenterAppStates{}

class CenterGetNotificationsSuccess extends CenterAppStates{}

class CenterGetNotificationsError extends CenterAppStates{
 final error;

  CenterGetNotificationsError(this.error);

}