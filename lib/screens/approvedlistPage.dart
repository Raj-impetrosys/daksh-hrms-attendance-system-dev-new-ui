import 'dart:convert';
import 'package:dakshattendance/screens/checkin_screen.dart';
import 'package:dakshattendance/bloc/approval_list_bloc.dart';
import 'package:dakshattendance/const/global.dart';
import 'package:dakshattendance/model/approval_list_model.dart';
import 'package:dakshattendance/shared_preference/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ApprovedListPage extends StatefulWidget {
  final String? employeeid;
  final String? employeename;
  final String? tdate;
  final String? intime;
  final String? outtime;
  final String? requesttext;
  // final String doneMessage;
  ApprovedListPage({
    // required this.doneMessage,
    this.employeeid,
    this.employeename,
    this.tdate,
    this.intime,
    this.outtime,
    this.requesttext,
  });

  @override
  _ApprovedListPageState createState() => _ApprovedListPageState();
}

class _ApprovedListPageState extends State<ApprovedListPage> {
  String? currentdate;
  // TextEditingController _time = TextEditingController();
  // TextEditingController _messagetext = TextEditingController();

  var userData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData = json.decode(PrefObj.preferences!.get(PrefKeys.USERDATA));
    approvalListBloc.approvalListSink(widget.employeeid!);
  }

  var formatter = new DateFormat('dd-MM-yyyy');
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<DateTime> selectDate(BuildContext context, DateTime _date) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;
    }
    return _date;
  }

  late List<Future<dynamic>> ascending = [];
  var asc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff0082FF),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              // return CheckIn();
              return CheckIn(
                isBake: (value) {
                  approvalListBloc.approvalListSink(widget.employeeid!);
                },
              );
            },
          ));
        },
        child: Icon(
          Icons.add,
        ),
      ),
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        onTap: () {
          Navigator.pop(context);
        },
        title: Text(
          "View Approval List",
          style: AppBarStyle.textStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset("assets/images/homeBackground.png"),
          ),
          StreamBuilder<ApprovalListModel>(
            stream: approvalListBloc.approvalListStream,
            builder: (context,
                AsyncSnapshot<ApprovalListModel> approvalListsnapshot) {
              if (!approvalListsnapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(0xffEE2B7A)),
                  ),
                );
                // child: CircularProgressIndicator(
                //     valueColor: AlwaysStoppedAnimation(Color(0xffEE2B7A))))
              }
              // ascending = approvalListsnapshot as List<Future>;
              //  asc = approvalListsnapshot.data!.data!.sort((a,b) => a.dateofattendance!.compareTo(b.));
              return approvalListsnapshot.data!.data != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 43.0),
                      child: ListView.separated(
                        reverse: true,
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        itemCount:
                            approvalListsnapshot.data!.data!.reversed.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      ),
                                      color: AppColor.buttonColor2
                                          .withOpacity(0.05),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                                "${approvalListsnapshot.data!.data![index].requesttext}"),
                                          ),
                                        ),
                                        // Spacer(),
                                        Center(
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Date",
                                              style: TextStyle(
                                                  color: Color(0xff6F6C6C),
                                                  fontFamily: "popin",
                                                  fontSize: 10.sp),
                                            ),
                                            Text(
                                              "${approvalListsnapshot.data!.data![index].dateofattendance}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "popin",
                                                  fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Center(
                                          child: approvalListsnapshot
                                                          .data!
                                                          .data![index]
                                                          .intime ==
                                                      '0.0' ||
                                                  approvalListsnapshot
                                                          .data!
                                                          .data![index]
                                                          .intime ==
                                                      '0:00'
                                              ? Column(
                                                  children: [
                                                    Text("Check Out",
                                                        style: TextStyle(
                                                            fontFamily: 'popin',
                                                            fontSize: 13)),
                                                    Text(
                                                        "${approvalListsnapshot.data!.data![index].outtime}",
                                                        style: TextStyle(
                                                            fontFamily: 'popin',
                                                            fontSize: 13)),
                                                  ],
                                                )
                                              : approvalListsnapshot
                                                              .data!
                                                              .data![index]
                                                              .outtime ==
                                                          '0.0' ||
                                                      approvalListsnapshot
                                                              .data!
                                                              .data![index]
                                                              .outtime ==
                                                          '0:00'
                                                  ? Column(
                                                      children: [
                                                        Text("Check In",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'popin',
                                                                fontSize: 13)),
                                                        SizedBox(width: 2),
                                                        Text(
                                                            "${approvalListsnapshot.data!.data![index].intime}",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'popin',
                                                                fontSize: 13)),
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        Text("Check In/Out",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'popin',
                                                                fontSize: 13)),
                                                        SizedBox(width: 2),
                                                        Text(
                                                            "${approvalListsnapshot.data!.data![index].intime} / ${approvalListsnapshot.data!.data![index].outtime} ",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'popin',
                                                                fontSize: 13)),
                                                      ],
                                                    ),
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            Text(
                                              "Status",
                                              style: TextStyle(
                                                  color: Color(0xff6F6C6C),
                                                  fontFamily: "popin",
                                                  fontSize: 10.sp),
                                            ),
                                            Text(
                                              " ${approvalListsnapshot.data!.data![index].isapproved}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "popin",
                                                  fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 0.0,
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                        "${approvalListsnapshot.data!.message}",
                        style: TextStyle(fontFamily: 'popin', fontSize: 13),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
