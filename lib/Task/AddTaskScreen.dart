import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_app/Task/AddTaskApi/AddTaskRequest.dart';
import 'package:flutter_app/Task/AllList/AllListBloc.dart';
import 'package:flutter_app/Task/AllList/AllListModel.dart';
import 'package:flutter_app/Task/ProjectList/ProjectListBloc.dart';
import 'package:flutter_app/utilities/TextView.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AddTaskApi/AddTaskBloc.dart';
import 'AllList/AllListRequest.dart';
import 'ProjectList/ProjectListShowModel.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey,
        // accentColor: Colors.black,
      ),
      home: AddTaskScreenStates(),
    );
  }
// @override
// State<StatefulWidget> createState() => _AddTaskScreen();
}

class AddTaskScreenStates extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddTaskScreen();
}

class _AddTaskScreen extends State<AddTaskScreenStates> {
  AllListBloc _allListBloc = AllListBloc();
  ProjectListBloc _projectListBloc = ProjectListBloc();
  AddTaskBloc _addTaskBloc = AddTaskBloc();
  String token = "";
  String user_id = "";
  String selected_projectId = "";
  String selected_projectName = "";
  bool isloading = true;
  bool showlist = false;
  List<ProjectListModel> _projectlist = [];
  ProjectListModel _nameList;
  List<DropdownMenuItem<ProjectListModel>> _dropdownMenuItems;
  ProjectListModel _selectedCompany;
  bool manager_selectingmode = true;
  List<String> manager_names = [];
  List<String> manager_id = [];
  List<ManagerListModel> manager_selectedlist = [];
  List<ManagerListModel> _managerlist;
  TextEditingController _managerlistcontroller = new TextEditingController();
  bool managerlist_showlist = false;

  bool selectingmode = true;
  List<EmployeeListModel> _employee_list;
  TextEditingController _employeecontroller = new TextEditingController();
  List<EmployeeListModel> emp_selectedlist = [];
  List<String> names = [];
  List<String> emp_id = [];
  bool employeelist_showlist = false;

  TextEditingController _titlecontroller = new TextEditingController();
  TextEditingController _desccontroller = new TextEditingController();
  TextEditingController _subjectcontroller = new TextEditingController();

  // file selection

  String _fileName = "";
  List<PlatformFile> _paths;
  String _directoryPath;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = true;
  FileType _pickingType = FileType.any;
  File file1;

  String selectedItemValue = "Critical";
  TextEditingController _startdatecontroller = new TextEditingController();
  TextEditingController _enddatecontroller = new TextEditingController();
  DateTime start_currentdate = DateTime.now();
  DateTime end_currentdate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String start_date = "";
  String end_date = "";

  String priority_id;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Add Task"),
              backgroundColor: Colors.grey[300],
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {_onBackPressed();
                },
              ),
            ),
            body: isloading
                ? Center(child: CircularProgressIndicator())
                : Scaffold(
                    body: Form(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding:
                                new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            height: double.infinity,
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 10.0),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Container(
                                          height: 40,
                                          padding: new EdgeInsets.fromLTRB(
                                              10.0, 0.0, 10.0, 0.0),
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: new Border.all(
                                              width: 0.5,
                                            ),
                                          ),
                                          child: getDropDown(),
                                        )
                                      ]),
                                  SizedBox(height: 10.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextFormField(
                                          controller: _titlecontroller,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'Enter Title',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextFormField(
                                          controller: _desccontroller,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'Enter Description',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextFormField(
                                          controller: _subjectcontroller,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'Enter Subject',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: <Widget>[
                                      ElevatedButton(
                                        onPressed: () => _openFileExplorer(),
                                        child: const Text("Select File"),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        " $_fileName",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      // TextView(
                                      //   $ file1,
                                      //   fontFamily: 'Poppins-Regular',
                                      //   fontSize: 16,
                                      //   textAlign: TextAlign.start,
                                      //   textColor: Colors.black,
                                      // ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  //employee selection
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (employeelist_showlist ==
                                                  true) {
                                                employeelist_showlist = false;
                                              } else {
                                                employeelist_showlist = true;
                                              }
                                            });
                                            // showListwidget();
                                          },
                                          child: IgnorePointer(
                                            child: new TextField(
                                              controller: _employeecontroller,
                                              decoration: InputDecoration(
                                                suffixIcon: Icon(Icons
                                                    .keyboard_arrow_down_rounded),
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                border: new OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Colors.black)),
                                                hintText: names.reduce(
                                                    (value, element) =>
                                                        value + ',' + element),
                                                hintStyle: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          child: Container(
                                            child: new ListView(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              // controller: _controller,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              children: List.generate(
                                                  emp_selectedlist.length,
                                                  (index) {
                                                return ListTile(
                                                  onTap: () {
                                                    setState(() {
                                                      if (selectingmode) {
                                                        emp_selectedlist[index]
                                                                .emp_selected =
                                                            !emp_selectedlist[
                                                                    index]
                                                                .emp_selected;
                                                        log(emp_selectedlist[
                                                                    index]
                                                                .userid
                                                                .toString() +
                                                            emp_selectedlist[
                                                                    index]
                                                                .emp_selected
                                                                .toString());
                                                      }
                                                      if (emp_selectedlist[
                                                                  index]
                                                              .emp_selected ==
                                                          true) {
                                                        names.add(
                                                            emp_selectedlist[
                                                                    index]
                                                                .username);
                                                        emp_id.add(
                                                            emp_selectedlist[
                                                                    index]
                                                                .userid);
                                                      } else if (emp_selectedlist[
                                                                  index]
                                                              .emp_selected ==
                                                          false) {
                                                        names.remove(
                                                            emp_selectedlist[
                                                                    index]
                                                                .username);
                                                        emp_id.remove(
                                                            emp_selectedlist[
                                                                    index]
                                                                .userid);
                                                      }
                                                      if (names.length > 0) {
                                                        names.remove(
                                                            "Select Employee");
                                                      } else {
                                                        names.add(
                                                            "Select Employee");
                                                      }
                                                    });
                                                  },
                                                  selected:
                                                      emp_selectedlist[index]
                                                          .emp_selected,
                                                  title: Text(
                                                      emp_selectedlist[index]
                                                          .username),
                                                  trailing: (selectingmode)
                                                      ? ((emp_selectedlist[
                                                                  index]
                                                              .emp_selected)
                                                          ? Icon(
                                                              Icons.check_box)
                                                          : Icon(Icons
                                                              .check_box_outline_blank))
                                                      : null,
                                                );
                                              }),
                                            ),
                                          ),
                                          visible: employeelist_showlist,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  // manager selection
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (managerlist_showlist == true) {
                                                managerlist_showlist = false;
                                              } else {
                                                managerlist_showlist = true;
                                              }
                                            });
                                            // showListwidget();
                                          },
                                          child: IgnorePointer(
                                            child: new TextField(
                                              controller:
                                                  _managerlistcontroller,
                                              decoration: InputDecoration(
                                                suffixIcon: Icon(Icons
                                                    .keyboard_arrow_down_rounded),
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                border: new OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Colors.black)),
                                                hintText: manager_names.reduce(
                                                    (value, element) =>
                                                        value + ',' + element),
                                                hintStyle: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          child: Container(
                                            child: ListView(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              children: List.generate(
                                                  manager_selectedlist.length,
                                                  (index) {
                                                return ListTile(
                                                  onLongPress: () {
                                                    setState(() {
                                                      manager_selectingmode = true;
                                                    });
                                                  },
                                                  onTap: () {
                                                    setState(() {
                                                      if (manager_selectingmode) {manager_selectedlist[index].manager_selected = !manager_selectedlist[index].manager_selected;
                                                        log(manager_selectedlist[index].userid.toString() +
                                                            manager_selectedlist[index].manager_selected.toString());}
                                                      if (manager_selectedlist[index].manager_selected == true) {
                                                        manager_names.add(manager_selectedlist[index].username);
                                                        manager_id.add(manager_selectedlist[index].userid);
                                                      } else if (manager_selectedlist[index].manager_selected == false) {
                                                        manager_names.remove(manager_selectedlist[index].username);
                                                        manager_id.remove(manager_selectedlist[index].userid);
                                                      }
                                                      if (manager_names.length > 0) {
                                                        manager_names.remove("Select Manager");
                                                      } else {
                                                        manager_names.add("Select Manager");
                                                      }
                                                    });
                                                  },
                                                  selected: manager_selectedlist[index].manager_selected,
                                                  title: Text(manager_selectedlist[index].username),
                                                  trailing: (manager_selectingmode)
                                                      ? ((manager_selectedlist[index].manager_selected)
                                                          ? Icon(
                                                              Icons.check_box)
                                                          : Icon(Icons
                                                              .check_box_outline_blank))
                                                      : null,
                                                );
                                              }),
                                            ),
                                          ),
                                          visible: managerlist_showlist,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Container(
                                        padding: new EdgeInsets.fromLTRB(
                                            5.0, 0.0, 5.0, 0.0),
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: new Border.all(
                                            width: 0.5,
                                          ),
                                        ),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: selectedItemValue,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              selectedItemValue = newValue;
                                              if (selectedItemValue ==
                                                  "Critical") {
                                                priority_id = "0";
                                              } else if (selectedItemValue ==
                                                  "High") {
                                                priority_id = "1";
                                              } else if (selectedItemValue ==
                                                  "Normal") {
                                                priority_id = "2";
                                              }
                                            });
                                          },
                                          items: <String>[
                                            'Critical',
                                            'High',
                                            'Normal',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  InkWell(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: IgnorePointer(
                                      child: new TextField(
                                        controller: _startdatecontroller,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.black)),
                                          hintText: "Start Date ",
                                          hintStyle: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  InkWell(
                                    onTap: () {
                                      _endselectDate(context);
                                    },
                                    child: IgnorePointer(
                                      child: new TextField(
                                        controller: _enddatecontroller,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.black)),
                                          hintText: "End Date ",
                                          hintStyle: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(

                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Center(

                                        child: SizedBox(
                                          width: 200.0,
                                          height: 40.0,
                                          child:  ElevatedButton(

                                            onPressed: () => addTask(context),
                                            child: const Text("Submit"),
                                          ),
                                        )
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

    if (_fileName == null) {
      _fileName = "";
    }
    if (names.length == 0) {
      names.add("Select Employee");
    }
    if (manager_names.length == 0) {
      manager_names.add("Select Manager");
    }
  }

  Future<void> _getPrefValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(ApiConstants.token);
    user_id = prefs.getString(ApiConstants.user_id);

    print("token  :" + token);
    print("userid  :" + user_id);

    _projectListBloc
        .executeLeaveList(AllListRequest(user_id, token, selected_projectId));
    _projectListBloc.subject.listen((value) {
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
          _projectlist = value.data.Result.projectlist;
        } else {
          showlist = true;
          _projectlist = value.data.Result.projectlist;

          print("projectlist" + _projectlist.toString());
        }
      }
      setState(() {
        isloading = false;
      });
    });
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      print(_paths.first.extension);
      _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
      file1 = new File(_fileName);
      _fileName = _fileName.replaceAll("(", "");
      _fileName = _fileName.replaceAll(")  ", "");
      print("file1_" + file1.toString());
    });
  }

  Widget getDropDown() {
    var items = _projectlist.map((projectshowlist) {
      return new DropdownMenuItem<ProjectListModel>(
        value: projectshowlist,
        child: new TextView(
          projectshowlist.project_name,
          fontFamily: 'Poppins-SemiBold',
          fontSize: 13,
          textColor: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      );
    }).toList();

    return DropdownButton<ProjectListModel>(
      hint: new Text("Select Project"),
      isExpanded: true,
      value: this._nameList,
      onChanged: (ProjectListModel list) {
        setState(() {
          this._nameList = list;
          selected_projectId = list.id;
          print("select id : " + selected_projectId);
          _getNewList(selected_projectId);
          if (managerlist_showlist == true) {
            managerlist_showlist = false;
          } else {
            managerlist_showlist = true;
          }
          if (employeelist_showlist ==
              true) {
            employeelist_showlist = false;
          } else {
            employeelist_showlist = true;
          }
        });
      },
      items: items,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
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
      setState(() {
        start_currentdate = date1;
        _startdatecontroller.text = ('${formatter.format(start_currentdate)}');
      });
      start_date = formatter.format(date1);
      print('gettingDate $start_currentdate');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  Future<void> _endselectDate(BuildContext context) async {
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
      setState(() {
        end_currentdate = date1;
        _enddatecontroller.text = ('${formatter.format(end_currentdate)}');
      });
      end_date = formatter.format(date1);
      print('gettingDate $end_currentdate');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  Future<void> addTask(BuildContext context) async {
    print("names" + emp_id.join(","));
    print("manager_id" + manager_id.join(","));
    FormData formData = new FormData.fromMap({
      "userid": user_id,
      "token": token,
      "start_date": start_currentdate,
      "end_date": end_currentdate,
      "title": _titlecontroller.text,
      "subject": _subjectcontroller.text,
      "description": _desccontroller.text,
      "employee": emp_id.join(","),
      "followup": manager_id.join(","),
      "priority": priority_id,
      "task_status": "2",
      "task_per": "80",
      "read_status": "1",
      "project_id": "5",
      "file":
          await MultipartFile.fromFile(_paths.first.path, filename: _fileName)
    });
    print("formData");
    print(formData);
    _addTaskBloc.executeLeaveList(AddTaskRequest(formData));
    _addTaskBloc.subject.listen((value) {
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
          // isloading = false;
          // showlist = false;

        } else {
          // showlist = true;

        }
      }
      setState(() {
        isloading = false;
      });
    });
  }

  void _getNewList(String selected_projectId) {
    _allListBloc
        .executeLeaveList(AllListRequest(user_id, token, selected_projectId));
    _allListBloc.subject.listen((value) {
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
          _managerlist = value.data.Result.managerlist;
          _employee_list = value.data.Result.employee_list;
          manager_selectedlist = _managerlist;
          emp_selectedlist = _employee_list;
        } else {
          _managerlist = value.data.Result.managerlist;
          _employee_list = value.data.Result.employee_list;
          manager_selectedlist = _managerlist;
          emp_selectedlist = _employee_list;

          manager_selectedlist.forEach((p) => p.manager_selected = false);
          emp_selectedlist.forEach((p) => p.emp_selected = false);

          print("managerlist" + _managerlist.toString());
          print("_employee_list" + _employee_list.toString());
        }
      }
    });
  }
}
