class GetAttendanceModel {
  String? status;
  String? message;
  List<Attendancedata>? attendancedata;

  GetAttendanceModel({this.status, this.message, this.attendancedata});

  GetAttendanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['attendancedata'] != null) {
      attendancedata = <Attendancedata>[];
      json['attendancedata'].forEach((v) {
        attendancedata!.add(new Attendancedata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.attendancedata != null) {
      data['attendancedata'] =
          this.attendancedata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendancedata {
  String? employeeid;
  String? employeename;
  String? dateofattendance;
  List<DateWiseData>? dateWiseData;

  Attendancedata(
      {this.employeeid,
      this.employeename,
      this.dateofattendance,
      this.dateWiseData});

  Attendancedata.fromJson(Map<String, dynamic> json) {
    employeeid = json['employeeid'];
    employeename = json['employeename'];
    dateofattendance = json['dateofattendance'];
    if (json['dateWiseData'] != null) {
      dateWiseData = <DateWiseData>[];
      json['dateWiseData'].forEach((v) {
        dateWiseData!.add(new DateWiseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeid'] = this.employeeid;
    data['employeename'] = this.employeename;
    data['dateofattendance'] = this.dateofattendance;
    if (this.dateWiseData != null) {
      data['dateWiseData'] = this.dateWiseData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DateWiseData {
  String? intime;
  String? outtime;
  String? latitude;
  String? longitude;
  String? location;
  String? latitudeOut;
  String? longitudeOut;
  String? locationOut;
  String? isapproved;

  DateWiseData(
      {this.intime,
      this.outtime,
      this.latitude,
      this.longitude,
      this.location,
      this.latitudeOut,
      this.longitudeOut,
      this.locationOut,
      this.isapproved});

  DateWiseData.fromJson(Map<String, dynamic> json) {
    intime = json['intime'];
    outtime = json['outtime'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    latitudeOut = json['latitude_out'];
    longitudeOut = json['longitude_out'];
    locationOut = json['location_out'];
    isapproved = json['isapproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intime'] = this.intime;
    data['outtime'] = this.outtime;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['latitude_out'] = this.latitudeOut;
    data['longitude_out'] = this.longitudeOut;
    data['location_out'] = this.locationOut;
    data['isapproved'] = this.isapproved;
    return data;
  }
}
