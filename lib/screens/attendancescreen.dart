import 'package:dakshattendance/bloc/get_attendance_bloc.dart';
import 'package:dakshattendance/const/global.dart';
import 'package:dakshattendance/model/get_attendance_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Dashboard extends StatefulWidget {
  final String employeeid;
  final String month;
  final String year;

  Dashboard(
      {required this.employeeid, required this.month, required this.year});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? chosenValue = '10';
  String? selectValue = '';
  var currentYear = DateTime.now().year;
  // DateTime? _date;
  String finalDate = '';

  var formatter = new DateFormat('MM');
  var formatter1 = new DateFormat('MMMM-dd-yyyy');
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  // var frommonth = DateTime(DateTime.now().month);

  // Future<DateTime> selectDate(BuildContext context, DateTime _date) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: _date,
  //     firstDate: DateTime(2018),
  //     lastDate: DateTime(
  //         DateTime.now().year, DateTime.now().month, DateTime.now().day),
  //   );

  //   if (picked != null) {
  //     print("$picked");
  //     _date = picked;
  //   }
  //   return _date;
  // }

  // CalendarFormat _calendarFormat = CalendarFormat.month;
  // DateTime _focusedDay = DateTime.now();
  // DateTime? _selectedDay;

  String? time;

  dynamic selectedIndex = 2;
  dynamic selectedIndex1;
  List Months = [
    "JANUARY",
    "FEBRUARY",
    "MARCH",
    "APRIL",
    "MAY",
    "JUNE",
    "JULY",
    "AUGUST",
    "SEPTEMBER",
    "OCTOBER",
    "NOVEMBER",
    "DECEMBER"
  ];
  var currentdate;

  bool isClick = true;
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    selectValue = DateFormat.MMMM().format(DateTime(0, now.day));
    getAttendanceBloc.getAttendanceSink(
      widget.employeeid,
      now.year.toString(),
      now.month.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onTap: () {
          Navigator.pop(context);
        },
        title: Text(
          "Monthly Attendance",
          style: AppBarStyle.textStyle,
        ),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset("assets/images/loginbackground.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Container(
              height: 250.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: SfDateRangePicker(
                  monthFormat: "MMMM",
                  allowViewNavigation: false,
                  view: DateRangePickerView.year,
                  headerStyle: DateRangePickerHeaderStyle(
                    textAlign: TextAlign.left,
                    textStyle: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontFamily: "popin",
                    ),
                  ),
                  selectionMode: DateRangePickerSelectionMode.single,
                  selectionColor: Color(0xff0082FF).withOpacity(0.6),
                  selectionShape: DateRangePickerSelectionShape.circle,
                  selectionRadius: 20,
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    final dynamic value = args.value;
                    print(value);

                    chosenValue = formatter.format(value);
                    print(chosenValue);
                    getAttendanceBloc.getAttendanceSink(
                        widget.employeeid, currentYear.toString(), chosenValue!);
                    setState(() {
                      isClick = false;
                      currentdate == formatter.format(value)
                          ? isClick = true
                          : isClick = false;
                    });
                    currentdate = formatter.format(fromDate);
                    print(currentdate);
                    isClick == false ? print("Hello") : print("Byyy");
                  },
                  onViewChanged: (DateRangePickerViewChangedArgs args) {
                    final PickerDateRange visibleDates = args.visibleDateRange;
                    final DateRangePickerView view = args.view;
                  },
                  onSubmit: (test) {
                    print(test);
                  },
                  yearCellStyle: DateRangePickerYearCellStyle(
                    disabledDatesDecoration: BoxDecoration(
                        color: const Color(0xFFDFDFDF),
                        border: Border.all(color: Colors.black, width: 1),
                        shape: BoxShape.circle),
                    disabledDatesTextStyle: const TextStyle(color: Colors.black),
                    leadingDatesDecoration: BoxDecoration(
                        color: const Color(0xFFDFDFDF),
                        border: Border.all(color: Colors.black, width: 1),
                        shape: BoxShape.circle),
                    leadingDatesTextStyle: const TextStyle(color: Colors.black),
                    textStyle: const TextStyle(color: Colors.black),
                    todayCellDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: isClick == true
                          ? Color(0xff0082FF).withOpacity(0.6)
                          : Colors.transparent,
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    todayTextStyle: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          // ------------------------------------------------------------
          // ------------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.only(bottom: 130.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(
                  height: 10.0,
                  thickness: 1.0,
                  color: Color(0xff4B4B4B).withOpacity(0.2),
                ),
                SizedBox(height: 10.h,),
                Text(
                  "Attendance Data",
                  style: TextStyle(
                    fontFamily: "popin",
                    fontSize: 24.sp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10.h,),
                Divider(
                  height: 10.0,
                  thickness: 1.0,
                  color: Color(0xff4B4B4B).withOpacity(0.2),
                ),
              ],
            ),
          ),
          // -------------------------------------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.only(top: 350.0, left: 10.0, right: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 3),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10, right: 10, bottom: 10, top: 12),
                          child: StreamBuilder<GetAttendanceModel>(
                            stream: getAttendanceBloc.getAttenanceStream,
                            builder: (context,
                                AsyncSnapshot<GetAttendanceModel>
                                    getattendance) {
                              if (!getattendance.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        Color(0xffEE2B7A)),
                                  ),
                                );
                                // child: CircularProgressIndicator(
                                //     valueColor: AlwaysStoppedAnimation(Color(0xffEE2B7A))));
                              }
                              return getattendance.data!.attendancedata != null
                                  ? ListView.builder(
                                      itemCount: getattendance
                                          .data!.attendancedata!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              // side: BorderSide(
                                              //     color: Colors.grey
                                              //         .withOpacity(0.6),
                                              //     width: 1)),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Center(
                                                    child: Text(
                                                      'Date :  ${getattendance.data!.attendancedata![index].dateofattendance!} ${DateFormat('EEEE').format(DateTime.parse(getattendance.data!.attendancedata![index].dateofattendance!))}'
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xff4B4B4B),
                                                          fontFamily: 'popin'),
                                                    ),
                                                  ),
                                                ),
                                                ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: getattendance
                                                      .data!
                                                      .attendancedata![index]
                                                      .dateWiseData!
                                                      .length,
                                                  itemBuilder:
                                                      (context, indexss) {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  right: 10.0,
                                                                  top: 5.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "IN - OUT",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "popin",
                                                                    fontSize:
                                                                        14.sp,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Spacer(),
                                                              Text(
                                                                "${getattendance.data!.attendancedata![index].dateWiseData![indexss].intime.toString()} - ${getattendance.data!.attendancedata![index].dateWiseData![indexss].outtime.toString()}",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "popin",
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  right: 10.0,
                                                                  top: 10.0),
                                                          child: Text(
                                                            "location : ${getattendance.data!.attendancedata![index].dateWiseData![indexss].location.toString()}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "popin",
                                                              fontSize: 12.sp,
                                                              color: Color(
                                                                  0xff636262),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  top: 10.0,
                                                                  bottom: 10.0,
                                                                  right: 10.0),
                                                          child: Text(
                                                            "Status :  ${getattendance.data!.attendancedata![index].dateWiseData![indexss].isapproved}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "popin",
                                                              fontSize: 12.sp,
                                                              color: Color(
                                                                  0xff4B4B4B),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return Divider(
                                                        color: Colors
                                                            .grey.shade600);
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                        getattendance.data!.message!,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 125),
          //   child: Align(
          //     alignment: Alignment.topCenter,
          //     child: Container(
          //       alignment: Alignment.center,
          //       height: 50,
          //       width: 250,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(25),
          //         color: AppColor.buttonColor,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           SizedBox(
          //             width: 15,
          //           ),
          //           Expanded(
          //               flex: 2, child: Center(child: _dropDownButton())),
          //           Text("|"),
          //           Expanded(
          //             flex: 2,
          //             child: Row(
          //               children: [
          //                 SizedBox(width: 28),
          //                 Text(currentYear.toString(),
          //                     style: TextStyle(fontSize: 16)),
          //                 IconButton(
          //                     onPressed: () {
          //                       showDialog(
          //                         context: context,
          //                         builder: (BuildContext context) {
          //                           return AlertDialog(
          //                             shape: RoundedRectangleBorder(
          //                                 borderRadius: BorderRadius.all(
          //                                     Radius.circular(20.0))),
          //                             title: Text("Select Year"),
          //                             content: Container(
          //                               // Need to use container to add size constraint.
          //                               width: 300,
          //                               height: 300,
          //                               child: YearPicker(
          //                                 firstDate: DateTime(
          //                                     DateTime.now().year - 100, 1),
          //                                 lastDate: DateTime(
          //                                     DateTime.now().year + 100, 1),
          //                                 initialDate: DateTime.now(),
          //                                 selectedDate: DateTime(2021),
          //                                 onChanged: (DateTime dateTime) {
          //                                   currentYear = int.parse(
          //                                       dateTime.year.toString());
          //                                   getAttendanceBloc
          //                                       .getAttendanceSink(
          //                                           widget.employeeid,
          //                                           currentYear.toString(),
          //                                           chosenValue!);
          //                                   setState(() {});
          //                                   Navigator.pop(context);
          //                                 },
          //                               ),
          //                             ),
          //                           );
          //                         },
          //                       );
          //                     },
          //                     icon: Icon(
          //                       Icons.arrow_drop_down,
          //                       color: Colors.grey[700],
          //                     ))
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

//
  // ignore: unused_element
  Widget _dropDownButton() {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectValue,
          style: TextStyle(color: Colors.black, fontFamily: 'popin'),
          items: <String>[
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'popin',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            );
          }).toList(),
          hint: Text(
            "January",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'popin',
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          onChanged: (value) {
            setState(
              () {
                selectValue = value;
                if (value == 'January') {
                  chosenValue = "1";
                } else if (value == 'February') {
                  chosenValue = "2";
                } else if (value == 'March') {
                  chosenValue = "3";
                } else if (value == 'April') {
                  chosenValue = "4";
                } else if (value == 'May') {
                  chosenValue = "5";
                } else if (value == 'June') {
                  chosenValue = "6";
                } else if (value == 'July') {
                  chosenValue = "7";
                } else if (value == 'August') {
                  chosenValue = "8";
                } else if (value == 'September') {
                  chosenValue = "9";
                } else if (value == 'October') {
                  chosenValue = "10";
                } else if (value == 'November') {
                  chosenValue = "11";
                } else if (value == 'December') {
                  chosenValue = "12";
                }
                getAttendanceBloc.getAttendanceSink(
                    widget.employeeid, currentYear.toString(), chosenValue!);
              },
            );
          },
        ),
      ),
    );
  }
}
