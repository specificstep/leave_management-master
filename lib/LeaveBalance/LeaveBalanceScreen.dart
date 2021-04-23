import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/LeaveBalance/AddLeaveRedirectScreen.dart';
import 'package:flutter_app/LeaveBalance/LeaveBalanceListBloc.dart';
import 'package:flutter_app/LeaveBalance/LeaveBalanceModel.dart';
import 'package:flutter_app/LeaveList/LeaveListRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_app/utilities/TextView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveBalanceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeaveBalanaceState();
}

class _LeaveBalanaceState extends State<LeaveBalanceScreen> {
  List<LeaveBalanceList> _list;
  LeaveBalanceListBloc _balanceListBloc = LeaveBalanceListBloc();
  String token = "";
  String user_id = "";
  bool isloading = true;
  String leavename = "";
  String no_leave = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Leave Balance"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ),
        body: isloading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index) {
                  leavename = _list[index].leave_name;
                  no_leave = "Balance :" + _list[index].no_leave;
                  List<String> names = leavename.split(" ");

                  String initials = "";
                  int numWords = 2;

                  if (numWords < names.length) {
                    numWords = names.length;
                  }
                  for (var i = 0; i < numWords; i++) {
                    initials += '${names[i][0]}';
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(12.0),
                                    padding: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.cyan),
                                    child: TextView(
                                      initials,
                                      fontFamily: 'Poppins-SemiBold',
                                      fontSize: 12,
                                      textAlign: TextAlign.center,
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              )),
                              Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TextView(
                                        _list[index].leave_name,
                                        fontFamily: 'Poppins-SemiBold',
                                        fontSize: 16,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      TextView(
                                        no_leave,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 16,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  )),
                            ],
                          )),
                    ),
                  ));
                },
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AddLeaveRedirectScreen()));
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


  @override
  void initState() {
    // TODO: implement initState
    _getPrefValue();
    super.initState();
  }

  Future<void> _getPrefValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(ApiConstants.token);
    user_id = prefs.getString(ApiConstants.user_id);

    print("token  :" + token);
    print("userid  :" + user_id);

    _balanceListBloc.executeLeaveBalanceList(LeaveListRequest(user_id, token));

    _balanceListBloc.subject.listen((value) {
      if (value.status == Status.SUCCESS) {
        _list = value.data.Result.leavebalacelist;
        print(_list);
        setState(() {
          isloading = false;
        });
      }
    });
  }
}
