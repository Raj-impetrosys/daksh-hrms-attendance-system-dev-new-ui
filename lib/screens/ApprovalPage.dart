// import 'dart:convert';
// import 'package:dakshattendance/const/global.dart';
// import 'package:dakshattendance/model/approval_check_in_model.dart';
// import 'package:dakshattendance/model/approval_check_out_model.dart';
// import 'package:dakshattendance/repository/repository.dart';
// import 'package:dakshattendance/shared_preference/pref_keys.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ApprovalPage extends StatefulWidget {
//   final Function isBake;
//   ApprovalPage({required this.isBake});
//   @override
//   _ApprovalPageState createState() => _ApprovalPageState();
// }

// class _ApprovalPageState extends State<ApprovalPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final _repository = Repository();
//   DateTime? currentdate;

//   TextEditingController _messagetext = TextEditingController();
//   TextEditingController _time = TextEditingController();

//   DateTime nows = DateTime.now();

//   String? _chosenValue = 'Check In';
//   var userData;

//   bool autoValidate = false;
//   bool _validate = false;
//   bool _validate1 = false;

//   @override
//   void initState() {
//     super.initState();
//     userData = json.decode(PrefObj.preferences!.get(PrefKeys.USERDATA));
//     time = '${nows.hour}:${nows.minute}';
//   }

//   bool isTimeCheck = false;

//   var formatter = new DateFormat('dd-MM-yyyy');
//   DateTime fromDate =
//       DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

//   Future<DateTime> selectDate(BuildContext context, DateTime _date) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _date,
//       firstDate: DateTime(2018),
//       lastDate: DateTime(
//           DateTime.now().year, DateTime.now().month, DateTime.now().day),
//     );

//     if (picked != null) {
//       _date = picked;
//     }
//     return _date;
//   }

//   String? time;
//   String? message;

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         widget.isBake(true);
//         return true;
//       },
//       child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: Container(
//             child: Stack(
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                           colors: [Color(0xffEE2B7A), Color(0xff6C2E91)])),
//                 ),
//                 Center(
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 40),
//                       Padding(
//                         padding: EdgeInsets.all(10.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             IconButton(
//                                 onPressed: () {
//                                   widget.isBake(true);
//                                   Navigator.pop(context);
//                                 },
//                                 icon: Icon(
//                                   Icons.arrow_back_ios,
//                                   color: Colors.white,
//                                 )),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 50),
//                               child: Text(
//                                 'Ask For Approval',
//                                 style: TextStyle(
//                                     color: AppColor.containerColor,
//                                     fontFamily: 'popin',
//                                     fontSize: 18),
//                               ),
//                             ),
//                             Container(),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 30),
//                       Expanded(
//                         child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(40),
//                                   topRight: Radius.circular(40)),
//                               color: AppColor.containerColor,
//                             ),
//                             child: Form(
//                               key: _formKey,
//                               child: Padding(
//                                 padding: EdgeInsets.all(15),
//                                 child: Column(
//                                   children: [
//                                     const SizedBox(
//                                       height: 25,
//                                     ),
//                                     Center(
//                                       child: Container(
//                                         padding:
//                                             EdgeInsets.only(left: 15, right: 5),
//                                         height: 50,
//                                         width: 120,
//                                         child: _dropDownButton(),
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           color: AppColor.buttonColor,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () async {
//                                         _showIOS_DatePicker(context);
//                                         setState(() {
//                                           isTimeCheck = true;
//                                         });
//                                       },
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             boxShadow: const [
//                                               BoxShadow(
//                                                 color: Colors.grey,
//                                                 blurRadius: 1.2,
//                                                 spreadRadius: 1.0,
//                                               ), //BoxShadow
//                                               BoxShadow(
//                                                 color: AppColor.containerColor,
//                                                 offset: Offset(0.0, 0.0),
//                                                 blurRadius: 0.0,
//                                                 spreadRadius: 0.0,
//                                               ),
//                                             ],
//                                             borderRadius:
//                                                 BorderRadius.circular(15),
//                                             color: AppColor.containerColor),
//                                         child: Padding(
//                                           padding: EdgeInsets.only(left: 8),
//                                           child: TextFormField(
//                                             // onChanged: (value) {
//                                             //   // if (value.isEmpty ||
//                                             //   //     // ignore: unnecessary_null_comparison
//                                             //   //     value == null) {
//                                             //   //   _validate = true;
//                                             //   // } else {
//                                             //   //   _validate = false;
//                                             //   // }
//                                             // },
//                                             controller: _time,
//                                             enabled: true,
//                                             onTap: () {
//                                               FocusScope.of(context)
//                                                   .requestFocus(FocusNode());
//                                               _showIOS_DatePicker(context);
//                                             },
//                                             decoration: InputDecoration(
//                                                 errorText: _validate
//                                                     ? "Time Can't be empty"
//                                                     : null,
//                                                 hintText: isTimeCheck
//                                                     ? time
//                                                     : "Enter Time",
//                                                 prefixIcon: GestureDetector(
//                                                     onTap: () async {
//                                                       _showIOS_DatePicker(
//                                                           context);
//                                                     },
//                                                     child: Icon(Icons.alarm)),
//                                                 hintStyle: TextStyle(
//                                                     fontFamily: "popin"),
//                                                 floatingLabelBehavior:
//                                                     FloatingLabelBehavior
//                                                         .always,
//                                                 border: InputBorder.none),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       height: 100,
//                                       decoration: BoxDecoration(
//                                           boxShadow: const [
//                                             BoxShadow(
//                                               color: Colors.grey,
//                                               blurRadius: 1.2,
//                                               spreadRadius: 1.0,
//                                             ), //BoxShadow
//                                             BoxShadow(
//                                               color: AppColor.containerColor,
//                                               offset: Offset(0.0, 0.0),
//                                               blurRadius: 0.0,
//                                               spreadRadius: 0.0,
//                                             ),
//                                           ],
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           color: AppColor.containerColor),
//                                       child: Padding(
//                                         padding: EdgeInsets.only(left: 8),
//                                         child: TextFormField(
//                                           validator: (value) {
//                                             if (value == null ||
//                                                 value.isEmpty) {
//                                               return "Message Can\'t be empty";
//                                             }
//                                             return null;
//                                           },
//                                           controller: _messagetext,
//                                           decoration: InputDecoration(
//                                               // errorText: _validate1
//                                               //     ? "Enter Message"
//                                               //     : null,
//                                               hintText: ' Enter Message Here',
//                                               hintStyle: TextStyle(
//                                                   fontFamily: "popin"),
//                                               floatingLabelBehavior:
//                                                   FloatingLabelBehavior.always,
//                                               border: InputBorder.none),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         _validateInputs();
//                                         FocusScope.of(context)
//                                             .requestFocus(FocusNode());
//                                         message = _messagetext.text;
//                                         if (_time.text.isNotEmpty) {
//                                           if (_formKey.currentState!
//                                               .validate()) {
//                                             message = _messagetext.text;
//                                             FocusScope.of(context)
//                                                 .requestFocus(FocusNode());
//                                             _chosenValue == 'Check In'
//                                                 ? onapprovalcheckinapi()
//                                                 : onapprovalcheckoutapi();
//                                           }
//                                         } else {
//                                           if (_time.text.isEmpty) {
//                                             _time.text.isEmpty
//                                                 ? _validate = true
//                                                 : _validate = false;
//                                           }
//                                           if (_formKey.currentState!
//                                               .validate()) {
//                                             message = _messagetext.text;
//                                             FocusScope.of(context)
//                                                 .requestFocus(FocusNode());
//                                           }

//                                           setState(() {});
//                                         }
//                                       },
//                                       child: Center(
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               gradient: LinearGradient(colors: [
//                                                 Color(0xffEE2B7A),
//                                                 Color(0xff6C2E91)
//                                               ]),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Colors.grey,
//                                                   blurRadius: 8,
//                                                   offset: Offset(
//                                                       2, 4), // Shadow position
//                                                 ),
//                                               ],
//                                               color: AppColor.buttonColor,
//                                               borderRadius:
//                                                   BorderRadius.circular(20)),
//                                           height: 50,
//                                           width: 210,
//                                           child: Center(
//                                               child: Text("SUBMIT",
//                                                   style: TextStyle(
//                                                       fontFamily: 'popin',
//                                                       fontSize: 18,
//                                                       color: AppColor
//                                                           .containerColor))),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () async {
//                     fromDate = await selectDate(context, fromDate);
//                     setState(() {});
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 115),
//                     child: Align(
//                       alignment: Alignment.topCenter,
//                       child: Container(
//                         width: 170,
//                         decoration: BoxDecoration(
//                             boxShadow: const [
//                               BoxShadow(
//                                 color: Colors.grey,
//                                 blurRadius: 1.2,
//                                 spreadRadius: 1.0,
//                               ), //BoxShadow
//                               BoxShadow(
//                                 color: AppColor.containerColor,
//                                 offset: Offset(0.0, 0.0),
//                                 blurRadius: 0.0,
//                                 spreadRadius: 0.0,
//                               ),
//                             ],
//                             borderRadius: BorderRadius.circular(15),
//                             color: AppColor.containerColor),
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 8),
//                           child: TextField(
//                             enabled: false,
//                             // controller: _messagetext,
//                             decoration: InputDecoration(
//                                 hintText: '${formatter.format(fromDate)}',
//                                 prefixIcon: GestureDetector(
//                                     onTap: () async {
//                                       setState(() {});
//                                     },
//                                     child: Icon(
//                                       Icons.calendar_today,
//                                     )),
//                                 hintStyle: TextStyle(fontFamily: "popin"),
//                                 floatingLabelBehavior:
//                                     FloatingLabelBehavior.always,
//                                 border: InputBorder.none),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }

// // ------------------------ TIME PICKER --------------------
//   void _showIOS_DatePicker(ctx) {
//     showCupertinoModalPopup(
//       context: ctx,
//       builder: (_) => Container(
//         height: MediaQuery.of(context).size.height / 3.2,
//         color: Colors.white,
//         child: Scaffold(
//           body: Column(
//             children: [
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 60),
//                     child: Text(
//                       "Select Time",
//                       style: TextStyle(
//                         fontFamily: 'popin',
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: Container(
//                       height: 30,
//                       width: 60,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50),
//                           color: Colors.pink),
//                       child: Text(
//                         "Done",
//                         style: TextStyle(
//                             fontFamily: 'popin',
//                             fontSize: 13,
//                             color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height / 4,
//                 child: CupertinoDatePicker(
//                   initialDateTime: DateTime.now(),
//                   use24hFormat: true,
//                   mode: CupertinoDatePickerMode.time,
//                   onDateTimeChanged: (val) {
//                     setState(
//                       () {
//                         time = '${val.hour}:${val.minute}';
//                         isTimeCheck = true;
//                         _time.text = '${val.hour}:${val.minute}';
//                         if (_time.text.isEmpty) {
//                           _validate = true;
//                         } else {
//                           _validate = false;
//                         }
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ------------------------- DROPDOWN BUTTON --------------------
//   Widget _dropDownButton() {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton<String>(
//         value: _chosenValue,
//         //elevation: 5,
//         style: TextStyle(color: Colors.black, fontFamily: 'popin'),
//         items: <String>['Check In', 'Check Out']
//             .map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(
//               value,
//               style:
//                   TextStyle(fontFamily: 'popin', fontWeight: FontWeight.w500),
//             ),
//           );
//         }).toList(),
//         hint: Text(
//           "Check In",
//           style: TextStyle(
//               color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//         onChanged: (value) {
//           setState(() {
//             _chosenValue = value;
//           });
//         },
//       ),
//     );
//   }

// // ---------------------- ON APPROVAL CHECK IN API ------------------
//   dynamic onapprovalcheckinapi() async {
//     Loader().showLoader(context);
//     final ApprovalCheckInModel isapprovalcheckin =
//         await _repository.onApprovalCheckIn(
//             userData['emp_code'],
//             userData['username'],
//             formatter.format(fromDate),
//             time!,
//             '0:00',
//             message!);
//     if (isapprovalcheckin.status == "Success") {
//       Loader().hideLoader(context);
//       var snackBar = SnackBar(
//           behavior: SnackBarBehavior.floating,
//           duration: Duration(seconds: 1),
//           content: Text(isapprovalcheckin.message!,
//               style: TextStyle(
//                   fontFamily: 'popin',
//                   fontSize: 18,
//                   color: AppColor.containerColor)));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       _messagetext.clear();
//       _time.clear();
//     } else {
//       var snackBar = SnackBar(
//           behavior: SnackBarBehavior.floating,
//           duration: Duration(seconds: 1),
//           content: Text(isapprovalcheckin.message!,
//               style: TextStyle(
//                   fontFamily: 'popin',
//                   fontSize: 18,
//                   color: AppColor.containerColor)));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       Loader().hideLoader(context);

//       print(false);
//     }
//   }

// // ---------------------- ON APPROVAL CHECK OUT API ------------------
//   dynamic onapprovalcheckoutapi() async {
//     Loader().showLoader(context);
//     final ApprovalCheckOutModel isapprovalcheckout =
//         await _repository.onApprovalCheckOut(
//             userData['emp_code'],
//             userData['username'],
//             formatter.format(fromDate),
//             '0:00',
//             time!,
//             message!);
//     if (isapprovalcheckout.status == "Success") {
//       SnackBar(content: Text("Daily Attendance Approval Request Added"));
//       Loader().hideLoader(context);
//       var snackBar = SnackBar(
//           behavior: SnackBarBehavior.floating,
//           duration: Duration(seconds: 1),
//           content: Text(isapprovalcheckout.message!,
//               style: TextStyle(
//                   fontFamily: 'popin',
//                   fontSize: 18,
//                   color: AppColor.containerColor)));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       _messagetext.clear();
//       _time.clear();
//     } else {
//       Loader().hideLoader(context);
//       var snackBar = SnackBar(
//           behavior: SnackBarBehavior.floating,
//           duration: Duration(seconds: 1),
//           content: Text(isapprovalcheckout.message!,
//               style: TextStyle(
//                   fontFamily: 'popin',
//                   fontSize: 18,
//                   color: AppColor.containerColor)));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       print(false);
//     }
//   }

//   //================================ Check Validation ============================//

//   void _validateInputs() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//     } else {
//       setState(() {
//         autoValidate = true;
//       });
//     }
//   }
// }
