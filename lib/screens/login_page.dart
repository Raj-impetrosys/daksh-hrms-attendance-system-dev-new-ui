import 'dart:convert';

import 'package:dakshattendance/screens/homepage.dart';
import 'package:dakshattendance/const/global.dart';
import 'package:dakshattendance/model/login_model.dart';
import 'package:dakshattendance/repository/repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dakshattendance/shared_preference/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  TextEditingController password = TextEditingController();
  FocusNode passwordFocusNode = new FocusNode();
  bool autoValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  final _repository = Repository();
  bool isClick = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Image.asset("assets/images/loginbackground.png"),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 35.0, right: 35.0, top: 79.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/loginImage.png",
                          height: 210.h,
                          width: 290.w,
                        ),
                        const SizedBox(height: 70),
                        CustomeTextField(
                          hintText: "Enter UserId",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'User Id can\’t be empty';
                            }
                            return null;
                          },
                          prifixasset: "assets/images/email.png",
                          controller: emailController,
                          focusNode: emailFocusNode,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomeSuffixTextField(
                          hintText: "Enter Password",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password Can\'t be empty";
                            }
                            return null;
                          },
                          prifixasset: "assets/images/lock.png",
                          suffixassets: "assets/images/hidepassword.png",
                          suffixassets1: "assets/images/showpassword.png",
                          controller: password,
                          obscureText: true,
                          focusNode: passwordFocusNode,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: GestureDetector(
                            onTap: () => _launchURLBrowser(),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: AppColor.appColor),
                                textAlign: TextAlign.end,
                              )),
                            ),
                          ),
                        ),
                        Button(
                          textName: "Login",
                          onTap: () {
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => MyHomepage(),
                            //   ),
                            // );
                            _validateInputs();
                            if (_formKey.currentState!.validate()) {
                              onLoginAPI();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------- LOGIN API -------------------------

  dynamic onLoginAPI() async {
    Loader().showLoader(context);
    final LoginModel isLogin =
        await _repository.onLogin(emailController.text, password.text);
    if (isLogin.status == "Success") {
      PrefObj.preferences!.put(PrefKeys.USERDATA, json.encode(isLogin));
      Loader().hideLoader(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomepage(),
        ),
      );
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Opps', isLogin.message!);
    }
  }

  Future<void> _launchURLBrowser() async {
    const url = 'https://monalisaedc.com/hrms/emp-backend/forgotpswd.php';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    } else {
      setState(() {
        autoValidate = true;
      });
    }
  }
}
