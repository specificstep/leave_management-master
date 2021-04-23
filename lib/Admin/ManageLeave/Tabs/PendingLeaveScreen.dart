import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Admin/ManageLeave/ApproveOrRejectLeave/ApproveOrRejectBloc.dart';
import 'package:flutter_app/Admin/ManageLeave/ApproveOrRejectLeave/ApproveOrRejectRequest.dart';
import 'package:flutter_app/Admin/ManageLeave/ManageLeaveBloc.dart';
import 'package:flutter_app/Admin/ManageLeave/ManageLeaveModel.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_app/utilities/TextView.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PendingLeaveScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PendingLeaveScreen();
}

class _PendingLeaveScreen extends State<PendingLeaveScreen> {
  String token = "";
  String user_id = "";
  List<ManageLeaveList> _list;
  List<ManageLeaveList> Pendinglist = [];
  bool isloading = true;
  bool showlist = false;
  ManageLeaveBloc _manageLeaveBloc = ManageLeaveBloc();
  ApproveOrRejectBloc _approveOrRejectBloc = ApproveOrRejectBloc();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          body: isloading
              ? Center(child: CircularProgressIndicator())
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
             Expanded(child:  Visibility(
                 visible: showlist,
                 child: ListView.builder(
                   padding: EdgeInsets.all(10),
                   shrinkWrap: true,
                   itemCount: Pendinglist.length,
                   itemBuilder: (BuildContext context, int index) {
                     String  str_reason= "Leave Reason : " + Pendinglist[index].leave_reason.toString();
                     return GestureDetector(
                         child:
                         Card(
                           color: Colors.grey[300],
                           // elevation: 5,
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                                 width: MediaQuery.of(context).size.width,
                                 //height: 1500.0,
                                 child: Column(
                                   crossAxisAlignment:
                                   CrossAxisAlignment.start,

                                   children: [
                                     TextView(
                                       "Name : " +
                                           Pendinglist[index]
                                               .user_name
                                               .toString(),
                                       fontFamily: 'Poppins-SemiBold',
                                       fontSize: 16,
                                       textAlign: TextAlign.start,
                                       textColor: Colors.black,
                                     ),
                                     TextView(
                                       "Leave Date : " +
                                           Pendinglist[index]
                                               .start_date
                                               .toString(),
                                       fontFamily: 'Poppins-Regular',
                                       fontSize: 16,
                                       textAlign: TextAlign.start,
                                       textColor: Colors.black,
                                     ),
                                     TextView(
                                       "Leave Type : " +
                                           Pendinglist[index]
                                               .leave_type
                                               .toString(),
                                       fontFamily: 'Poppins-Regular',
                                       fontSize: 16,
                                       textAlign: TextAlign.start,
                                       textColor: Colors.black,
                                     ),
                                     TextView(
                                       "fullday/half_day : " +
                                           Pendinglist[index]
                                               .fullhalf_day
                                               .toString(),
                                       fontFamily: 'Poppins-Regular',
                                       fontSize: 16,
                                       textAlign: TextAlign.start,
                                       textColor: Colors.black,
                                     ),
                                     TextView(
                                       "Total days : " +
                                           Pendinglist[index]
                                               .total_day
                                               .toString(),
                                       fontFamily: 'Poppins-Regular',
                                       fontSize: 16,
                                       textAlign: TextAlign.start,
                                       textColor: Colors.black,
                                     ),
                                     // AutoSizeText(
                                     //   "Leave Reason : "+ Pendinglist[index].leave_reason.toString(),
                                     //   style: TextStyle(fontSize: 16.0,
                                     //   color: Colors.black),
                                     //   maxLines: 2,
                                     // ),
                                     Center(
                                       child: Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: <Widget>[
                                             Expanded(
                                               child:  TextView(
                                                 "Leave Reason : " + Pendinglist[index].leave_reason.toString(),
                                                 fontFamily: 'Poppins-Regular',
                                                 fontSize: 16,
                                                 textAlign: TextAlign.start,
                                                 textColor: Colors.black,
                                               ),
                                             )
                                           ]),
                                     ),

                                     SizedBox(height: 10.0),
                                     Row(
                                       children: <Widget>[
                                         FlatButton(
                                           height: 40,
                                           minWidth: 120,
                                           color: Colors.lightGreen,
                                           // textColor: Colors.white,
                                           shape: RoundedRectangleBorder(
                                               borderRadius:
                                               BorderRadius.circular(
                                                   50.0),
                                               side: BorderSide(
                                                   color: Colors
                                                       .lightGreen)),
                                           onPressed: () async {
                                             // Approve Api call
                                             _showDialog(context, "2",index);

                                           },
                                           child: Text(
                                             "Approve",
                                             style: new TextStyle(
                                               fontSize: 16.0,
                                               color: Colors.white,
                                             ),
                                           ),
                                         ),
                                         SizedBox(width: 10.0),
                                         FlatButton(
                                           height: 40,
                                           minWidth: 120,
                                           color: Colors.red,
                                           // textColor: Colors.white,
                                           shape: RoundedRectangleBorder(
                                               borderRadius:
                                               BorderRadius.circular(
                                                   50.0),
                                               side: BorderSide(
                                                   color: Colors.red)),
                                           onPressed: () async {
                                             //reject
                                            _showDialog(context, "3",index);
                                           },
                                           child: Text(
                                             "Reject",
                                             style: new TextStyle(
                                               fontSize: 16.0,
                                               color: Colors.white,
                                             ),
                                           ),
                                         ),
                                       ],
                                     )
                                   ],
                                 )
                             ),
                           ),
                         ));
                   },
                 )
             ),),
              Visibility(
                  visible: showlist == false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: TextView(
                          "No Data Found",
                          fontFamily: 'Poppins-SemiBold',
                          fontSize: 18,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                          textColor: Colors.cyan,
                        ),
                      )
                    ],
                  ))
            ],
          ))    );
  }

  @override
  void initState() {
    super.initState();
    _getPrefValue();
  }
  void _showDialog(BuildContext context, String leave_id,int index) {
    String remark="";
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Reason"),
            content: Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        hintText: 'Enter Reason'),
                    onChanged: (value){
                      remark=value;
                  },
                  ),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok'),
                  onPressed: () async {
                    print("remark" + remark);
                    Navigator.pop(context, false);
                    try {

                      final result = await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                        _approveOrRejectBloc.executeApproveOrRejectApi(
                            ApproveOrRejectRequest(
                                user_id,
                                token,
                                Pendinglist[index].id.toString(),
                                Pendinglist[index].users_id.toString(), leave_id,
                                Pendinglist[index].leave_type
                                    .toString(),remark));
                        getApproveOrRejectResponse(context);
                        print("remark" + remark);
                      }
                    } on SocketException catch (_) {
                      Fluttertoast.showToast(
                          msg:
                          "Please Check Internet Connection",
                          toastLength: Toast
                              .LENGTH_SHORT,
                          gravity: ToastGravity
                              .BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor:
                          Colors.red,
                          textColor:
                          Colors.white,
                          fontSize: 16.0);
                      print('not connected');
                    }
                  }),
            ],
          );
        });
  }

  Future<void> _getPrefValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(ApiConstants.token);
    user_id = prefs.getString(ApiConstants.user_id);

    print("token  :" + token);
    print("userid  :" + user_id);

    _manageLeaveBloc.executeLeaveList(CommonRequest(user_id, token));
    _manageLeaveBloc.subject.listen((value) {
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
          _list = value.data.Result.birthdaylist;
        } else {
          if (Pendinglist.length > 0) {
            Pendinglist.clear();
          }
          _list = value.data.Result.birthdaylist;
          if (_list.length > 0) {
            for (int i = 0; i < _list.length; i++) {
              if (_list[i].leave_status == "Pending") {
                Pendinglist.add(_list[i]);
              }
            }
            if (Pendinglist.length > 0) {
              showlist = true;
            } else {
              showlist = false;
            }
            print("Pendinglist  :" + Pendinglist.toString());
          }
        }
      }
      setState(() {
        isloading = false;
      });
    });
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


  void getApproveOrRejectResponse(BuildContext context) {
    _approveOrRejectBloc.subject.listen((value) async {
      if (value.data.Result.status == "1") {
        String message = value.data.Result.message;
        setState(() {
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          _getPrefValue();
        });
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
      }
    });
  }
}
