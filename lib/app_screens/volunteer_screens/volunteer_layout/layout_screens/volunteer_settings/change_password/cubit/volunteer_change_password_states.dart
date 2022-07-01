
abstract class VolunteerChangePasswordStates{}
class VolunteerChangeInitialState extends VolunteerChangePasswordStates{}

class VolunteerChangeSuccessState extends VolunteerChangePasswordStates{
}

class VolunteerChangePasswordErrorState extends VolunteerChangePasswordStates{
  final String error ;

 VolunteerChangePasswordErrorState(this.error);
}

class VolunteerChangeLoadingState extends VolunteerChangePasswordStates{}



