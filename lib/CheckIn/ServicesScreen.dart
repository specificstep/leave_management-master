import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/CheckIn/CheckInRequest.dart';
import 'package:flutter_app/CheckInOutStatus/CheckInOutStatusBloc.dart';
import 'package:flutter_app/CheckInOutStatus/CheckInOutStatusRequest.dart';
import 'package:flutter_app/CheckOut/CheckOutBloc.dart';
import 'package:flutter_app/CheckOut/CheckOutRequest.dart';
import 'package:flutter_app/Login/login_screen_old.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_app/Services/MyGridView.dart';
import 'package:flutter_app/Services/ServicesList.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CheckInApiResponse.dart';
import 'CheckInBloc.dart';

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreen createState() => _ServicesScreen();
}

class _ServicesScreen extends State<ServicesScreen> {
  int seconds = 0, minutes = 0, hours = 0;
  Timer timer;
  Position _currentPosition;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  CheckInBloc _checkInBloc = CheckInBloc();
  CheckOutBloc _checkOutBloc = CheckOutBloc();
  CheckInOutStatusBloc _checkInOutStatusBloc = CheckInOutStatusBloc();
  String str_latitude = "";
  String str_longitude = "";
  String Current_Date = "";
  String Ip_Address = "";
  String check_inout_status = "";
  String token = "";
  String user_connection = "";
  String checkinout_type = "";
  bool pressAttention = false;
  bool isloading = true;
  String user_id = "";
  int selectedIndex = -1;
  var tcVisibility = false;
  final List<ServicesList> _allServices = ServicesList.allServices();
  bool _canShowButton = true;

  void checkPermission() {
    geolocator.checkGeolocationPermissionStatus().then((status) {
      print('status: $status');
    });
    geolocator
        .checkGeolocationPermissionStatus(
        locationPermission: GeolocationPermission.locationAlways)
        .then((status) {
      print('always status: $status');
    });
    geolocator.checkGeolocationPermissionStatus(
        locationPermission: GeolocationPermission.locationWhenInUse)
      ..then((status) {
        print('whenInUse status: $status');
      });
  }

  // child: new MyGridView(allServices: _allServices),
  void hideWidget() {
    setState(() {
      _canShowButton = !_canShowButton;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                Container(
                  // margin: const EdgeInsets.only(top: 10.0),
                  child: isloading
                      ? Center(child: CircularProgressIndicator())
                      : !_canShowButton
                      ? const SizedBox.shrink()  : FlatButton(
                    height: 45,
                    minWidth: 180,
                    color: Colors.blue[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.blue)),
                    onPressed: () async {
                      hideWidget();

                      try {
                        final result = await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                          if (check_inout_status == "" ||
                              check_inout_status == "check_out" ||
                              check_inout_status == null) {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString(ApiConstants.check_inout_status, "check_in");
                          } else if (check_inout_status == "check_in") {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString(ApiConstants.check_inout_status, "check_out");
                          } else if (check_inout_status == "check_out") {
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            prefs.setString(
                                ApiConstants.check_inout_status, "check_in");
                          }
                          setState(() {

                            _getPrefValue();
                            check_inout_status == "check_in"
                                ? Text("Check In",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white),
                            )
                                : Text("Check Out",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white));

                            if (check_inout_status == "check_in") {
                              tcVisibility = true;
                              increment();
                              print("call Api for checkin");
                              checkinout_type = "1";
                              if (Ip_Address == "") {
                                Ip_Address = "203.109.112.102";
                              }
                              isloading = true;

                              _checkInBloc.executeCHeckIn(CheckInRequest(
                                  user_id,
                                  str_latitude,
                                  str_longitude,
                                  Current_Date,
                                  Current_Date,
                                  Ip_Address,
                                  "image",
                                  user_connection,
                                  checkinout_type,
                                  token));
                              getCHeckInResponse(context);
                            } else if (check_inout_status == "check_out") {
                              isloading = true;
                              tcVisibility = false;
                              print("call Api for checkout");
                              checkinout_type = "2";
                              _checkOutBloc.executeCHeckOut(CheckOutRequest(
                                  user_id,
                                  str_latitude,
                                  str_longitude,
                                  Current_Date,
                                  Current_Date,
                                  Ip_Address,
                                  "image",
                                  user_connection,
                                  checkinout_type,
                                  token));
                              getCHeckOutResponse(context);
                            }
                          });
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
                    },
                    child: check_inout_status == "check_in"
                        ? Text("Check In",
                        style:
                        TextStyle(fontSize: 20, color: Colors.white))
                        : Text("Check Out",
                        style:
                        TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
                Container(
                  // margin: const EdgeInsets.only(right: 20.0),
                  child: Visibility(
                    visible: tcVisibility,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          // width: 200,
                          alignment: Alignment.center,
                          // decoration: new BoxDecoration(
                          //     borderRadius:
                          //     new BorderRadius.all(new Radius.circular(10.0)),
                          //     color: Colors.blue[300]),
                          padding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          child: Text(
                            ((this.hours >= 10)
                                ? '${this.hours}'
                                : '0${this.hours}') +
                                ':' +
                                ((this.minutes >= 10)
                                    ? '${this.minutes}'
                                    : '0${this.minutes}') +
                                ':' +
                                ((this.seconds >= 10)
                                    ? '${this.seconds}'
                                    : '0${this.seconds}'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Poppins-SemiBold',
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 5.0),
            Expanded(child: new MyGridView(allServices: _allServices)),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    //get data from pref
    _getPrefValue();
    //check connctions
    getStatus();
    // Get Current Ip Address
    getIpAddress();

    //get date and time
    DateTime now = DateTime.now();
    Current_Date = DateFormat(' yyyy-mm-dd hh:mm:ss').format(now);
    print("currentdate  : " + Current_Date);

    // getLocation();
    _getCurrentLocation();
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.cyan,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _getCurrentLocation() {
    checkPermission();

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      // _getAddressFromLatLng();
      str_latitude = _currentPosition.latitude.toString();
      str_longitude = _currentPosition.longitude.toString();
      print("str_latitude : " + str_latitude);
      print("str_longitude : " + str_longitude);
    }).catchError((e) {
      print(e);
    });
  }

  Future<bool> getStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      user_connection = "1";
      print("network available using mobile");
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      user_connection = "2";
      print("network available using wifi");
      return true;
    } else {
      user_connection = "";
      print("network not available");
      return false;
    }
  }

  Future<String> getIpAddress() async {
    try {
      const url = 'https://api.ipify.org';
      var response = await get(url);
      if (response.statusCode == 200) {
        Ip_Address = response.body.toString();
        print("Ip_Address" + Ip_Address);

        return response.body;
      } else {
        Ip_Address = "203.109.112.102";
        print(response.body);
        return null;
      }
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<void> _getPrefValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    check_inout_status = prefs.getString(ApiConstants.check_inout_status);
    token = prefs.getString(ApiConstants.token);
    user_id = prefs.getString(ApiConstants.user_id);
    String username = prefs.getString(ApiConstants.username);
    if (check_inout_status == null || check_inout_status == "check_in") {
      check_inout_status = "check_in";
    }
    print("check_inout_status  :" + check_inout_status);
    print("token  :" + token);
    print("userid  :" + user_id);
    print("username  :" + username);
    _getApiCheckinoutStatus();
  }

  Future<void> getCHeckInResponse(BuildContext context) async {
    await Future.delayed(Duration(seconds: 4));
    _checkInBloc.subject.listen((value) {
      print("getCHeckInStatus:${value.status}");
      print("statusIn:${value.data.inModel.status}");
      if (value.data.inModel.status == "1") {
        print("status_fromres:${value.data.inModel.status}");
        String message = value.data.inModel.message;
        _showToast(message);
        print("message:${message}");
      } else {
        String message = value.data.inModel.message;
        _showDialog(context, message);
      }
    });
    isloading = false;
    setState(() {
      _canShowButton=true;
      _onBackPressed();
    });
  }

  Future<void> getCHeckOutResponse(BuildContext context) async {

    await Future.delayed(Duration(seconds: 4));
    _checkOutBloc.subject.listen((value) {
      print("Email:${value.status}");
      print("statusOut:${value.data.inModel.status}");
      if (value.data.inModel.status == "1") {
        print("status_fromres:${value.data.inModel.status}");
        String message = value.data.inModel.message;
        _showToast(message);
        // Fluttertoast.showToast(msg: message);

      } else {
        String message = value.data.inModel.message;
        _showDialog(context, message);
      }
    });
    isloading = false;
    setState(() {
      _canShowButton=true;
      _onBackPressed();

    });
  }
  Future<bool> _onBackPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString(ApiConstants.rolename)=="employee" || prefs.getString(ApiConstants.rolename)==null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    }else
    {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomePage()));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomePage()));
    }
    return true;
  }
  Future<void> _getApiCheckinoutStatus() async {
    isloading = true;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (token != "" || token != null) {
          print("call Api for checkinout status");
          _checkInOutStatusBloc
              .executeCHeckInOutStatus(CheckInOutStatusRequest(user_id, token));
          try {
            getCHeckInOutStatusResponse(context);
          } on Exception catch (_) {
            print("status exception");
          }
        }
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

  void _showDialog(BuildContext context, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
            // content: Text('Pin entered is $value'),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok'),
                  onPressed: () async {
                    Navigator.pop(context, false);
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    prefs.setString(
                        ApiConstants.check_inout_status, "check_in");
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

  void increment() {
    setState(() {
      this.tcVisibility = true;
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = this.seconds + 1;
      int localMinutes = this.minutes;
      int localHours = this.hours;
      if (localSeconds > 60) {
        localMinutes++;
        if (localMinutes > 60) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      if (this.mounted) {
        setState(() {
          this.seconds = localSeconds;
          this.minutes = localMinutes;
          this.hours = localHours;
          this.timer = timer;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer.cancel();
    }
  }

  void getCHeckInOutStatusResponse(BuildContext context) {
    try {
      _checkInOutStatusBloc.subject.listen((value) {
        if(value.data.checkInOutStatusResponse !=null){
          print(
              "getCHeckInoUTStatus:${value.data.checkInOutStatusResponse.status}");
          // print("statusInout  :${value.data.checkInOutStatusResponse.status}");
          if (value.data.checkInOutStatusResponse.status == "1") {
            print("status_fromres:${value.data.checkInOutStatusResponse.status}");
            String checkinoutstatus =
                value.data.checkInOutStatusResponse.checkinoutstatus;
            String time = value.data.checkInOutStatusResponse.time;

            if(time==""){
              time="00:00:00";
            }
            print("time : " + time);

            if (timer == "") {
            } else {
              print("message:${checkinoutstatus}");
              List<String> arr = time.split(':');
              hours = int.parse(arr[0]);
              minutes = int.parse(arr[1]);
              seconds = int.parse(arr[2]);
              increment();
            }
            print("hours " + hours.toString());
            if (checkinoutstatus == "0") {
              check_inout_status = "check_in";
              tcVisibility = false;
            } else if (checkinoutstatus == "1") {
              check_inout_status = "check_out";
              tcVisibility = true;
            }
          } else {
            String message = value.data.checkInOutStatusResponse.message;
            _showDialog(context, message);
          }
        }
      }
      );
    } on Exception catch (_) {}
    print("throwing Exception");
    isloading = false;
  }
}
