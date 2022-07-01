class GetVolunteerAcceptedRequests {
  int? statusCode;
  List<Data>? data;

  GetVolunteerAcceptedRequests({this.statusCode, this.data});

  GetVolunteerAcceptedRequests.fromJson(Map<String, dynamic> json) {
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
  String? volunteerType;
  String? userName;
  String? userPhone;
  String? from;
  String? to;
  String? date;
  String? status;
  int? volunteerId;
  int? requestId;
  String? startDate;
  String? endDate;
  String? comment;

  Data(
      {this.id,
        this.userId,
        this.volunteerType,
        this.userName,
        this.userPhone,
        this.from,
        this.to,
        this.date,
        this.status,
        this.volunteerId,
        this.requestId,
        this.startDate,
        this.endDate,
        this.comment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    volunteerType = json['volunteer_type'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    from = json['from'];
    to = json['to'];
    date = json['date'];
    status = json['status'];
    volunteerId = json['volunteer_id'];
    requestId = json['request_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['volunteer_type'] = this.volunteerType;
    data['user_name'] = this.userName;
    data['user_phone'] = this.userPhone;
    data['from'] = this.from;
    data['to'] = this.to;
    data['date'] = this.date;
    data['status'] = this.status;
    data['volunteer_id'] = this.volunteerId;
    data['request_id'] = this.requestId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['comment'] = this.comment;
    return data;
  }
}
