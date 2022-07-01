class CreateCenterModel {
  late String message;
  late UserData data;
  CreateCenterModel.fromJson(Map<String,dynamic> json)
  {
    message = (json['message'] ?? 'login successfully');
    data = (json['data'] != null ? UserData.fromJson(json['data']) : UserData.fromJson(json));
  }

}

class UserData {

  late var data ;

  UserData(
      this.data,
      );

  UserData.fromJson(Map<String,dynamic> json)
  {
    data = json;
  }

}