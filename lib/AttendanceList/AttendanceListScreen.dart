import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/AttendanceList/AttendanceListBloc.dart';
import 'package:flutter_app/AttendanceList/AttendanceListModel.dart';
import 'package:flutter_app/AttendanceList/AttendanceListRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

class AttendanceListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AttendanceListScreen();
}


// EventList<Event> _markedDateMap;

class _AttendanceListScreen extends State<AttendanceListScreen> {
  List<AttendanceList> _list;
  AttendanceListBloc _attendanceListBloc = AttendanceListBloc();
  String token = "";
  String user_id = "";
  String start_time = "";
  String end_time = "";
  String difference = "";
  bool isloading = true;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  List<DateTime> presentDates=[] ;
  List<DateTime> absentDates=[];
  static Widget _presentIcon(String day) => CircleAvatar(
    backgroundColor: Colors.green,
    child: Text(
      day,
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );
  static Widget _absentIcon(String day) => CircleAvatar(
    backgroundColor: Colors.red,
    child: Text(
      day,
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );

  EventList<Event>  _markedDateMap = new EventList<Event>(
  events: {},
  );

  CalendarCarousel _calendarCarouselNoHeader;

  double cHeight;

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;
    var len = min(absentDates?.length, presentDates.length);

    for (int i = 0; i < presentDates.length; i++) {
      _markedDateMap.add(presentDates[i],
        new Event(
          date: presentDates[i],
          title: 'Event 5',
          icon: _presentIcon(
            presentDates[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < absentDates.length; i++) {
      _markedDateMap.add(absentDates[i],
        new Event(
          date: absentDates[i],
          title: 'Event 5',
          icon: _absentIcon(
            absentDates[i].day.toString(),
          ),
        ),
      );
    }

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: cHeight * 0.54,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      todayButtonColor: Colors.blue[200],
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal:
      null, // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );

    return WillPopScope(
        child: Scaffold(
            body: isloading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _calendarCarouselNoHeader,
                  markerRepresent(Colors.red, "Absent"),
                  markerRepresent(Colors.green, "Present"),
                ],
              ),
            )),
        onWillPop: _onBackPressed);
  }

  Future<bool> _onBackPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString(ApiConstants.rolename)=="employee" || prefs.getString(ApiConstants.rolename)==null){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminHomePage()));
    }
    return true;
  }

  Widget markerRepresent(Color color, String data) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        radius: cHeight * 0.022,
      ),
      title: new Text(
        data,
      ),
    );
  }

  @override
  void initState() {
    _getPrefValue();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getPrefValue() async {
    if (absentDates != null) {
      absentDates.clear();
    }
    if (presentDates != null) {
      presentDates.clear();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(ApiConstants.token);
    user_id = prefs.getString(ApiConstants.user_id);

    print("token  :" + token);
    print("userid  :" + user_id);

    _attendanceListBloc.executeAttendanceList(
        AttendanceListRequest(user_id, token, start_time, end_time));

    _attendanceListBloc.subject.listen((value) async {
      if (value.status == Status.SUCCESS) {
        if (value.data.Result != null) {
          _list = value.data.Result.attendancelist;
          // _list=_list.reversed.toList();
          for (int i = 0; i < _list.length; i++) {
            if (_list[i].leave_status == "Absent") {
              DateTime dates=formatter.parse(_list[i].start_time);
              absentDates.add(dates);
              // absentDates =[DateTime.parse(_list[i].start_time)];
              // absentDates.add(DateTime.parse(_list[i].start_time));
            } else {
              DateTime dates=formatter.parse(_list[i].start_time);
              presentDates.add(dates);
              // presentDates =[DateTime.parse(_list[i].start_time)];

              // presentDates.add(DateTime.parse(_list[i].start_time));
            }
          }
          print("absentDates" + absentDates.toString());
          print("presentDates" + presentDates.toString());
          print(_list);
          // await Future.delayed(Duration(seconds: 4));

          if(this.mounted){
            setState(() {
              isloading = false;
            });
          }

        }
      }
    });
  }

  getTask() {

  }

}
