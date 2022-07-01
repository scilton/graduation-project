import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/signup_model.dart';
import 'package:graduation_project/shared/network/end_points.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';
import 'package:image_picker/image_picker.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  static SignupCubit get(context) => BlocProvider.of(context);

  int? status ;
  var emailValidation;
  var passwordValidation;

  SignupModel? signupModel ;


  void userSignup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String role,
  }) {
    emit(SignupLoading());

    DioHelper.postData(
      url: SIGNUP,
      data: {
        'email':email,
        'password':password,
        'first_name':firstName,
        'last_name':lastName,
        'phone':phone,
        'password_confirmation':confirmPassword,
        'role':role,
      },
    ).then((value) {
      status=value.statusCode;
      print(status);
      print(value.data);
      signupModel = SignupModel.fromJson(value.data);
      if (status!=200){
        emailValidation = signupModel!.data.email??'true';
        passwordValidation = signupModel!.data.password??'true';
      }

      emit(SignupSuccess(signupModel!));
    }).catchError((error){
      print(error);
      emit(SignupError(error.toString()));
    });
  }

File? image1;
File? image2;
var picker =ImagePicker();

Future<void> getImage1() async{
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile!=null){
    image1=File(pickedFile.path);
    emit(SignupImagePicker());
  }
}

  Future<void> getImage2() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile!=null){
      image2=File(pickedFile.path);
      emit(SignupImagePicker());
    }
  }



void UserSignupDriver({
  required String firstName,
  required String lastName,
  required String email,
  required String password,
  required String confirmPassword,
  required String phone,
  required String role,
  required String volunteerType,
}){
  emit(SignupLoading());

  DioHelper.postSignupDriver(
      url: 'auth/register',
      file1: image1,
      file2: image2,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
      role: role,
      volunteerType: volunteerType,
  ).then((value) {
    status=value.statusCode;
    print(status);
    print(value.data);
    signupModel = SignupModel.fromJson(value.data);
    if (status!=200){
      emailValidation = signupModel!.data.email??'true';
      passwordValidation = signupModel!.data.password??'true';
    }

    emit(SignupSuccess(signupModel!));
  }).catchError((error){
    print(error);
    emit(SignupError(error.toString()));
  });
}


  void UserSignupSitter({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String role,
    required String volunteerType,
  }){
    emit(SignupLoading());

    DioHelper.postSignupSitter(
      url: 'auth/register',
      file: image1,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
      role: role,
      volunteerType: volunteerType,
    ).then((value) {
      status=value.statusCode;
      print(status);
      print(value.data);
      signupModel = SignupModel.fromJson(value.data);
      if (status!=200){
        emailValidation = signupModel!.data.email??'true';
        passwordValidation = signupModel!.data.password??'true';
      }

      emit(SignupSuccess(signupModel!));
    }).catchError((error){
      print(error);
      emit(SignupError(error.toString()));
    });
  }


}
