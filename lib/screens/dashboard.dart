// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:dakshattendance/const/global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  final String employeeid;
  final String employeename;
  final String tdate;
  final String intime;
  final String outtime;
  final String latitude;
  final String longitude;
  final String location;

  const Dashboard(
      {required this.employeeid,
      required this.employeename,
      required this.tdate,
      required this.intime,
      required this.outtime,
      required this.latitude,
      required this.longitude,
      required this.location});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? _chosenValue;

  String getSystemdate() {
    var now = DateTime.now();
    return DateFormat("dd/MM/yyyy").format(now);
  }

  String getSystemtime() {
    var now = DateTime.now();
    return DateFormat("hh : mm : ss").format(now);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffEE2B7A), Color(0xff6C2E91)])),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Row(
                              children: [
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  widget.employeeid.toString(),
                                  style: TextStyle(
                                      color: AppColor.containerColor,
                                      fontFamily: 'popin',
                                      fontSize: 17),
                                ),
                                Text("${getSystemdate()}",
                                    style: TextStyle(
                                        color: AppColor.containerColor,
                                        fontFamily: 'popin',
                                        fontSize: 17)),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(50)),
                          color: AppColor.containerColor,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 3,
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.6),
                                              width: 1)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // ignore: prefer_const_constructors
                                                Text(
                                                  "Date : ",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xffEE2B7A),
                                                      fontFamily: 'popin',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                // ignore: prefer_const_constructors
                                                Text(
                                                  "${DateTime.now().day}/" +
                                                      "${DateTime.now().month}/" +
                                                      "${DateTime.now().year}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Color(0xffEE2B7A),
                                                      fontFamily: 'popin'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("Check In : ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                'popin')),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        "${getSystemtime()} PM",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'popin'))
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("Location : ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.grey,
                                                            fontFamily:
                                                                'popin')),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text("123, XYZ Soc.,",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontFamily:
                                                                'popin'))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.grey.shade300,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text("Check Out : ",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'popin')),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                          "${getSystemtime()} PM",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'popin'))
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.5),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text("Location : ",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.grey,
                                                              fontFamily:
                                                                  'popin')),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("123, XYZ Soc.,",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontFamily:
                                                                  'popin'))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 80,
              top: 100,
              child: Center(
                child: Container(
                  height: 50,
                  width: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColor.buttonColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          flex: 2, child: Center(child: _dropDownButton())),
                      Text("|"),
                      Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text("Year"),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(60.0))),
                                          title: Text("Select Year"),
                                          content: Container(
                                            // Need to use container to add size constraint.
                                            width: 300,
                                            height: 300,
                                            child: YearPicker(
                                              firstDate: DateTime(
                                                  DateTime.now().year - 100, 1),
                                              lastDate: DateTime(
                                                  DateTime.now().year + 100, 1),
                                              initialDate: DateTime.now(),
                                              selectedDate: DateTime(2021),
                                              onChanged: (DateTime dateTime) {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.arrow_drop_down))
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDownButton() {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _chosenValue,
          //elevation: 5,
          //underline: ,
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
                style:
                    TextStyle(fontFamily: 'popin', fontWeight: FontWeight.w500),
              ),
            );
          }).toList(),
          hint: Text(
            "January",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          onChanged: (value) {
            setState(() {
              _chosenValue = value;
            });
          },
        ),
      ),
    );
  }
}
