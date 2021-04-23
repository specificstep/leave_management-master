import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/AppTour/AppTourActivity.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/HomePage.dart';
import 'Login/login_screen_old.dart';


void main() {
  runApp(new MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.purple,
        accentColor: Colors.amber,
        accentColorBrightness: Brightness.dark
    ),
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => new SplashScreen()
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool show_firsttime = false;
  bool loggedin = false;

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    if(show_firsttime==false || show_firsttime == null){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AppTourActivity()));
          // context, MaterialPageRoute(builder: (context) => LeaveListScreen()));
    }else{
      if(loggedin==false || loggedin==null){
        // Navigator.of(context).pushReplacement(LoginScreen_old.route());

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen_old()));
            // context, MaterialPageRoute(builder: (context) => LeaveListScreen()));
      }else{
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
            // context, MaterialPageRoute(builder: (context) => LeaveListScreen()));
      }

    }

  }

  @override
  void initState() {
    super.initState();
    startTime();
    _getPrefValue();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Scaffold(
        body: new Center(
            child: new Image.asset('images/splash.png',
                width: 200, height: 200)),
      ),
    );
  }

  Future<void> _getPrefValue() async {
    String stringValue = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    show_firsttime = prefs.getBool(ApiConstants.show_firsttime);
    loggedin = prefs.getBool(ApiConstants.loggedin);

    if (show_firsttime != null) stringValue = show_firsttime.toString();
    print(show_firsttime);
    // print(loggedin);
  }
}
