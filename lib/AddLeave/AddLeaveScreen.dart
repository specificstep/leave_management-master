import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AddLeave/AddLeaveBloc.dart';
import 'package:flutter_app/AddLeave/AddLeaveRequest.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/LeaveNameList/LeaveNameListBloc.dart';
import 'package:flutter_app/LeaveNameList/LeaveNameListModel.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_app/utilities/TextView.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddLeaveScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddLeaveScreen();
}

class _AddLeaveScreen extends State<AddLeaveScreen> {
  List<String> selectedItemValue = List<String>();
  List<String> ddl = ["First Half", "Second Half", "Full Day"];
  bool isloading = true;
  bool ischecked = true;
  List<LeaveNameList> leavelist;
  LeaveNameList _nameList;
  LeaveNameListBloc _leavenameListBloc = LeaveNameListBloc();
  AddLeaveBloc _addLeaveBloc = AddLeaveBloc();
  String token = "";
  String user_id = "";
  String username = "";
  String dropdownValue = 'Select';
  TextEditingController _datecontroller = new TextEditingController();
  TextEditingController _datecontroller2 = new TextEditingController();
  TextEditingController _leavereasoncontroller = new TextEditingController();
  DateTime start_currentdate = DateTime.now();
  DateTime end_currentdate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String end_date = "";
  String start_date = "";
  String leave_type_id = "";
  List<DateTime> days = [];
  List<String> days_instring = [];
  List<int> selected_list = List<int>();
  var datesList;

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < days_instring.length; i++) {
      selectedItemValue.add("First Half");
      // selected_list.add(0);
    }
    /*for (int i = 0; i < ddl.length; i++) {
       selected_list.add(0);
    }*/

    return WillPopScope(
        child: Scaffold(
            body: isloading
                ? Center(child: CircularProgressIndicator())
                : Scaffold(
                    body: Form(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding:
                                new EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 20.0),
                            height: double.infinity,
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 20.0),
                                  TextView(
                                    "EMPLOYEE ID",
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    textAlign: TextAlign.left,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(height: 5.0),
                                  TextView(
                                    username,
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 13,
                                    textAlign: TextAlign.left,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  SizedBox(height: 20.0),
                                  TextView(
                                    "LEAVE TYPE",
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    textAlign: TextAlign.left,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Container(
                                    child: getDropDown(),
                                  ),
                                  SizedBox(height: 10.0),
                                  TextView(
                                    "FROM DATE",
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 13,
                                    textAlign: TextAlign.left,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      end_currentdate = DateTime.now();

                                      _selectDate(context);
                                    },
                                    child: IgnorePointer(
                                      child: new TextField(
                                        controller: _datecontroller,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              ('${formatter.format(start_currentdate)}'),
                                          hintStyle: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextView(
                                    "To DATE",
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    textAlign: TextAlign.left,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _selectToDate(context);
                                    },
                                    child: IgnorePointer(
                                      child: new TextField(
                                        controller: _datecontroller2,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              ('${formatter.format(end_currentdate)}'),
                                          hintStyle: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CheckboxListTile(
                                        title: TextView(
                                          "All Day",
                                          fontFamily: 'Poppins-SemiBold',
                                          fontSize: 15,
                                          textAlign: TextAlign.left,
                                          textColor: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        activeColor: Colors.cyan,
                                        value: ischecked,
                                        onChanged: (newval) {
                                          setState(() {
                                            ischecked = newval;
                                            print(ischecked);
                                          });
                                        },
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                      ),
                                      Visibility(
                                          visible: true,
                                          child: Container(
                                            child: ListView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: days_instring.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  String leavedate = days_instring[index];
                                                  return GestureDetector(
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Container(
                                                            child: TextView(
                                                              leavedate,
                                                              fontFamily:
                                                                  'Poppins-SemiBold',
                                                              fontSize: 13,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textColor:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          50.0),
                                                              child:
                                                                  DropdownButton(
                                                                      value: selectedItemValue[
                                                                              index]
                                                                          .toString(),
                                                                      items:
                                                                          _dropDownItem(),
                                                                      onChanged:
                                                                          (value) {
                                                                        selectedItemValue[index] =
                                                                            value;
                                                                        selected_list[index] =
                                                                            ddl.indexOf(value);
                                                                        setState(
                                                                            () {});
                                                                      }))
                                                        ],
                                                      ),
                                                    ),
                                                  );

                                                  print("leavedates : " +
                                                      leavedate);
                                                }),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 5.0),
                                  TextView(
                                    "REASON FOR LEAVE",
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    textAlign: TextAlign.left,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  TextFormField(
                                    controller: _leavereasoncontroller,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'OpenSans',
                                      fontSize: 13,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter Reason',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      FlatButton(
                                        onPressed: () async {
                                          print("selected value :" +
                                              selected_list.toString());

                                          List<int> newselected_list =
                                              List<int>();
                                          for (int i = 0;
                                              i < selected_list.length;
                                              i++) {
                                            newselected_list
                                                .add(selected_list[i] + 1);
                                          }
                                          String dayof_leave_array =
                                              newselected_list.join(',');

                                          if (dayof_leave_array == "") {
                                            dayof_leave_array = "1";
                                          }
                                          if (leave_type_id == "") {
                                            leave_type_id = leavelist[0].id;
                                          }
                                          print("dayof_leave_array :" +
                                              dayof_leave_array);
                                          String allday_selection;
                                          if (ischecked == false) {
                                            allday_selection = "0";
                                          } else {
                                            allday_selection = "1";
                                          }

                                          if (_leavereasoncontroller.text ==
                                              "") {
                                            Fluttertoast.showToast(
                                                msg: "Please Add Reason",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else {
                                            try {
                                              final result =
                                                  await InternetAddress.lookup(
                                                      'google.com');
                                              if (result.isNotEmpty &&
                                                  result[0]
                                                      .rawAddress
                                                      .isNotEmpty) {
                                                _addLeaveBloc.executeAddLeave(
                                                    AddLeaveRequest(
                                                        user_id,
                                                        token,
                                                        leave_type_id,
                                                        start_date,
                                                        end_date,
                                                        allday_selection,
                                                        dayof_leave_array,
                                                        _leavereasoncontroller
                                                            .text));
                                                getAddLeaveResponse(context);
                                                print('connected');
                                              }
                                            } on SocketException catch (_) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please Check Internet Connection",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              print('not connected');
                                            }
                                          }
                                        },
                                        height: 40,
                                        minWidth: 200,
                                        textColor: Colors.white,
                                        color: Colors.cyan,
                                        child: Text("SUBMIT"),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
        onWillPop: _onBackPressed);
  }

  Future<bool> _onBackPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString(ApiConstants.rolename) == "employee" ||
        prefs.getString(ApiConstants.rolename) == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminHomePage()));
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _getPrefValue();

    // get dates list
    selected_list = new List<int>();

    for (int i = 0; i < days_instring.length; i++) {
      selected_list.add(0);
      // selected_list.add(0);
    }
    // selected_list.add(0);
    // selected_list.add(0);
    // selected_list.add(0);
  }

  Widget getDropDown() {
    var items = leavelist.map((leave_list) {
      return new DropdownMenuItem<LeaveNameList>(
        value: leave_list,
        child: new TextView(
          leave_list.leave_name,
          fontFamily: 'Poppins-SemiBold',
          fontSize: 13,
          textColor: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      );
    }).toList();

    return DropdownButton<LeaveNameList>(
      // hint: new Text("Select"),
      isExpanded: false,
      value: this._nameList,
      onChanged: (LeaveNameList list) {
        setState(() {
          this._nameList = list;
          leave_type_id = list.id;

          print("select id : " + leave_type_id);
        });
      },
      items: items,
    );
  }

  List<DateTime> calculateDaysInterval(DateTime startDate, DateTime endDate) {

    print("start_currentdate " + start_currentdate.toString());
    print("end_currentdate " + end_currentdate.toString());
    print("endDate " + endDate.toString());
    print("startDate " + startDate.toString());
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
// if (start_date.toString() == end_date.toString()) {
//
//     } else {
//       print("start_currentdate " + start_currentdate.toString());
//       print("end_currentdate " + end_currentdate.toString());
//       days.add(end_currentdate);
//     }

    if (!days.contains(endDate)) {
      days.add(end_currentdate);
    }
    var dates = days.map((DateTime time) {
      var dateRange = formatter.format(time);
      return dateRange;
    });
    datesList = dates.toList();
    days_instring = datesList;

    print("days_instring" + days_instring.toString());
    print("datesList" + datesList.toString());
    for (int i = 0; i < days_instring.length; i++) {
      selected_list.add(0);
      // selected_list.add(0);
    }
    print(days);
    return days;
  }

  Future<void> _getPrefValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(ApiConstants.token);
    user_id = prefs.getString(ApiConstants.user_id);
    username = prefs.getString(ApiConstants.username);

    print("token  :" + token);
    print("userid  :" + user_id);
    print("username  :" + username);

    start_date = formatter.format(start_currentdate);
    end_date = formatter.format(end_currentdate);
    DateTime now = DateTime.now();

    DateTime formate = new DateTime(now.year, now.month, now.day);
    print("formate " + formate.toString());

    calculateDaysInterval(formate, formate);

    _leavenameListBloc.executeLeaveNameList(LeaveListRequest(user_id, token));
    _leavenameListBloc.subject.listen((value) {
      if (value.status == Status.SUCCESS) {
        leavelist = value.data.Result.leavenamelist;
        _nameList = leavelist.first;
        setState(() {
          isloading = false;
        });
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    setState(() {
      if (days != null) {
        days.clear();
      }
      if (datesList != null) {
        datesList.clear();
      }
      if (selectedItemValue != null) {
        selectedItemValue.clear();
      }
      if (days_instring != null) {
        days_instring.clear();
      }
      if (selected_list != null) {
        selected_list.clear();
      }
    });
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - 7),
        // maxTime: DateTime(2019, 6, 7),
        theme: DatePickerTheme(
            headerColor: Colors.cyan,
            backgroundColor: Colors.white,
            itemStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            cancelStyle: TextStyle(color: Colors.white, fontSize: 16),
            doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
        onChanged: (date) {
      print('change $date in time zone ' +
          date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date1) {
      print('confirm $date1');
      setState(() {
        start_currentdate = date1;
      });
      start_date = formatter.format(date1);
      print('gettingDate $start_date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  Future<void> _selectToDate(BuildContext context) async {
    setState(() {
      if (days != null) {
        days.clear();
      }
      if (datesList != null) {
        datesList.clear();
      }
      if (selectedItemValue != null) {
        selectedItemValue.clear();
      }
      if (days_instring != null) {
        days_instring.clear();
      }
      if (selected_list != null) {
        selected_list.clear();
      }
    });

    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - 7),
        // maxTime: DateTime(2019, 6, 7),
        theme: DatePickerTheme(
            headerColor: Colors.cyan,
            backgroundColor: Colors.white,
            itemStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            cancelStyle: TextStyle(color: Colors.white, fontSize: 16),
            doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
        onChanged: (date) {
      print('change $date in time zone ' +
          date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date1) {
      print('confirm $date1');
      setState(() {
        end_currentdate = date1;
      });
      end_date = formatter.format(date1);
      var difference = end_currentdate.difference(start_currentdate).inDays + 1;

      // get dates list
      calculateDaysInterval(start_currentdate, end_currentdate);

      print('gettingDate $end_currentdate');
      print('difference $difference');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<String>> _dropDownItem() {
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: TextView(
                value,
                fontFamily: 'Poppins-SemiBold',
                fontSize: 13,
                textAlign: TextAlign.center,
                textColor: Colors.black,
              ),
            ))
        .toList();
  }

  void getAddLeaveResponse(BuildContext context) {
    _addLeaveBloc.subject.listen((value) {
      print("getAddLeaveStatus:${value.status}");
      print("status_addleave:${value.data.Result.status}");
      if (value.data.Result.status == "1") {
        // print("status_fromres:${value.data.Result.status}");
        String message = value.data.Result.message;
        _showToast(message);
        print("AddLeave_message:${message}");
      } else {
        String message = value.data.Result.message;
        print("AddLeave_message:${message}");
        _showToast(message);
      }
    });
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
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
