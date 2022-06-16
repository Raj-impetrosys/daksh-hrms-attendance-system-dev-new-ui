// ignore_for_file: unused_import, deprecated_member_use

import 'package:dakshattendance/const/global.dart';
import 'package:dakshattendance/screens/homepage.dart';
import 'package:dakshattendance/screens/login_page.dart';
import 'package:dakshattendance/shared_preference/pref_keys.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class MyApp extends StatefulWidget {
  const MyApp({required this.prefs});
  final Box prefs;

  @override
  _MyAppState createState() => _MyAppState(prefs: prefs);
}

class _MyAppState extends State<MyApp> {
  String notificationMsg = "";

  _MyAppState({required this.prefs});
  Box prefs;

  @override
  void initState() {
    super.initState();
    // FirebaseMessaging.instance.getInitialMessage().then((event) {
    //   setState(() {
    //     notificationMsg =
    //         "${event!.notification!.title} ${event.notification!.body}";
    //   });
    // });
    // FirebaseMessaging.onMessage.listen((event) {
    //   setState(() {
    //     notificationMsg =
    //         "${event.notification!.title} ${event.notification!.body}";
    //   });
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   setState(() {
    //     notificationMsg =
    //         "${event.notification!.title} ${event.notification!.body}";
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () {
        return MaterialApp(
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(context);
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: MediaQuery(
                data: mediaQueryData.copyWith(textScaleFactor: 1.0),
                child: child!,
              ),
            );
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColor.appColor,
            appBarTheme: Theme.of(context)
                .appBarTheme
                .copyWith(brightness: Brightness.light),
            fontFamily: 'popin',
            textTheme: Theme.of(context).textTheme.apply(fontFamily: 'popin'),
          ),
          home: _dicedeScreen(prefs),
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

// SPLASH SCREEN -------------
Widget _dicedeScreen(Box prefs) {
  PrefObj.preferences = prefs;
  return prefs.containsKey(PrefKeys.USERDATA) ? MyHomepage() : LoginPage();
}
