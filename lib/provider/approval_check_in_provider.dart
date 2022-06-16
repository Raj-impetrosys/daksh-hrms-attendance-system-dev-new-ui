import 'dart:async';
import 'dart:convert';
import 'package:dakshattendance/const/config.dart';
import 'package:dakshattendance/model/approval_check_in_model.dart';
import 'package:http/http.dart' as http;

class ApprovalCheckInProvider {
  Future<ApprovalCheckInModel?> onApprovalCheckInAPI(
      String employeeid,
      String employeename,
      String tdate,
      String intime,
      String outtime,
      String requesttext) async {
    try {
      final strURL = Uri.parse(Config.apiurl +
          Config.approvalcheckin +
          'employeeid=${employeeid}&' +
          'employeename=${employeename}&' +
          'tdate=${tdate}&' +
          'intime=${intime}&' +
          'outtime=${outtime}&' +
          'requesttext=${requesttext}');

      final response =
          await http.get(strURL, headers: {'content-Type': 'application/json'});
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print("CHECK IN DATA = ${json.decode(response.body)}");
        return ApprovalCheckInModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return ApprovalCheckInModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final approvalCheckInProvider = ApprovalCheckInProvider();
