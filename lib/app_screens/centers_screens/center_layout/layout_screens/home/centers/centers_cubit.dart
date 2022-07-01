import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'centers_state.dart';


class CentersCubit extends Cubit<CentersState> {
  CentersCubit() : super(CentersInitial());

  static CentersCubit get(context) => BlocProvider.of(context);

  int? status;

File? profileImage;
var picker =ImagePicker();

Future<void> getImage() async{
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile!=null){
    profileImage=File(pickedFile.path);
    emit(ProfileImagePicker());
  }
}

  void CreateCenter({
    required String name,
    required String about,
    String? address,
    String? phone,
  }) {
    emit(CentersLoading());
    DioHelper.postMultipartData(
      jsonImageName: 'center_image',
        url: 'center/create-center',
        token: CashHelper.getData(key: 'token'),
        file:profileImage!,
      name: name,
      about: about,
      address: address,
      phoneNumber: phone,
    ).then((value) {
      status=value.statusCode;
      print(status);
      print(value);
      emit(CentersSuccess());
    }).catchError((error){
      print(error);
      emit(CentersError(error.toString()));
    });
  }


}
