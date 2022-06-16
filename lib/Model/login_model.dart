class LoginModel {
  String? status;
  String? empCode;
  String? username;
  String? companyname;
  String? message;

  LoginModel(
      {this.status,
      this.empCode,
      this.username,
      this.companyname,
      this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    empCode = json['emp_code'];
    username = json['username'];
    companyname = json['companyname'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['emp_code'] = this.empCode;
    data['username'] = this.username;
    data['companyname'] = this.companyname;
    data['message'] = this.message;
    return data;
  }
}

