// To parse this JSON data, do
//
//     final checkInModel = checkInModelFromJson(jsonString);

import 'dart:convert';

CheckInModel checkInModelFromJson(String str) =>
    CheckInModel.fromJson(json.decode(str));

String checkInModelToJson(CheckInModel data) => json.encode(data.toJson());

class CheckInModel {
  CheckInModel({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory CheckInModel.fromJson(Map<String, dynamic> json) => CheckInModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
