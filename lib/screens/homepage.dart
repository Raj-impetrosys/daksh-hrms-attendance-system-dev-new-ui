import 'dart:async';
import 'dart:convert';
import 'package:dakshattendance/Model/offline_data_model.dart';
import 'package:dakshattendance/const/global.dart';
import 'package:dakshattendance/model/check_in_model.dart';
import 'package:dakshattendance/model/check_out_model.dart';
import 'package:dakshattendance/repository/repository.dart';
import 'package:dakshattendance/screens/approvedlistPage.dart';
import 'package:dakshattendance/screens/attendancescreen.dart';
import 'package:dakshattendance/screens/splesh.dart';

import 'package:dakshattendance/shared_preference/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  bool checked = true;

  Future<void>? isdate;

  String getSystemdate() {
    var now = DateTime.now();
    return DateFormat("dd/MM/yyyy").format(now);
  }

  var userData;

  String? employeeid;

  String? employeename;

  String? tdate;

  String? intime;

  String? outtime;

  String? latitude;

  String? longitude;

  String? location;

  // String _result = 'Unknown';
  String? latitudefatched;

  String? longitudefatched;

  String? month;

  String? year;

  List<Placemark>? placemarks;

  String? formattedDate;

  List offlineData = [];

  bool? connected;

  bool isSyncStart = true;

  @override
  void initState() {
    super.initState();
    // _showMyDialog();
    userData = json.decode(PrefObj.preferences!.get(PrefKeys.USERDATA));

    // showpopDialog(context, 'Internet', 'Ok');

    timer =
        Timer.periodic(Duration(seconds: 5), (Timer t) => _isContainerVisible);
    DateTime now = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(now);

    syncDataToServer();
  }

  syncDataToServer() async {
    if (connected != null) {
      if (PrefObj.preferences!.containsKey(PrefKeys.OFFLINEDATA)) {
        // isSyncStart;
        offlineData =
            json.decode(PrefObj.preferences!.get(PrefKeys.OFFLINEDATA));
        for (var i = 0; i < offlineData.length; i++) {
          if (offlineData[i]['ischeckin']) {
            // ignore: unused_local_variable
            final CheckInModel ischeckin =
                await _repository.oncheckinAttendance(
              userData['emp_code'],
              userData['username'],
              offlineData[i]['dateofattendance'],
              offlineData[i]['intime'],
              '0:00',
              offlineData[i]['latitude'],
              offlineData[i]['longitude'],
              offlineData[i]['location'],
            );
            print("Offline Check In API");
            isSyncStart = false;
          } else {
            final CheckOutModel ischeckout = await _repository.onCheckOutApi(
              userData['emp_code'],
              offlineData[i]['dateofattendance'],
              '0:00',
              offlineData[i]['intime'],
              offlineData[i]['latitude'],
              offlineData[i]['longitude'],
              offlineData[i]['location'],
            );
            print("Offline Check Out API");
          }
          // Loader().hideLoader(context);
          var snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            content: Text(
              'Data Sync Success',
              style: TextStyle(
                  fontFamily: 'popin',
                  fontSize: 18,
                  color: AppColor.containerColor),
            ),
          );
          PrefObj.preferences!.delete(PrefKeys.OFFLINEDATA);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // Loader().hideLoader(context);
          // isSyncStart = false;
          setState(() {
            // isSyncStart =true;
          });
        }
      }
    }
  }

  Timer? timer;

  bool _isContainerVisible = true;

//----------------- Location ------------------
  final _repository = Repository();

  // String _locationMessage = "";
  Future _getCurrentLocation(bool isChecking) async {
    Geolocator.checkPermission().then((value) => print(value));
    Geolocator.requestPermission();
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      // _locationMessage = "${position.latitude}, ${position.longitude}";
      latitudefatched = position.latitude.toString();
      longitudefatched = position.longitude.toString();
    });
    PrefObj.preferences!.put(PrefKeys.DisApproved, false);
    placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks![0].locality);
    PrefObj.preferences!.put(PrefKeys.DisApproved, false);
    // if (connected!) {
    //   if (isChecking) {
    //     oncheckinapi();
    //   } else {
    //     oncheckoutapi();
    //   }
    // } else {
    //   isChecking ? offlineDataa(true) : offlineDataa(false);
    // }
  }

//----------------------------------------
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            connected = connectivity != ConnectivityResult.none;
            if (connected != null) if (connected!) {
              Future.delayed(Duration(seconds: 5), () {
                setState(() {
                  _isContainerVisible = false;
                });
              });
              // if (!isSyncStart) {
              //   syncDataToServer();
              // }
            }
            return Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 50.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset("assets/images/homeBackground.png")),
                ),
                child,
                Positioned(
                  height: 40.0,
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    color: connected! ? Color(0xff00BCFF) : Color(0xff0082FF),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      child: connected!
                          ? _isContainerVisible
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  color: Color(0xff00BCFF),
                                  height: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Text(
                                      'ONLINE.....',
                                      style: TextStyle(
                                          fontFamily: "roboto",
                                          color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container(
                                  color: Colors.white,
                                )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('OFFLINE...'),
                                SizedBox(width: 10.0),
                                SizedBox(
                                  width: 12.0,
                                  height: 12.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 90.h,
                        ),
                        Center(
                            child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return White_splesh();
                            }));
                          },
                          child: Text(userData['username'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                  fontFamily: 'popin')),
                        )),
                        SizedBox(height: 10),
                        Center(
                            child: Text("User Id : ${userData['emp_code']}",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color(0xff989898),
                                    fontFamily: 'popin'))),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            userData['companyname'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontFamily: 'popin'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          // _getCurrentLocation();
                          // var status = await Permission.location.status;
                          var status = await Geolocator.checkPermission();
                          // if (!PrefObj.preferences!
                          //     .containsKey(PrefKeys.DisApproved)) {
                          //   showAlert(context);
                          // } else if (status.isDenied) {
                          //   showAlert(context);
                          // }

                          // if (status.isGranted) {
                          //   PrefObj.preferences!
                          //       .put(PrefKeys.DisApproved, false);
                          // }

                          // if (!PrefObj.preferences!
                          //     .get(PrefKeys.DisApproved)) {
                          //   if (connected!) {
                          //     oncheckinapi();
                          //   } else {
                          //     offlineDataa(true);
                          //   }
                          // }
                          print("status: ${status.name}");
                          print("status: $connected");
                          if (await Geolocator.isLocationServiceEnabled()) {
                            if (connected!) {
                              oncheckinapi();
                            } else {
                              offlineDataa(false);
                            }
                          } else {
                            Permission.location.request();
                            _getCurrentLocation(false);
                          }
                        },
                        child: Container(
                          height: 125.h,
                          width: 125.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff00BCFF),
                                Color(0xff0082FF),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Check In",
                              style: TextStyle(
                                fontFamily: "popin",
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard(
                                        employeeid: userData['emp_code'],
                                        month: DateTime.now().month.toString(),
                                        year: DateTime.now().year.toString(),
                                      )));
                        },
                        child: Container(
                          height: 125.h,
                          width: 125.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff00BCFF),
                                Color(0xff0082FF),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "View Attendance",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "popin",
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ApprovedListPage(
                                  employeeid: userData['emp_code'].toString());
                            },
                          ));
                        },
                        child: Container(
                          height: 125.h,
                          width: 125.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff00BCFF),
                                Color(0xff0082FF),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Back Date for Approval",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "popin",
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          // _getCurrentLocation();
                          // var status = await Permission.location.status;
                          LocationPermission status = await Geolocator.checkPermission();
                          // if (!PrefObj.preferences!
                          //     .containsKey(PrefKeys.DisApproved)) {
                          //   _getCurrentLocation(true);
                          // } else if (status.isDenied) {
                          //   showAlert(context);
                          // }

                          if (await Geolocator.isLocationServiceEnabled()) {
                            if (connected!) {
                              oncheckoutapi();
                            } else {
                              offlineDataa(false);
                            }
                          } else {
                            _getCurrentLocation(false);
                          }

                          // if (PrefObj.preferences!
                          //     .containsKey(PrefKeys.DisApproved)) {
                          //   if (!PrefObj.preferences!
                          //       .get(PrefKeys.DisApproved)) {

                          //   }
                          // }
                        },
                        child: Container(
                          height: 125.h,
                          width: 125.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff00BCFF),
                                Color(0xff0082FF),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Check Out",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "popin",
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 18.0, right: 18.0, bottom: 80.0),
                  child: GestureDetector(
                    onTap: () {
                      showpopDialog(context, 'Attention!',
                          'Do you want to exit this application?');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ViewAttendances(),
                      //   ),
                      // );
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Text(
                          "LogOut",
                          style: TextStyle(
                            fontFamily: "popin",
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------- CHECK IN API CALLING -----------------------------
  dynamic oncheckinapi() async {
    if (placemarks == null) {
      await _getCurrentLocation(true);
    } else {
      var tdate = new DateFormat('dd-MM-yyyy').format(DateTime.now());
      DateTime now = DateTime.now();
      String location = placemarks![0].street! +
          ", " +
          placemarks![0].subLocality! +
          " " +
          placemarks![0].locality! +
          " " +
          placemarks![0].postalCode!;

      String cTime = DateFormat('kk:mm').format(now);
      PrefObj.preferences!.put(PrefKeys.INTIME, cTime);
      Loader().showLoader(context);
      final CheckInModel ischeckin = await _repository.oncheckinAttendance(
          userData['emp_code'],
          userData['username'],
          tdate,
          cTime,
          '0:00',
          latitudefatched.toString(),
          longitudefatched.toString(),
          location);
      if (ischeckin.status == "Success") {
        Loader().hideLoader(context);
        // setState(() {
        //   checked = !checked;
        // });
        PrefObj.preferences!.put(PrefKeys.Approved, 'Approved');
        PrefObj.preferences!
            .put(PrefKeys.Request_Submitted, 'Request Submitted');
        PrefObj.preferences!.put(PrefKeys.DisApproved, false);
        print(PrefObj.preferences!.get(PrefKeys.DisApproved));
        var snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            content: Text(ischeckin.message!,
                style: TextStyle(
                    fontFamily: 'popin',
                    fontSize: 18,
                    color: AppColor.containerColor)));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {});
      } else {
        Loader().hideLoader(context);
        var snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            content: Text(ischeckin.message!,
                style: TextStyle(
                    fontFamily: 'popin',
                    fontSize: 18,
                    color: AppColor.containerColor)));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(false);
      }
    }
  }

//--------------------- CHECK OUT API CALLING -----------------------//
  dynamic oncheckoutapi() async {
    if (placemarks == null) {
      await _getCurrentLocation(false);
    } else {
      var tdate = new DateFormat('dd-MM-yyyy').format(DateTime.now());
      DateTime now = DateTime.now();
      String location = placemarks![0].street! +
          " " +
          placemarks![0].subLocality! +
          " " +
          placemarks![0].locality! +
          " " +
          placemarks![0].postalCode!;

      String oTime = DateFormat('kk:mm').format(now);
      // String iTime = PrefObj.preferences!.get(PrefKeys.INTIME);
      Loader().showLoader(context);
      final CheckOutModel ischeckout = await _repository.onCheckOutApi(
          userData['emp_code'],
          tdate,
          '0:00',
          oTime,
          latitudefatched.toString(),
          longitudefatched.toString(),
          location);
      if (ischeckout.status == "Success") {
        Loader().hideLoader(context);

        var snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            content: Text(ischeckout.message!,
                style: TextStyle(
                    fontFamily: 'popin',
                    fontSize: 18,
                    color: AppColor.containerColor)));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd').format(now);
        PrefObj.preferences!.put(PrefKeys.CURRENTDATE, formattedDate);
        PrefObj.preferences!.put(PrefKeys.Approved, 'Approved');
        PrefObj.preferences!
            .put(PrefKeys.Request_Submitted, 'Request Submitted');
        PrefObj.preferences!.put(PrefKeys.DisApproved, false);
        print(PrefObj.preferences!.get(PrefKeys.DisApproved));
        setState(() {});
      } else {
        Loader().hideLoader(context);
        var snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            content: Text(ischeckout.message!,
                style: TextStyle(
                    fontFamily: 'popin',
                    fontSize: 18,
                    color: AppColor.containerColor)));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(false);
      }
    }
  }

  dynamic offlineDataa(bool ischeckin) async {
    var tdate = new DateFormat('dd-MM-yyyy').format(DateTime.now());

    DateTime now = DateTime.now();
    String cTime = DateFormat('kk:mm').format(now);
    // String iTime = PrefObj.preferences!.get(PrefKeys.INTIME);

    List temapOfflineData = [];
    offlineData = [];
    // PrefObj.preferences!.delete(PrefKeys.OFFLINEDATA);
    if (PrefObj.preferences!.containsKey(PrefKeys.OFFLINEDATA)) {
      offlineData = json.decode(PrefObj.preferences!.get(PrefKeys.OFFLINEDATA));
    }
    temapOfflineData.add(OfflineDataModel(
        employeeid: userData['emp_code'],
        employeename: userData['username'],
        dateofattendance: tdate,
        intime: cTime,
        latitude: latitudefatched.toString(),
        longitude: longitudefatched.toString(),
        location: "",
        ischeckin: ischeckin));
    String tempString = json.encode(temapOfflineData);
    offlineData.addAll(json.decode(tempString));
    PrefObj.preferences!.put(PrefKeys.OFFLINEDATA, json.encode(offlineData));
    // for (var i = 0; i < offlineData.length; i++) {
    //   print(offlineData[i]['intime']);
    // }
    syncDataToServer();
  }

  showAlertsss(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            // Image.network('https://flutter-examples.com/wp-content/uploads/2019/12/android_icon.png',
            //   width: 50, height: 50, fit: BoxFit.contain,),
            Expanded(child: Text('Background Location Access!!'))
          ]),
          content: Text(
              "Monalisa App collects the location data to track the location for the purpose of daily attendance when the app is closed or not in use. \n\nThe data gets uploaded to https://monalisaedc.com/hrms/emp-backend/login.php where you can view your location data and you may or may not be able to delete the location history."),
          actions: <Widget>[
            FlatButton(
              child: Text("Allow"),
              onPressed: () {
                if (placemarks == null) {
                  _getCurrentLocation(true);
                } else {
                  oncheckinapi();
                }

                //Put your code here which you want to execute on Yes button click.
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Deny"),
              onPressed: () {
                PrefObj.preferences!.put(PrefKeys.DisApproved, true);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
