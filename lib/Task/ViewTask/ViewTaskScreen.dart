import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_app/Task/ViewTask/ViewTaskBloc.dart';
import 'package:flutter_app/Task/ViewTask/ViewTaskRequest.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewTaskModel.dart';

class ViewTaskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ViewTaskScreen();
}

class _ViewTaskScreen extends State<ViewTaskScreen> {
  String token = "";
  String user_id = "";
  ViewTaskBloc _viewTaskBloc = ViewTaskBloc();
  bool isloading = true;
  bool showlist = false;
  List<ViewTask> _viewTaskdata = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("View Task"),
            backgroundColor: Colors.grey[300],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                _onBackPressed();
              },
            ),
          ),

        ),
        onWillPop: _onBackPressed);
  }

  @override
  void initState() {
    _getPrefValue();
  }
  Future<void> _getPrefValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(ApiConstants.token);
    user_id = prefs.getString(ApiConstants.user_id);

    print("token  :" + token);
    print("userid  :" + user_id);

    _viewTaskBloc
        .executeLeaveList(ViewTaskRequest(user_id, token, ApiConstants.clickeduser_id));
    _viewTaskBloc.subject.listen((value) {
      if (value.data.Result != null) {
        String message = value.data.Result.message;
        if (value.data.Result.status == "0") {
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          isloading = false;
          showlist = false;
          _viewTaskdata = value.data.Result.viewtask;
        } else {
          showlist = true;
          _viewTaskdata = value.data.Result.viewtask;

          print("_viewTaskdata" + _viewTaskdata.toString());
        }
      }
      setState(() {
        isloading = false;
      });
    });
  }

  Future<bool> _onBackPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString(ApiConstants.rolename) == "employee" || prefs.getString(ApiConstants.rolename) == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomePage()));
    }
    return true;
  }
}
