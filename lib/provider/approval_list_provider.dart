import 'dart:async';
import 'dart:convert';
import 'package:dakshattendance/const/config.dart';
import 'package:dakshattendance/model/approval_list_model.dart';
import 'package:http/http.dart' as http;

class ApprovalListProvider {
  Future<dynamic> onApprovalListAPI(String employeeid) async {
    try {
      final strURL = Uri.parse(
          Config.apiurl + Config.approvalist + 'employeeid=${employeeid}');

      final response = await http
          .get((strURL), headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print(json.decode(response.body));
        return ApprovalListModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return ApprovalListModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final approvalListProvider = ApprovalListProvider();
