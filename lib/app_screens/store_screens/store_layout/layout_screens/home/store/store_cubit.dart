import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/get_product_model.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(StoreInitial());

  static StoreCubit get(context) => BlocProvider.of(context);

  int? status;
  File? image;
  var picker =ImagePicker();

  Future<void> getImage() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile!=null){
      image=File(pickedFile.path);
      emit(ProfileImagePicker());
    }
  }

  void CreateStore({
    required String name,
    required String address,
    required String phone,
    File? file,
  }) {
    emit(StoreLoading());
    DioHelper.postMultipartData(
      jsonImageName: 'store_image',
      url: 'store/create-store',
      token: CashHelper.getData(key: 'token'),
      file:image!,
      name: name,
      address: address,
      phoneNumber: phone
    ).then((value) {
      status=value.statusCode;
      print(status);
      print(value);
      emit(StoreSuccess());
    }).catchError((error){
      print(error);
      emit(StoreError(error.toString()));
    });
  }

  void CreateProduct({
    required String name,
    required double price,
    required String info,
    required int id,
  }) {
    emit(productLoading());
    DioHelper.postCreateProduct(
      url: 'product/product-create',
      token: CashHelper.getData(key: 'token'),
      file:image!,
      name: name,
      info: info,
      price: price,
      storeID: id,
    ).then((value) {
      status=value.statusCode;
      print(status);
      print(value);
      emit(productSuccess());
    }).catchError((error){
      print(error);
      emit(productError(error.toString()));
    });
  }


}
