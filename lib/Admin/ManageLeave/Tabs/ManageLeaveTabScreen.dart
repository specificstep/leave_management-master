import 'package:flutter/material.dart';
import 'ManageLeaveScreen.dart';
import 'PendingLeaveScreen.dart';
import 'RejectLeaveScreen.dart';

class ManageLeaveTabScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManageLeaveTabScreen();
}

class _ManageLeaveTabScreen extends State<ManageLeaveTabScreen> {

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              bottom: TabBar(
                tabs: [
                  new Tab(text: "Pending"),
                  new Tab(text: "Approved"),
                  new Tab(text: "Reject"),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              new PendingLeaveScreen(),
              new ManageLeaveScreen(),
              new RejectLeaveScreen()
            ],
          ),
        ));
    // TODO: implement build
  }

  @override
  void initState() {
    super.initState();
  }

}
