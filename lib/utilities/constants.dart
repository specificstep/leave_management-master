import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
); 

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white54,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);


Future<bool> check() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    print("network available using mobile");
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    print("network available using wifi");
    return true;
  } else {
    print("network not available");
    return false;
  }

}