import 'dart:io';

import 'package:fancy_bottom_navigation_image/fancy_bottom_navigation_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AddLeave/AddLeaveScreen.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/AttendanceList/AttendanceListScreen.dart';
import 'package:flutter_app/CheckIn/ServicesScreen.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/login_screen_old.dart';
import 'package:flutter_app/Logout/LogoutBloc.dart';
import 'package:flutter_app/Logout/LogoutScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'People Managment',
      theme: ThemeData(
        // primarySwatch: Colors.grey,
        primaryColor: Colors.grey[300],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 1;

  GlobalKey bottomNavigationKey = GlobalKey();

  String _title;

  @override
  initState() {
    _title = 'Home';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          IconButton(
              icon: Image.asset("logout.png"),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => LogoutScreen()));
              })
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigationImage(
        circleColor: Color(0xff4268cd),
        activeIconColor: Color(0xFFFFFFFF),
        textColor: Color(0xff4268cd),
        inactiveIconColor: Colors.grey,
        tabs: [
          TabData(
            imageData: "attendance.png",
            title: "ATTENDANCE",
          ),
          TabData(
            imageData: "sydney-opera-house.png",
            title: "HOME",
          ),
          TabData(
            imageData: "approval.png",
            title: "APPROVALS",
          ),
          TabData(
            imageData: "settings.png",
            title: "Settings",
          ),
        ],
        initialSelection: 1,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
            onTabTapped(currentPage);
          });
        },
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return Scaffold(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // mainAxisSize: MainAxisSize.min,
          // ),

            body: Form(
                child: Stack(
                  children: <Widget>[
                    AttendanceListScreen(),
                  ],
                )));
      case 1:
        return Scaffold(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // mainAxisSize: MainAxisSize.min,
          // ),
            body: Form(
                child: Stack(
                  children: <Widget>[
                    ServicesScreen(),
                  ],
                )));
      case 2:
        return Scaffold(
            body: Form(
                child: Stack(
                  children: <Widget>[
                    AddLeaveScreen(),
                  ],
                )));
      case 3:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(""),
          ],
        );
        // return Scaffold(
        //     body: Form(
        //         child: Stack(
        //           children: <Widget>[
        //             AddLeaveScreen(),
        //           ],
        //         )));
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(""),
          ],
        );
    }
  }

  void onTabTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            _title = 'Attendance';
          }
          break;
        case 1:
          {
            _title = 'Home';
          }
          break;
        case 2:
          {
            _title = 'Add Leave';
          }
          break;
        case 3:
          {
            _title = 'Home';
          }
          break;
      }
    });
  }

}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
