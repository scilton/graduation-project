class SignupModel {
  late String message;
  late UserData data;
  SignupModel.fromJson(Map<String,dynamic> json)
  {
    //message = json['message'];
    message = (json['message'] ?? 'login successfully');
    data = (json['data'] != null ? UserData.fromJson(json['data']) : UserData.fromJson(json));
    // data = UserData.fromJson(json['data']) ?? 'no data';
  }

}

class UserData {

  late var token ;
  late var email ;
  late var password ;

  UserData(
      this.token,
      this.email,
      this.password,
      );

  UserData.fromJson(Map<String,dynamic> json)
  {
    token = json['token'];
    email = json['email'];
    password = json['password'];
  }

}