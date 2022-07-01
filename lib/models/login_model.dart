class LoginModel {
 late String message;
  late UserData data;
  LoginModel.fromJson(Map<String,dynamic> json)
  {
    message = (json['message'] ?? 'login successfully');
    data = (json['data'] != null ? UserData.fromJson(json['data']) : UserData.fromJson(json));
  }

}

class UserData {

  late var token ;
  late var role ;

  UserData(
      this.token,
      );

  UserData.fromJson(Map<String,dynamic> json)
    {
      token = json['token'];
      role  = json['role'];
    }

}