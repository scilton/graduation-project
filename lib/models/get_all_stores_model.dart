class GetAllStoresModel {
  int? statusCode;
  List<Data>? data;

  GetAllStoresModel({this.statusCode, this.data});

  GetAllStoresModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? name;
  String? address;
  String? email;
  String? phoneNumber;
  String? status;
  String? image;

  Data(
      {this.id,
        this.userId,
        this.name,
        this.address,
        this.email,
        this.phoneNumber,
        this.status,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    address = json['address'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    status = json['status'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['status'] = this.status;
    data['image'] = this.image;
    return data;
  }
}
