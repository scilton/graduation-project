part of 'signup_cubit.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final SignupModel signupModel ;

  SignupSuccess(this.signupModel);

}

class SignupError extends SignupState {
  final error;

  SignupError(this.error);
}

class SignupImagePicker extends SignupState{}