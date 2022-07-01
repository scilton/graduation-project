class GetAllCentersModel {
  int? statusCode;
  List<Data>? data;

  GetAllCentersModel({this.statusCode, this.data});

  GetAllCentersModel.fromJson(Map<String, dynamic> json) {
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
  String? email;
  String? phoneNumber;
  String? address;
  int? rating;
  String? status;
  String? about;
  String? image;

  Data(
      {this.id,
        this.userId,
        this.name,
        this.email,
        this.phoneNumber,
        this.address,
        this.rating,
        this.status,
        this.about,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    rating = json['rating'];
    status = json['status'];
    about = json['about'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['rating'] = this.rating;
    data['status'] = this.status;
    data['about'] = this.about;
    data['image'] = this.image;
    return data;
  }
}
