class GetUserDataModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  String? phone;
  String? nationalId;
  String? licenseId;
  String? volunteerType;
  String? emailVerifiedAt;
  String? fcmToken;

  GetUserDataModel(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.role,
        this.phone,
        this.nationalId,
        this.licenseId,
        this.volunteerType,
        this.emailVerifiedAt,
        this.fcmToken});

  GetUserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    role = json['role'];
    phone = json['phone'];
    nationalId = json['national_id'];
    licenseId = json['license_id'];
    volunteerType = json['volunteer_type'];
    emailVerifiedAt = json['email_verified_at'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['role'] = this.role;
    data['phone'] = this.phone;
    data['national_id'] = this.nationalId;
    data['license_id'] = this.licenseId;
    data['volunteer_type'] = this.volunteerType;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}
