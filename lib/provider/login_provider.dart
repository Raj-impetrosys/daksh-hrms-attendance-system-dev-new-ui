import 'dart:async';
import 'dart:convert';
import 'package:dakshattendance/const/config.dart';
import 'package:dakshattendance/model/login_model.dart';
import 'package:http/http.dart' as http;

class UserLoginApi {
  Future<LoginModel?> onUserLoginAPI(String userid, String password) async {
    try {
      final uri = Uri.parse(Config.apiurl +
          Config.login +
          'username=${userid}&' +
          'password=${password}');
      print(uri);
      final request = http.MultipartRequest(
        'POST',
        uri,
      );

      Map<String, String> headers = {
        'Content-Type': 'Content-Type',
        'Accept': 'application/json',
      };
      request.headers.addAll(headers);

      final http.Response response = await http.Response.fromStream(
        await request.send(),
      );
      dynamic responseJson;
      if (response.statusCode == 200) {
        print(response.statusCode);
        responseJson = json.decode(response.body);
        return LoginModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
