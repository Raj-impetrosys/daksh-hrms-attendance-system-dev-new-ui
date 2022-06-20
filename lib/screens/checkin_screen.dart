// ignore_for_file: unused_element

import 'package:dakshattendance/calendery_library/util.dart';
import 'package:dakshattendance/const/global.dart';
import 'dart:convert';
import 'package:dakshattendance/model/approval_check_in_model.dart';
import 'package:dakshattendance/model/approval_check_out_model.dart';
import 'package:dakshattendance/repository/repository.dart';
import 'package:dakshattendance/shared_preference/pref_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class CheckIn extends StatefulWidget {
  final Function isBake;
  CheckIn({required this.isBake});

  @override
  _CheckInState createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _repository = Repository();
  DateTime? currentdate;

  TextEditingController _messagetext = TextEditingController();
  TextEditingController _time = TextEditingController();
  TextEditingController _inOut = TextEditingController();

  DateTime nows = DateTime.now();

  // String? _chosenValue = 'Check In';
  var userData;

  bool autoValidate = false;
  @override
  void initState() {
    super.initState();
    userData = json.decode(PrefObj.preferences!.get(PrefKeys.USERDATA));
    _time.text = '${nows.hour}:${nows.minute}';
  }

  bool isTimeCheck = false;

  var formatter = new DateFormat('dd-MM-yyyy');
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<DateTime> selectDate(BuildContext context, DateTime _date) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
    );

    if (picked != null) {
      _date = picked;
    }
    return _date;
  }

  // String? time;
  // String? message;

  //----------------------------------------//
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String dropdownValue = 'Enter Your Activity';
  var MyItems = ["Enter Your Activity", "Check In", "Check Out"];
  var Items = ["Select you Data", "Check In", "Check Out"];

  var selectedValue;

  String _text = "Enter Your Activity";

  FocusNode checkFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  FocusNode msgFocusNode = FocusNode();
  dynamic checkData;

  bool isClick = false;

  String dropdownvalue = 'Item 1';
  // late ProgrammingLanguage selectedLanguage;

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onTap: () {
          Navigator.pop(context);
        },
        title: Text(
          "Ask For Approval",
          style: AppBarStyle.textStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset("assets/images/loginbackground.png"),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      children: [
                        TableCalendar(
                          firstDay: kFirstDay,
                          lastDay: kLastDay,
                          focusedDay: _focusedDay,
                          startingDayOfWeek: StartingDayOfWeek.sunday,
                          calendarStyle: CalendarStyle(),
                          headerStyle: HeaderStyle(
                              headerPadding:
                                  EdgeInsets.only(left: 20.0, bottom: 30.0),
                              leftChevronVisible: false,
                              formatButtonShowsNext: true,
                              titleTextStyle: TextStyle(
                                fontFamily: "popin",
                                fontSize: 18.sp,
                                color: Colors.black,
                              ),
                              rightChevronIcon: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ))),
                          calendarFormat: _calendarFormat,
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            if (!isSameDay(_selectedDay, selectedDay)) {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                                // fromDate = await selectDate(context, fromDate);
                                // setState(() {});
                                // print("=================>$focusedDay");
                                print("=================>$selectedDay");
                                //  chosenValue = formatter.format(_focusedDay);
                              });
                            }
                          },
                          onFormatChanged: (format) {
                            if (_calendarFormat != format) {
                              // Call `setState()` when updating calendar format
                              setState(() {
                                _calendarFormat = format;
                              });
                            }
                          },
                          onPageChanged: (focusedDay) {
                            // No need to call `setState()` here
                            _focusedDay = focusedDay;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    TextFormField(
                      // enabled: false,
                      readOnly: true,
                      enableInteractiveSelection: false,
                      textInputAction: TextInputAction.done,
                      focusNode: checkFocusNode,
                      controller: _inOut,
                      onTap: () {
                        setState(() {
                          // isClick == false ? isClick = true : isClick = false;
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return Column(
                                  // crossAxisAlignment: CrossAxisAlignment,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 18.h,
                                    ),
                                    Center(
                                      child: Text(
                                        "Enter Your Activity",
                                        style: AppBarStyle.textStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Center(
                                      child: Text(
                                        "select Your Activity",
                                        style: TextStyle(
                                          fontFamily: "popin",
                                          fontSize: 12.sp,
                                          color: Color(0xff636262),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 35.0, bottom: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(
                                            () {
                                              _text = "Check In";
                                              // _chosenValue = _text;
                                              _inOut.text = _text;
                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/checkin.png",
                                              height: 26.h,
                                              width: 26.w,
                                            ),
                                            SizedBox(
                                              width: 25.0,
                                            ),
                                            Text(
                                              "Check In",
                                              style: TextStyle(
                                                  fontFamily: "prompt",
                                                  fontSize: 16.sp,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 10.0,
                                      thickness: 1.5,
                                      color: Color(0xff636262).withOpacity(0.2),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40.0, top: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(
                                            () {
                                              _text = "Check Out";
                                              // _chosenValue = _text;
                                              _inOut.text = _text;
                                            },
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/checkout.png",
                                              height: 26.h,
                                              width: 26.w,
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            Text(
                                              "Check Out",
                                              style: TextStyle(
                                                  fontFamily: "prompt",
                                                  fontSize: 16.sp,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50.h,
                                    ),
                                  ],
                                );
                              });
                        });
                      },
                      // obscureText: isClick == false ? true : false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Activity Can\'t be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          height: 10.h,
                          width: 10.h,
                          margin: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/fingerprint.png"),
                            ),
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isClick;
                              // isClick == false ? isClick = true : isClick = false;
                            });
                          },

                          // child: _dropDownButton(),
                          child: Container(
                            height: 10.h,
                            width: 10.h,
                          ),
                        ),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffACB1C1), width: 1.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffACB1C1), width: 1.5),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: " ${_text}",
                        hintStyle: TextStyle(
                          fontFamily: "prompt",
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () async {
                        _showIOS_DatePicker(context);
                        setState(() {
                          isTimeCheck = true;
                        });
                      },
                      child: CustomeTextField(
                        // enable: false,
                        readOnly: true,
                        hintText: isTimeCheck ? _time.text : " Enter Time",
                        prifixasset: "assets/images/time.png",
                        controller: _time,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _showIOS_DatePicker(context);
                        },
                        focusNode: dateFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Date & Time Can\'t be empty";
                          }
                          return null;
                        },
                        // errorText: _validate ? "Time Can't be empty" : null,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    CustomeTextField(
                      hintText: " Enter Message",
                      prifixasset: "assets/images/speech-bubble.png",
                      controller: _messagetext,
                      // errorText: _validate ? "Enter Message" : null,
                      focusNode: msgFocusNode,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Message Can\'t be empty";
                        }
                        return null;
                      },
                    ),
                    Button(
                      textName: "Submit",
                      onTap: () {
                        // print(_formKey.currentState!.validate());
                        // _validateInputs();
                        FocusScope.of(context).requestFocus(FocusNode());
                        // message = _messagetext.text;
                        if (_time.text.isNotEmpty) {
                          if (_formKey.currentState!.validate()) {
                            // message = _messagetext.text;
                            // FocusScope.of(context).requestFocus(FocusNode());
                            if (_selectedDay == null) {
                              Fluttertoast.showToast(
                                  msg: 'Please select a date...');
                            } else {
                              _inOut.text == 'Check In'
                                  ? onapprovalcheckinapi()
                                  : onapprovalcheckoutapi();
                            }

                            print(_inOut.text);
                          }
                        } else {
                          // if (_time.text.isEmpty) {
                          //   _time.text.isEmpty
                          //       ? _validate = true
                          //       : _validate = false;
                          // }
                          // if (_formKey.currentState!.validate()) {
                          //   // message = _messagetext.text;
                          //   FocusScope.of(context).requestFocus(FocusNode());
                          // }

                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------ TIME PICKER --------------------
  void _showIOS_DatePicker(ctx) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height / 3.1,
        color: Colors.white,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Time",
                      style: TextStyle(
                        fontFamily: 'popin',
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 30,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xff00BCFF)),
                        child: Text(
                          "Done",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'popin',
                              fontSize: 13.sp,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  use24hFormat: true,
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (val) {
                    setState(
                      () {
                        // time = '${val.hour}:${val.minute}';
                        isTimeCheck = true;
                        _time.text = '${val.hour}:${val.minute}';
                        // if (_time.text.isEmpty) {
                        //   _validate = true;
                        // } else {
                        //   _validate = false;
                        // }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------- DROPDOWN BUTTON --------------------
  Widget _dropDownButton() {
    return DropdownButton(
      // Initial Value
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Enter Your Activity', 'Check In', 'Check Out']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

// ---------------------- ON APPROVAL CHECK IN API ------------------
  dynamic onapprovalcheckinapi() async {
    Loader().showLoader(context);
    final ApprovalCheckInModel isapprovalcheckin =
        await _repository.onApprovalCheckIn(
            userData['emp_code'],
            userData['username'],
            formatter.format(_selectedDay!),
            _time.text,
            '0:00',
            _messagetext.text);
    if (isapprovalcheckin.status == "Success") {
      Loader().hideLoader(context);
      var snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          content: Text(isapprovalcheckin.message!,
              style: TextStyle(
                  fontFamily: 'popin',
                  fontSize: 18,
                  color: AppColor.containerColor)));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _messagetext.clear();
      _time.clear();
    } else {
      var snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          content: Text(isapprovalcheckin.message!,
              style: TextStyle(
                  fontFamily: 'popin',
                  fontSize: 18,
                  color: AppColor.containerColor)));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Loader().hideLoader(context);

      print(false);
    }
  }

// ---------------------- ON APPROVAL CHECK OUT API ------------------
  dynamic onapprovalcheckoutapi() async {
    Loader().showLoader(context);
    final ApprovalCheckOutModel isapprovalcheckout =
        await _repository.onApprovalCheckOut(
            userData['emp_code'],
            userData['username'],
            formatter.format(_selectedDay!),
            '0:00',
            _time.text,
            _messagetext.text);
    if (isapprovalcheckout.status == "Success") {
      SnackBar(content: Text("Daily Attendance Approval Request Added"));
      Loader().hideLoader(context);
      var snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          content: Text(isapprovalcheckout.message!,
              style: TextStyle(
                  fontFamily: 'popin',
                  fontSize: 18,
                  color: AppColor.containerColor)));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _messagetext.clear();
      _time.clear();
    } else {
      Loader().hideLoader(context);
      var snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          content: Text(isapprovalcheckout.message!,
              style: TextStyle(
                  fontFamily: 'popin',
                  fontSize: 18,
                  color: AppColor.containerColor)));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(false);
    }
  }

  //================================ Check Validation ============================//

  // void _validateInputs() {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //   } else {
  //     setState(() {
  //       autoValidate = true;
  //     });
  //   }
  // }
}
