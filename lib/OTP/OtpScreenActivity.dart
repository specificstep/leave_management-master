import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/OTP/OTPDoneRequest.dart';
import 'package:flutter_app/OTP/OtpBloc.dart';
import 'package:flutter_app/ResendOTP/ResendOTPRequest.dart';
import 'package:flutter_app/ResendOTP/ResendOtpBloc.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'OtpApiResponse.dart';

class OtpScreenActivity extends StatefulWidget {
  String mobile_nuber = "";

  OtpScreenActivity(this.mobile_nuber);

  @override
  _OtpScreenActivity createState() => _OtpScreenActivity();
}

class _OtpScreenActivity extends State<OtpScreenActivity> {
  //#region Test
  String inputpin = "";
  String remaining_time = "";
  bool isloading = true;
  OtpBloc _otpBloc = OtpBloc();
  ResendOtpBloc _resendOtpBloc = ResendOtpBloc();
  Timer _timer;
  int _start = 30;
//endRegion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Stack(children: <Widget>[
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 100.0),
                      Image(
                        image: AssetImage("assets/images/verify.png"),
                        height: 90,
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        'Verification',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Enter 6 digit number that sent to',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      VerificationCodeInput(
                        keyboardType: TextInputType.number,
                        length: 6,
                        autofocus: false,
                        onCompleted: (String value) {
                          inputpin = value;
                        },
                      ),
                      SizedBox(height: 30.0),
                      FlatButton(
                        height: 40,
                        minWidth: 300,
                        color: Colors.blue,
                        // textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(color: Colors.blue)),
                        onPressed: () async {
                          if (inputpin == "") {
                            print(
                                "ExamplePinEntry_mobile : ${widget.mobile_nuber}");
                            Fluttertoast.showToast(
                                msg: "Please Enter Pin",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            try {
                              final result =
                                  await InternetAddress.lookup('google.com');
                              if (result.isNotEmpty &&
                                  result[0].rawAddress.isNotEmpty) {
                                _otpBloc.executeOtp(OTPDoneRequest(
                                    widget.mobile_nuber, inputpin));
                                getOtpResponse(context);
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
                          }
                        },
                        child: Text(
                          "Continue",
                          style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Column(
                        // Start Timer
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Center(
                              child: _start == 00
                                  ? resendTimertext()
                                  : resendText()),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ]),
        // end Padding()
      ), // end Container()
    );
  }

  void getOtpResponse(BuildContext context) {
    _otpBloc.subject.listen((value) async {
      print("Email:${value.status}");
      if(value.data.Result!=null){
        if (value.data.Result.status == "1") {
          print("status_fromres:${value.data.Result.status}");
          String token =value.data.Result.token;
          String username =value.data.Result.username;
          String rolename =value.data.Result.rolename;
          print("status_token:${value.data.Result.token}");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(ApiConstants.loggedin, true);
          prefs.setString(ApiConstants.token, token);
          prefs.setString(ApiConstants.username, username);
          prefs.setString(ApiConstants.rolename, rolename);
          _timer.cancel();
          setState(() async {
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
            SharedPreferences prefs = await SharedPreferences.getInstance();

            if(prefs.getString(ApiConstants.rolename)=="employee" || prefs.getString(ApiConstants.rolename)==null){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            } else {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => AdminHomePage()));
            }
          });
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => new HomePage()),
          //     ModalRoute.withName("/Home"));
        } else {
          setState(() {
            String message = value.data.Result.message;
            // _showDialog(context, message);
            _showToast(message);
          });
        }
      }

        isloading = false;

    });
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }
  void getresendOtpResponse(BuildContext context) {
    _otpBloc.subject.listen((value) async {
      print("Email:${value.status}");
      if (value.status == Status.SUCCESS) {

        if (value.data.Result.status == "1") {
          _timer.cancel();
          print("status_fromres:${value.data.Result.status}");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(ApiConstants.loggedin, true);
           prefs = await SharedPreferences.getInstance();

          if(prefs.getString(ApiConstants.rolename)=="employee" || prefs.getString(ApiConstants.rolename)==null){
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AdminHomePage()));
          }
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          String message = value.data.Result.message;
          _showToast(message);
          // _showDialog(context, message);
        }

        isloading = false;
      }
    });
  }

  Widget resendText() {
    return Text(
      "00 : $_start",
      style: TextStyle(fontSize: 16),
    );
  }

  Widget resendTimertext() {
    return new InkWell(
      onTap: () {
        print("Resend Otp");
        _resendOtpBloc
            .executeResendOtp(ResendOTPRequest(widget.mobile_nuber, "1"));
        getresendOtpResponse(context);
      },
      child: new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Text(
          "Resend OTP",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    _getPrefValue();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future<void> _getPrefValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String check_inout_status =
        prefs.getString(ApiConstants.user_id);
    if (check_inout_status == null) {
      check_inout_status = "check_in";
    }
    print(check_inout_status);
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
