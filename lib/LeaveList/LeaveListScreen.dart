import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/LeaveBalance/AddLeaveRedirectScreen.dart';
import 'package:flutter_app/LeaveList/CancleLeave/CancleLeaveBloc.dart';
import 'package:flutter_app/LeaveList/CancleLeave/CancleLeaveRequest.dart';
import 'package:flutter_app/LeaveList/LeaveListBloc.dart';
import 'package:flutter_app/LeaveList/LeaveListModel.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_app/utilities/TextView.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeaveListState();
}

class _LeaveListState extends State<LeaveListScreen> {
  bool isloading = true;
  List<LeaveList> leavelist;
  LeaveListBloc _leaveListBloc = LeaveListBloc();
  CancleLeaveBloc _cancleLeaveBloc = CancleLeaveBloc();
  String token = "";
  String user_id = "";
  String leave_status = "";
  bool showcanclebtn = true;
  bool showlist = false;

  @override
  void initState() {
    _getPrefValue();
    super.initState();
  }

  Future<void> _getPrefValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(ApiConstants.token);
    user_id = prefs.getString(ApiConstants.user_id);

    print("token  :" + token);
    print("userid  :" + user_id);

    _leaveListBloc.executeLeaveList(LeaveListRequest(user_id, token));
    _leaveListBloc.subject.listen((value) {
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
          leavelist = value.data.Result.leavelist;
        } else {
          showlist = true;
          leavelist = value.data.Result.leavelist;
        }
      }

      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Leave List"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ),
        body: isloading
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                      visible: showlist,
                      child: Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(10),
                          shrinkWrap: true,
                          itemCount: leavelist.length,
                          itemBuilder: (BuildContext context, int index) {
                            leave_status =
                                leavelist[index].leave_status.toString();

                            if (leave_status == "Reject" ||
                                leave_status == "Cancel" ||
                                leave_status == "Approve") {
                              showcanclebtn = false;
                            } else {
                              showcanclebtn = true;
                            }
                            return GestureDetector(
                                child: Card(
                              color: Colors.grey[300],
                              // elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    //height: 1500.0,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.all(10.0),
                                                  padding: EdgeInsets.all(10.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.cyan),
                                                  child: TextView(
                                                    leavelist[index]
                                                            .total_day
                                                            .toString() +
                                                        "\ndays",
                                                    fontFamily:
                                                        'Poppins-SemiBold',
                                                    fontSize: 12,
                                                    textAlign: TextAlign.center,
                                                    textColor: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextView(
                                                  leavelist[index].leave_type +
                                                      " : ",
                                                  fontFamily:
                                                      'Poppins-SemiBold',
                                                  fontSize: 16,
                                                  textAlign: TextAlign.start,
                                                ),
                                                TextView(
                                                  leavelist[index].start_date,
                                                  fontFamily: 'Poppins-Regular',
                                                  fontSize: 16,
                                                  textAlign: TextAlign.start,
                                                ),
                                                TextView(
                                                  leavelist[index].leave_status,
                                                  fontFamily: 'Poppins-Regular',
                                                  fontSize: 16,
                                                  textAlign: TextAlign.start,
                                                  textColor: getColor(
                                                      leavelist[index]
                                                          .leave_status),
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                          flex: 3,
                                          child: Visibility(
                                            visible: showcanclebtn,
                                            child: FlatButton(
                                              height: 40,
                                              minWidth: 300,
                                              color: Colors.red,
                                              // textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  side: BorderSide(
                                                      color: Colors.red)),
                                              onPressed: () async {
                                                print(leavelist[index].id);

                                                _cancleLeaveBloc.executecancleLeave(
                                                        CancleLeaveRequest(user_id, token,
                                                            leavelist[index].id.toString()));
                                                getCancleLeaveResponse();
                                              },
                                              child: Text(
                                                "cancel",
                                                style: new TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ));
                          },
                        ),
                      )),
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
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => new AddLeaveRedirectScreen()),
                ModalRoute.withName("/Home"));
          },
          label: Text('Add Leave'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.cyan,
        ),
      ),
    );
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


  Color getColor(String leave_status) {
    if (leave_status == "Approve") return Colors.green;
    if (leave_status == "Reject") return Colors.red;
    if (leave_status == "Cancel") return Colors.red;
    if (leave_status == "Pending") return Colors.yellow[800];
  }

  void getCancleLeaveResponse() {
    _cancleLeaveBloc.subject.listen((value) async {
      print("Status :${value.status}");
      if (value.data.Result.status == "1") {
        print("status_fromres:${value.data.Result.status}");
        String message = value.data.Result.message;
        _showToast(message);

        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      } else {
        setState(() {
          String message = value.data.Result.message;
          // _showDialog(context, message);
          _showToast(message);
        });
      }
      isloading = false;
    });
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
