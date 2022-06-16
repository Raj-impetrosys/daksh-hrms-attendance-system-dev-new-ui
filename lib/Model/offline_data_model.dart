class OfflineDataModel {
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
  String? year;
  String? month;
  bool? ischeckin;

  OfflineDataModel(
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
      this.isapproved,
      this.year,
      this.month,
      this.ischeckin});

  OfflineDataModel.fromJson(Map<String, dynamic> json) {
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
    year = json['year'];
    month = json['month'];
    ischeckin = json['ischeckin'];
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
    data['year'] = this.year;
    data['month'] = this.month;
    data['ischeckin'] = this.ischeckin;
    return data;
  }
}
