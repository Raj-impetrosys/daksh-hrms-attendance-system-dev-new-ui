import 'dart:async';
import 'dart:convert';
import 'package:dakshattendance/const/config.dart';
import 'package:dakshattendance/model/approval_check_out_model.dart';
import 'package:http/http.dart' as http;

class ApprovalCheckOutProvider {
  Future<ApprovalCheckOutModel?> onApprovalCheckOutAPI(
      String employeeid,
      String employeename,
      String tdate,
      String intime,
      String outtime,
      String requesttext) async {
    try {
      final strURL = Uri.parse(Config.apiurl +
          Config.approvalcheckout +
          'employeeid=${employeeid}&' +
          'employeename=${employeename}&' +
          'tdate=${tdate}&' +
          'intime=${intime}&' +
          'outtime=${outtime}&' +
          'requesttext=${requesttext}');
      print(Config.apiurl +
          Config.approvalcheckout +
          'employeeid=${employeeid}&' +
          'employeename=${employeename}&' +
          'tdate=${tdate}' +
          'intime = ${intime}&' +
          'outtime=${outtime}&' +
          'requesttext=${requesttext}');
      // https://monalisaedc.com/hrms/emp-backend/approvalcheckoutapi.php?employeeid=3377&employeename=AnkithSivadasan&tdate=11-06-2021&intime=0:00&outtime=10:00&requesttext=I
      final response =
          await http.get(strURL, headers: {'content-Type': 'application/json'});
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print("CHECK OUT DATA = ${json.decode(response.body)}");
        return ApprovalCheckOutModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return ApprovalCheckOutModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
