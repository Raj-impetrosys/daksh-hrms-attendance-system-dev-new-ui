import 'dart:async';
import 'dart:convert';
import 'package:dakshattendance/model/check_out_model.dart';
import 'package:http/http.dart' as http;

class CheckOutProvider {
  Future<CheckOutModel?> onCheckOutAPI(
      String employeeid,
      String tdate,
      String intime,
      String outtime,
      var latitudefatched,
      var longitudefatched,
      String location) async {
    try {
      final strURL = Uri.parse(
          'https://monalisaedc.com/hrms/emp-backend/checkoutapi.php?employeeid=${employeeid}&tdate=${tdate}&outtime=${outtime}&latitude=${latitudefatched}&longitude=${longitudefatched}&location=${location}&intime=${intime}');

      final response =
          await http.get(strURL, headers: {'content-Type': 'application/json'});
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print(json.decode(response.body));
        return CheckOutModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return CheckOutModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final getAttendanceProvider = CheckOutProvider();
