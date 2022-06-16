import 'package:dakshattendance/provider/approval_check_in_provider.dart';
import 'package:dakshattendance/provider/approval_check_out_provider.dart';
import 'package:dakshattendance/provider/approval_list_provider.dart';
import 'package:dakshattendance/provider/check_in_provider.dart';
import 'package:dakshattendance/provider/check_out_provider.dart';
import 'package:dakshattendance/provider/get_attendance_provider.dart';
import 'package:dakshattendance/provider/login_provider.dart';

class Repository {
  //=================== LOGIN IN  ===================
  final UserLoginApi loginApiProvider = UserLoginApi();

  Future<dynamic> onLogin(String userid, String password) =>
      loginApiProvider.onUserLoginAPI(userid, password);

  //=================== CHECK IN ===================
  final CheckInAttendanceApI checkInAttendanceApI = CheckInAttendanceApI();

  Future<dynamic> oncheckinAttendance(
          String employeeid,
          String employeename,
          String tdate,
          String intime,
          String outtime,
          var latitudefatched,
          var longitudefatched,
          String location) =>
      checkInAttendanceApI.oncheckInAttendanceApI(employeeid, employeename,
          tdate, intime, outtime, latitudefatched, longitudefatched, location);

  // --------------- GET ATTENDACNE ----------------
  final GetAttendanceProvider getAttendanceProvider = GetAttendanceProvider();
  Future<dynamic> onGetAttendanceApi(
          String employeeid, String year, String month) =>
      getAttendanceProvider.onGetAttendanceAPI(employeeid, year, month);

  // --------------- CHECK OUT ----------------
  final CheckOutProvider checkOutProvider = CheckOutProvider();
  Future<dynamic> onCheckOutApi(
          String employeeid,
          String tdate,
          String intime,
          String outtime,
          var latitudefatched,
          var longitudefatched,
          String location) =>
      checkOutProvider.onCheckOutAPI(employeeid, tdate, intime, outtime,
          latitudefatched, longitudefatched, location);

  // --------------- APPROVAL LIST ----------------
  final ApprovalListProvider approvalListProvider = ApprovalListProvider();
  Future<dynamic> onApprovalListApi(String employeeid) =>
      approvalListProvider.onApprovalListAPI(employeeid);

  // --------------- APPROVAL CHECK IN ----------------
  final ApprovalCheckInProvider approvalCheckInProvider =
      ApprovalCheckInProvider();
  Future<dynamic> onApprovalCheckIn(String employeeid, String employeename,
          String tdate, String intime, String outtime, String requesttext) =>
      approvalCheckInProvider.onApprovalCheckInAPI(
          employeeid, employeename, tdate, intime, outtime, requesttext);

  // --------------- APPROVAL CHECK OUT ----------------
  final ApprovalCheckOutProvider approvalCheckOutProvider =
      ApprovalCheckOutProvider();
  Future<dynamic> onApprovalCheckOut(String employeeid, String employeename,
          String tdate, String intime, String outtime, String requesttext) =>
      approvalCheckOutProvider.onApprovalCheckOutAPI(
          employeeid, employeename, tdate, intime, outtime, requesttext);
}
