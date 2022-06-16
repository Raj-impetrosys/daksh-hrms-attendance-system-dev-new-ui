import 'dart:async';
import 'dart:convert';
import 'package:dakshattendance/const/config.dart';
import 'package:dakshattendance/model/get_attendance_model.dart';
import 'package:http/http.dart' as http;

class GetAttendanceProvider {
  Future<GetAttendanceModel?> onGetAttendanceAPI(
      String employeeid, String year, String month) async {
    try {
      final strURL = Uri.parse(Config.apiurl +
          Config.getattendance +
          'employeeid=${employeeid}&' +
          'year=${year}&' +
          'month=${month}');
      print(strURL);

      // https: //monalisaedc.com/hrms/emp-backend/getattendanceapi.php?employeeid=3377&year=2021&month=6

      final response =
          await http.get(strURL, headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return GetAttendanceModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return GetAttendanceModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final getAttendanceProvider = GetAttendanceProvider();
