import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/login_screen_old.dart';
import 'package:flutter_app/Logout/LogoutBloc.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LogoutScreen();

}

class _LogoutScreen extends State<LogoutScreen> {

  String token = "";
  String user_id = "";
  LogoutBloc _logoutBloc = LogoutBloc();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       alignment: Alignment.center,
       child: Text(""),

     ),
   );
  }

  @override
  void initState() {
    _getPrefValue();
    // _exitApp();
    super.initState();
  }

  _calllogout() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _logoutBloc.executelogout(LeaveListRequest(user_id, token));
        getLogoutResponse(context);
        print('connected');
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "Please Check Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print('not connected');
    }

    print("logout");
  }

  Future<void> _getPrefValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(ApiConstants.token);
    user_id = prefs.getString(ApiConstants.user_id);
    new Future.delayed(Duration.zero,() {
      // _exitApp(context);
      _showDialog(context);
    });
    print("token  :" + token);
    print("userid  :" + user_id);
  }

}
void _showDialog(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alert !!'),
          content: Text('Do you sure want to logout this application?'),
          // content: Text('Pin entered is $value'),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                print("you choose no");
                Navigator.pop(context, false);
                SharedPreferences prefs = await SharedPreferences.getInstance();

                if(prefs.getString(ApiConstants.rolename)=="employee" || prefs.getString(ApiConstants.rolename)==null){
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => HomePage()));
                } else {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => AdminHomePage()));
                }
                // Navigator.pushReplacement(
                //     context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text('No'),
            ),
            FlatButton(
                child: Text('Yes'),
                onPressed: () async {
                  Navigator.pop(context, false);
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  prefs.setString(ApiConstants.check_inout_status, "check_in");
                  prefs.setBool(ApiConstants.loggedin, false);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen_old()),
                      ModalRoute.withName("/Home"));
                }),
          ],
        );
      });
}

void getLogoutResponse(BuildContext context) {
  LogoutBloc _logoutBloc = LogoutBloc();
  _logoutBloc.subject.listen((value) async {
    print("Email:${value.status}");
    if (value.status == Status.SUCCESS) {
      if (value.data.Result.status == "1") {
        print("status_fromres:${value.data.Result.status}");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(ApiConstants.loggedin, true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen_old()));
      } else {
        String message = value.data.Result.message;
        SharedPreferences prefs =
        await SharedPreferences.getInstance();
        prefs.setString(
            ApiConstants.check_inout_status, "check_in");
        prefs.setBool(ApiConstants.loggedin, false);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) => LoginScreen_old()),
            ModalRoute.withName("/Home"));
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // _showToast(message);
        // _showDialog(context, message);
      }
    }
  });
}
