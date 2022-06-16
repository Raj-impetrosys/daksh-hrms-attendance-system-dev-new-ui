class ApprovalListCheckInModel {
  String? status;
  List<Data>? data;
  String? message;

  ApprovalListCheckInModel({this.status, this.data, this.message});

  ApprovalListCheckInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? employeeid;
  String? employeename;
  String? dateofattendance;
  String? intime;
  String? outtime;
  String? latitude;
  String? longitude;
  String? location;
  String? requesttext;
  String? isapproved;

  Data(
      {this.id,
      this.employeeid,
      this.employeename,
      this.dateofattendance,
      this.intime,
      this.outtime,
      this.latitude,
      this.longitude,
      this.location,
      this.requesttext,
      this.isapproved});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeid = json['employeeid'];
    employeename = json['employeename'];
    dateofattendance = json['dateofattendance'];
    intime = json['intime'];
    outtime = json['outtime'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    requesttext = json['requesttext'];
    isapproved = json['isapproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeid'] = this.employeeid;
    data['employeename'] = this.employeename;
    data['dateofattendance'] = this.dateofattendance;
    data['intime'] = this.intime;
    data['outtime'] = this.outtime;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['requesttext'] = this.requesttext;
    data['isapproved'] = this.isapproved;
    return data;
  }
}
