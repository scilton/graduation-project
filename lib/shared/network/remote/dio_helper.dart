import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    debugPrint('dio helper run');
    dio = Dio(BaseOptions(
        validateStatus: (_)=>true,
      baseUrl: 'http://31.187.74.106/api/',
        receiveDataWhenStatusError: true,

    ));
  }

  static Future<Response> getData({
    required String url,
     Map <String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers={
      'Authorization':'$token',
      'Accept':'application/json',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }


  static Future<Response> patchData({
    required String url,
    Map <String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers={
      'Authorization':'Bearer $token',
      'Accept':'application/json',
    };
    return await dio!.patch(
      url,
      queryParameters: query,
    );
  }


  static Future<Response> postData({
    required String url,
     Map <String, dynamic>? data,
     Map <String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers={
      'Authorization':'Bearer $token',
      'Accept':'application/json',
    };
    return dio!.post(
      url,
      data: data,
      queryParameters: query,
      options: Options(
          followRedirects: false,
          validateStatus: (status) { return status! < 500; }
      ),
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map <String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers={
      'Authorization':'Bearer $token',
      'Accept':'application/json',
    };
    return await dio!.delete(
      url,
      queryParameters:query,
    );
  }

  static Future<Response> putData({
    required String url,
    Map <String, dynamic>? data,
    Map <String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers={
      'Authorization':'Bearer $token',
      'Accept':'application/json',
    };
    return await dio!.put(
      url,
      data: data,
      queryParameters: query,
    );
  }


  static Future<Response> postMultipartData({
    required String url,
    required File file,
    required String jsonImageName,
    String? token,
    String? name,
    String? about,
    String? address,
    String? phoneNumber,
  }) async {
    dio!.options.headers={
      'Authorization':'Bearer $token',
      'Accept':'application/json',
      'Content-Type':'multipart/form-data',
    };
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      '$jsonImageName': await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType("image", "jpeg"), //important

      ),
      'name':name,
      'about':about,
      'address':address,
      'phone_number':phoneNumber,
    });
    return dio!.post(
      url,
      data: data,
      options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
      ),
    );

  }


  static Future<Response> postCreateProduct({
    required String url,
    required File file,
    String? token,
    String? name,
    String? info,
    double? price,
    int? storeID,
  }) async {
    dio!.options.headers={
      'Authorization':'Bearer $token',
      'Accept':'application/json',
      'Content-Type':'multipart/form-data',
    };
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType("image", "jpeg"), //important

      ),
      'name':name,
      'description':info,
      'price':price,
      'store_id':storeID,
    });
    return dio!.post(
      url,
      data: data,
      options: Options(
        followRedirects: false,
        validateStatus: (status) => true,
      ),
    );

  }


  static Future<Response> postSignupDriver({
    required String url,
    required File? file1,
    required File? file2,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String role,
    required String volunteerType,
  }) async {
    dio!.options.headers={
      'Accept':'application/json',
      'Content-Type':'multipart/form-data',
    };
    String fileName1 = file1!.path.split('/').last;
    String fileName2 = file2!.path.split('/').last;
    FormData data = FormData.fromMap({
      'national_id': await MultipartFile.fromFile(
        file1.path,
        filename: fileName1,
        contentType: MediaType("image", "jpeg"), //important
      ),
      'license_id': await MultipartFile.fromFile(
        file2.path,
        filename: fileName2,
        contentType: MediaType("image", "jpeg"), //important
      ),
      'email':email,
      'password':password,
      'first_name':firstName,
      'last_name':lastName,
      'phone':phone,
      'password_confirmation':confirmPassword,
      'role':role,
      'volunteer_type':volunteerType,
    });
    return dio!.post(
      url,
      data: data,
      options: Options(
        followRedirects: false,
        validateStatus: (status) => true,
      ),
    );

  }

  static Future<Response> postSignupSitter({
    required String url,
    required File? file,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String role,
    required String volunteerType,
  }) async {
    dio!.options.headers={
      'Accept':'application/json',
      'Content-Type':'multipart/form-data',
    };
    String fileName = file!.path.split('/').last;
    FormData data = FormData.fromMap({
      'national_id': await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType("image", "jpeg"), //important

      ),
      'email':email,
      'password':password,
      'first_name':firstName,
      'last_name':lastName,
      'phone':phone,
      'password_confirmation':confirmPassword,
      'role':role,
      'volunteer_type':volunteerType,
    });
    return dio!.post(
      url,
      data: data,
      options: Options(
        followRedirects: false,
        validateStatus: (status) => true,
      ),
    );

  }

}

