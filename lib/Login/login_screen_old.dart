import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/LoginRequest.dart';
import 'package:flutter_app/Login/UserBloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../inputData.dart';
import '../OTP/OtpScreenActivity.dart';

class LoginScreen_old extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen_old> {
  bool isloading = true;
  UserBloc _userBloc = UserBloc();
  bool isAlertboxOpened;
  TextEditingController mobilenumberController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  validateData() async {
    if (_key.currentState.validate()) {
      scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: Colors.transparent,
        duration: new Duration(seconds: 9),
        content: new Row(
          children: <Widget>[
            new CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            new Text(
              "Submitting...",
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ));

      addData();
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          getconnected();
          print('connected');
        }
      } on SocketException catch (_) {
        showToast();

        print('not connected');
      }
      // navigationPage();
      _key.currentState.save();
    } else {
      // validation error
      setState(() {
        scaffoldKey.currentState.hideCurrentSnackBar();
        _validate = true;
      });
    }
  }

  Future addData() {
    print("Email:${mobilenumberController.text}");
    print("Password:${passwordController.text}");
    setState(() {
      scaffoldKey.currentState.hideCurrentSnackBar();
    });
  }

  void getLoginResponse() {
    _userBloc.subject.listen((value) async {
      print("loginstatus:${value.status}");
      if (value.status == Status.SUCCESS) {
        if (value.data.Result.status == "1") {
          String user_id=value.data.Result.user_id;
          SharedPreferences  prefs = await SharedPreferences .getInstance();
          prefs.setString(ApiConstants.user_id, user_id);
          print("status_user_id:${value.data.Result.user_id}");
          print("status_fromres:${value.data.Result.status}");
          navigationPage();
        } else {
          String message = value.data.Result.message;
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          // _showDialog(message);

        }

        isloading = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    isAlertboxOpened=false;
    // getprefValue();
    // _userBloc.subject.listen((value) {
    //   print("Email:${value.status}");
    //   if (value.status == Status.SUCCESS) {
    //     if(value.data.Result.status==1){
    //       print("status_fromres:${value.data.Result.status}");
    //
    //     }
    //     navigationPage();
    //     isloading = false;
    //   }
    //
    // });
  }

  Future navigatePage() {
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => RegisterScreen()));
  }

  void navigationPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                new OtpScreenActivity(mobilenumberController.text)),
        ModalRoute.withName("/Home"));
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => ExamplePinEntry()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Form(
          key: _key,
          autovalidate: _validate,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFFFF),
                          Color(0xFFFFFF),
                          Color(0xFFFFFF),
                          Color(0xFFFFFF),
                        ],
                        stops: [0.1, 0.4, 0.7, 0.9],
                      ),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 40.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 60.0),
                          Text(
                            'SIGN IN',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Image(
                            image: AssetImage("assets/images/login_ic.png"),
                            height: 200,
                          ),
                          Container(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            height: 230,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white54,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[400],
                                  blurRadius: 6.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 20.0),
                                InputData.buildNumberTF(mobilenumberController),
                                InputData.buildLoginBtn("LOGIN", validateData),
                                // _buildForgotPasswordBtn(),
                              ],
                            ),
                          ),
                          // _buildSignInWithText(),
                          // _buildSocialBtnRow(),
                          // InputData.buildSignupSigninBtn(
                          //     "Don\'t have an Account?",
                          //     "Sign Up",
                          //     navigatePage)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void getconnected() {
    _userBloc.executeLogin(LoginRequest(mobilenumberController.text));
    getLoginResponse();
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: "Please Check Internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
