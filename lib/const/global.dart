// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:dakshattendance/screens/login_page.dart';
import 'package:dakshattendance/shared_preference/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class AppColor {
  static const Color appColor = Color(0xff7A6565);
  static const Color buttonColor = Color(0xff00BCFF);
  static const Color buttonColor2 = Color(0xff0082FF);
  static const Color cardColor = Color(0xffB0B0B0);
  static const Color containerColor = Color(0xFFFFFFFF);
}

class PrefObj {
  static Box? preferences;
}

//----------------AppBar------------------ //
class MyAppBar extends AppBar {
  MyAppBar({Key? key, required Widget title, required Function() onTap})
      : super(
          key: key,
          title: title,
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.only(left: 12.0),
              margin: EdgeInsets.only(
                  left: 10.0, top: 16.0, bottom: 16.0, right: 8.0),
              child: Image.asset(
                "assets/images/back_arrow.png",
                height: 12.h,
                width: 15.w,
              ),
            ),
          ),
        );
}

class AppBarStyle {
  static TextStyle textStyle =
      TextStyle(fontFamily: "popin", fontSize: 20.sp, color: Colors.black);
}

// ------------- LOADER ----------  //
class Loader {
  void showLoader(BuildContext context) {
    showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(0xff00BCFF)),
                  ),
                ),
              )
            ],
          ));
        });
  }

  void hideLoader(BuildContext context) {
    Navigator.pop(context);
  }
}

// ------------------ SHOWDIALOG ---------------------
void showpopDialog(BuildContext context, String title, String body) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(body),
        // ignore: duplicate_ignore
        actions: <Widget>[
          FlatButton(
            child: const Text('NO'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // ignore: deprecated_member_use
          FlatButton(
            child: const Text('YES'),
            onPressed: () {
              PrefObj.preferences!.delete(PrefKeys.INTIME);
              PrefObj.preferences!.delete(PrefKeys.USERDATA);
              PrefObj.preferences!.delete(PrefKeys.EMPLOYEEDATA);
              PrefObj.preferences!.delete(PrefKeys.HRINTIME);
              PrefObj.preferences!.delete(PrefKeys.CURRENTDATE);
              // PrefObj.preferences!.delete(PrefKeys.OFFLINEDATA);
              // PrefObj.preferences!.delete(PrefKeys.Approved);
              PrefObj.preferences!.delete(PrefKeys.Request_Submitted);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      );
    },
  );
}

// ---------------- TextFormField whit suffix ----------------------//

class CustomeSuffixTextField extends StatefulWidget {
  final String hintText;
  final String prifixasset;
  final String suffixassets;
  final String suffixassets1;
  final TextEditingController controller;
  final bool? obscureText;
  final FocusNode focusNode;
  final Function()? onTap;

  const CustomeSuffixTextField({
    Key? key,
    required this.hintText,
    required this.prifixasset,
    required this.suffixassets,
    required this.suffixassets1,
    required this.controller,
    this.obscureText,
    required this.focusNode,
    required String? Function(dynamic value) validator,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomeSuffixTextField> createState() => _CustomeSuffixTextFieldState();
}

class _CustomeSuffixTextFieldState extends State<CustomeSuffixTextField> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      focusNode: widget.focusNode,
      controller: widget.controller,
      // onTap: onTap,
      obscureText: isClick == false ? true : false,
      decoration: InputDecoration(
        prefixIcon: Container(
          height: 10.h,
          width: 10.h,
          margin:
              EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.prifixasset),
            ),
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isClick == false ? isClick = true : isClick = false;
            });
          },
          child: isClick == false
              ? Container(
                  height: 10.h,
                  width: 10.h,
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.suffixassets),
                    ),
                  ),
                )
              : Container(
                  height: 10.h,
                  width: 10.h,
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.suffixassets1),
                    ),
                  ),
                ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffACB1C1), width: 1.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffACB1C1), width: 1.0),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: "prompt",
          fontSize: 14.sp,
          color: Colors.black,
        ),
      ),
    );
  }
}

// ---------------- TextFormField ----------------------//

class CustomeTextField extends StatelessWidget {
  final dynamic hintText;
  final String prifixasset;
  final Function()? onTap;
  final dynamic errorText;
  final bool? enable;
  final TextEditingController controller;
  final FocusNode focusNode;

  const CustomeTextField({
    Key? key,
    required this.hintText,
    required this.prifixasset,
    required this.controller,
    required this.focusNode,
    required String? Function(dynamic value) validator,
    this.onTap,
    this.errorText, this.enable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      textInputAction: TextInputAction.next,
      focusNode: focusNode,
      onTap: onTap,
      controller: controller,
      decoration: InputDecoration(
        errorText: errorText,
        prefixIcon: Container(
          height: 10.h,
          width: 10.h,
          padding: EdgeInsets.only(right: 20.0,left: 20.0),
          margin:
              EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 12.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(prifixasset),
            ),
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffACB1C1), width: 1.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffACB1C1), width: 1.0),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: "prompt",
          fontSize: 14.sp,
          color: Colors.black,
        ),
      ),
    );
  }
}

//------------------ Submit Button ----------------------//

class Button extends StatelessWidget {
  final String textName;
  final Function() onTap;
  const Button({Key? key, required this.textName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 60.0),
        child: Center(
            child: Text(
          textName,
          style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        )),
        height: 48.h,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff00BCFF), Color(0xff0082FF)]),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}

enum NetworkStatus { Online, Offline }

//------------------------DropDownMenu Items class ----------------//

class MenuItem {
  final String text;
  // final Image image;

  const MenuItem({
    required this.text,
    // required this.image,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [checkin];
  static const List<MenuItem> secondItems = [checkout];

  static const checkin = MenuItem(
    text: 'Check In',
    // image: Image(
    //   image: AssetImage("assets/images/check_in.png"),
    //   height: 24.0,
    //   width: 24.0,
    // ),
  );
  static const checkout = MenuItem(
    text: 'Chech Out',
    // image: Image(
    //   image: AssetImage("assets/images/check_out.png"),
    //   height: 24.0,
    //   width: 24.0,
    // ),
  );

  static Widget buildItem(MenuItem item) {
    return Text(
      item.text,
      style: const TextStyle(color: Colors.black, fontFamily: "prompt"),
    );
  }
}
