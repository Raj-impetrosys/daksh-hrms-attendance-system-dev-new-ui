// import 'dart:async';
// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';

// enum NetworkStatus { Online, Offline }

// class NetworkStatusService {
//   StreamController<NetworkStatus> networkStatusController =
//       StreamController<NetworkStatus>();

//   NetworkStatusService() {
//     Connectivity().onConnectivityChanged.listen((status) {
//       networkStatusController.add(_getNetworkStatus(status));
//     });
//   }

//   NetworkStatus _getNetworkStatus(ConnectivityResult status) {
//     return status == ConnectivityResult.mobile ||
//             status == ConnectivityResult.wifi
//         ? NetworkStatus.Online
//         : NetworkStatus.Offline;
//   }
// }

// class NetworkAwareWidget extends StatelessWidget {
//   final Widget onlineChild;
//   final Widget offlineChild;

//   const NetworkAwareWidget(
//       {Key? key, required this.onlineChild, required this.offlineChild})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     NetworkStatus networkStatus = Provider.of<NetworkStatus>(context);
//     if (networkStatus == NetworkStatus.Online) {
//       return onlineChild;
//     } else {
//       _showToastMessage("Offline");
//       return offlineChild;
//     }
//   }

//   void _showToastMessage(String message) {
//     Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1);
//   }
// }
