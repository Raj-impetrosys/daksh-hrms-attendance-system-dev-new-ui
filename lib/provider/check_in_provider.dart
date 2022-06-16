import 'dart:async';
import 'dart:convert';
import 'package:dakshattendance/model/check_in_model.dart';
import 'package:http/http.dart' as http;

class CheckInAttendanceApI {
  Future<dynamic> oncheckInAttendanceApI(
      String employeeid,
      String employeename,
      String tdate,
      String intime,
      String outtime,
      var longitudefatched,
      var latitudefatched,
      String location) async {
    try {
      final strURL = Uri.parse(
          'https://monalisaedc.com/hrms/emp-backend/checkinapi.php?employeeid=${employeeid}&employeename=${employeename}&tdate=${tdate}&intime=${intime}&outtime=${outtime}&latitude=${latitudefatched}&longitude=${longitudefatched}&location=${location}');
      print(
          'https://monalisaedc.com/hrms/emp-backend/checkinapi.php?employeeid=${employeeid}&employeename=${employeename}&tdate=${tdate}&intime=${intime}&outtime=${outtime}&latitude=${latitudefatched}&longitude=${longitudefatched}&location=${location}');
      print(strURL);

      final response = await http.post(strURL, headers: {
        'content-Type': 'application/json',
      });

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print(json.decode(response.body));
        return CheckInModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return CheckInModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
