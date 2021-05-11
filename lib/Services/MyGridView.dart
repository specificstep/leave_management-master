import 'package:flutter/material.dart';
import 'package:flutter_app/AllUserList/AllUserListScreen.dart';
import 'package:flutter_app/BithdayList/BirthdayListScreen.dart';
import 'package:flutter_app/KRAManagement/ADDKRAScreen.dart';
import 'package:flutter_app/LeaveBalance/LeaveBalanceScreen.dart';
import 'package:flutter_app/LeaveList/LeaveListScreen.dart';
import 'package:flutter_app/Task/AddTaskScreen.dart';
import 'package:flutter_app/Task/MyApp.dart';
import 'ServicesList.dart';

class MyGridView extends StatelessWidget {
  final List<ServicesList> allServices;
  MyGridView({Key key, this.allServices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(10.0),
      childAspectRatio: 5.0 / 4.0, // 8.0/9.0
      children: _getGridViewItems(context),
    );
  }
//  _getGridViewItems_1(BuildContext context){
//    List<Widget> allWidgets = new List<Widget>();
//    for (int i = 0; i < allServices.length; i++) {
//      var widget = new Text(allServices[i].name);
//      allWidgets.add(widget);
//    };
//    return allWidgets;
//  }

  _getGridViewItems(BuildContext context) {
    List<Widget> allWidgets = new List<Widget>();
    for (int i = 0; i < allServices.length; i++) {
      var widget = _getGridItemUI(context, allServices[i]);
      allWidgets.add(widget);
    };
    return allWidgets;
  }

  // Create individual item
  _getGridItemUI(BuildContext context, ServicesList item) {
    return new InkWell(
        onTap: () {
          // _showSnackBar(context, item);

          if("${item.servicename}"=="Leave tracker"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LeaveListScreen()));

          }else if("${item.servicename}"=="Leave balance"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LeaveBalanceScreen()));

          }else if("${item.servicename}"=="BirthDays"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BirthdayListScreen()));
          }else if("${item.servicename}"=="Task"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddTaskScreen()));
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllUserListScreen()));
          }else if("${item.servicename}"=="kRA"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ADDKRAScreen()));
          }
        },
        child: new Card(
          color: Colors.grey[300],
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  child: new Center(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Image.asset(
                            "assets/" + item.image,
                            fit: BoxFit.fitWidth,
                            scale: 2.0,

                            //height:100.0,
                          ),
                          new SizedBox(height: 10.0),

                          new Text(
                            item.servicename,
                            style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                             color: Colors.black,
                            ),
                          ),
                          // new Text(item.country),
                          // new Text('Population \n ${item.population}' , textAlign: TextAlign.center,)
                        ],
                      )))
            ],
          ),
          elevation: 2.0,
          margin: EdgeInsets.all(5.0),
        ));
  }

  /// This will show snackbar at bottom when user tap on Grid item
  _showSnackBar(BuildContext context, ServicesList item) {
    final SnackBar objSnackbar = new SnackBar(
      content: new Text("${item.servicename}"),
      backgroundColor: Colors.black,
    );

    Scaffold.of(context).showSnackBar(objSnackbar);
  }
}
