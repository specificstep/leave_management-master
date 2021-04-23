import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Admin/ManageLeave/ManageLeaveBloc.dart';
import 'package:flutter_app/Admin/ManageLeave/ManageLeaveModel.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_app/utilities/TextView.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageLeaveScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManageLeaveScreen();
}

class _ManageLeaveScreen extends State<ManageLeaveScreen> {
  String token = "";
  String user_id = "";
  List<ManageLeaveList> _list;
  List<ManageLeaveList> Approvedlist = [];
  bool isloading = true;
  bool showlist = false;
  ManageLeaveBloc _manageLeaveBloc = ManageLeaveBloc();

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
                    itemCount: Approvedlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      String  str_reason= "Leave Reason : " + Approvedlist[index].leave_reason.toString();
                      return GestureDetector(
                          child: Card(
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
                                            Approvedlist[index]
                                                .user_name
                                                .toString(),
                                        fontFamily: 'Poppins-SemiBold',
                                        fontSize: 16,
                                        textAlign: TextAlign.start,
                                        textColor: Colors.black,
                                      ),
                                      TextView(
                                        "Leave Date : " +
                                            Approvedlist[index]
                                                .start_date
                                                .toString(),
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 16,
                                        textAlign: TextAlign.start,
                                        textColor: Colors.black,
                                      ),
                                      TextView(
                                        "Leave Type : " +
                                            Approvedlist[index]
                                                .leave_type
                                                .toString(),
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 16,
                                        textAlign: TextAlign.start,
                                        textColor: Colors.black,
                                      ),
                                      TextView(
                                        "fullday/half_day : " +
                                            Approvedlist[index]
                                                .fullhalf_day
                                                .toString(),
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 16,
                                        textAlign: TextAlign.start,
                                        textColor: Colors.black,
                                      ),
                                      TextView(
                                        "Total days : " +
                                            Approvedlist[index]
                                                .total_day
                                                .toString(),
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 16,
                                        textAlign: TextAlign.start,
                                        textColor: Colors.black,
                                      ),
                                      // AutoSizeText(
                                      //   "Leave Reason : "+ Approvedlist[index].leave_reason.toString(),
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
                                                  "Leave Reason : " + Approvedlist[index].leave_reason.toString(),
                                                  fontFamily: 'Poppins-Regular',
                                                  fontSize: 16,
                                                  textAlign: TextAlign.start,
                                                  textColor: Colors.black,
                                                ),
                                              )
                                            ]),
                                      ),
                                      Center(
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                child:  TextView(
                                                  "Leave Remark : " + Approvedlist[index].remark.toString(),
                                                  fontFamily: 'Poppins-Regular',
                                                  fontSize: 16,
                                                  textAlign: TextAlign.start,
                                                  textColor: Colors.black,
                                                ),
                                              )
                                            ]),
                                      ),

                                      SizedBox(height: 10.0),

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
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    _getPrefValue();
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
          if (Approvedlist.length > 0) {
            Approvedlist.clear();
          }
          _list = value.data.Result.birthdaylist;
          if (_list.length > 0) {
            for (int i = 0; i < _list.length; i++) {
              if (_list[i].leave_status == "Approve") {
                Approvedlist.add(_list[i]);
              }
            }
            if (Approvedlist.length > 0) {
              showlist = true;
            } else {
              showlist = false;
            }
            print("Approvedlist  :" + Approvedlist.toString());
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

}
