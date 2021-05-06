import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/AllUserList/AllUserListBloc.dart';
import 'package:flutter_app/AllUserList/AllUserListModel.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_app/Task/ViewTask/ViewTaskScreen.dart';
import 'package:flutter_app/utilities/TextView.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllUserListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_AllUserListScreen();

}

class _AllUserListScreen extends State<AllUserListScreen> {
  AllUserListBloc _allUserListBloc = AllUserListBloc();

  String token = "";
  String user_id = "";
  List<UserList> _list;
  bool isloading = true;
  bool showlist = false;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Employee List"),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                _onBackPressed();
              },
            ),
          ),
          body: isloading
              ? Center(child: CircularProgressIndicator())
              : Column(
            children: <Widget>[

              Visibility(
                  visible: showlist,
                  child: Expanded(child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    itemCount: _list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          child: Card(
                            color: Colors.grey[300],
                            // elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  //height: 1500.0,
                                  child: Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          TextView(
                                            _list[index].username.toString(),
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 16,
                                            textAlign: TextAlign.start,
                                            textColor: Colors.black,
                                          ),

                                        ],
                                      )
                                    ],
                                  )),
                            ),
                          ),
                      onTap: (){
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => ViewTaskScreen()));
                        ApiConstants.clickeduser_id= _list[index].userid.toString();

                      },);
                    },
                  )
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
          )
      ),
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

    _allUserListBloc.executeAllUserList(CommonRequest(user_id, token));
    _allUserListBloc.subject.listen((value) {
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
          _list = value.data.Result.userlist;
        } else {
          showlist = true;
          _list = value.data.Result.userlist;
        }
      }
      setState(() {
        isloading = false;
      });
    });
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
}