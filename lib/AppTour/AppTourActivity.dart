import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Login/login_screen_old.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppTourActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Stack(children: <Widget>[
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin:
                EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 80.0),
            padding:
                EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
            child: MaterialApp(
              home: IntroScreen(),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.0),
                    child: FlatButton(
                      height: 40,
                        textColor: Colors.white,
                      color: Colors.cyan,
                      child: Text("Sign In"),
                      onPressed: () async {
                        // ApiConstants.instance.setStringValue("key", value);
                        // MySharedPreferences.instance
                        //     .setBooleanValue(ApiConstants.show_firsttime, true);
                        // MySharedPreferences.instance
                        //     .setBooleanValue("loggedin", true);

                        SharedPreferences  prefs = await SharedPreferences .getInstance();
                        prefs.setBool(ApiConstants.show_firsttime, true);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen_old()));
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  )))
        ]),
        // end Padding()
      ), // end Container()
    );
  }
}

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

//------------------ Custom your own tabs ------------------
class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  Function goToTab;

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        title: "TRACK ATTENDANCE & MANAGE SHIFTS",
        styleTitle: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Manage employee shifts and access their weekly/monthly attendance reports.",
        styleDescription: TextStyle(
            color: Colors.black, fontSize: 16.0, fontFamily: 'Raleway'),
        pathImage: "assets/images/screen1.png",
      ),
    );
    slides.add(
      new Slide(
        title: "INSTANTLY CHECK-IN OR CHECK-OUT",
        styleTitle: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description: "Mark the start and end of your workday with just a tap.",
        styleDescription: TextStyle(
            color: Colors.black, fontSize: 16.0, fontFamily: 'Raleway'),
        pathImage: "assets/images/screen2.png",
      ),
    );
    slides.add(
      new Slide(
        title: "APPROVE OR REJECT REQUESTS",
        styleTitle: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "All it takes is a single tap for employee to submit leave requests and for managers to approve them.",
        styleDescription: TextStyle(
            color: Colors.black, fontSize: 16.0, fontFamily: 'Raleway'),
        pathImage: "assets/images/screen3.png",
      ),
    );
  }

  void onDonePress() {
    // Back to the first tab
    //this.goToTab(0);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen_old()));
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.cyan,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    /*return Icon(
      Icons.done,
      color: Color(0xffffcc5c),
    );*/
    Padding(
      padding: EdgeInsets.only(left: 150.0, right: 0.0),
      child: RaisedButton(
        textColor: Colors.white,
        color: Colors.black,
        child: Text("Sign In"),
        onPressed: () {
          onDonePress();
        },
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.cyan,
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 30.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      /*renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Color(0x33ffcc5c),
      highlightColorSkipBtn: Color(0xffffcc5c),*/
      renderSkipBtn: Visibility(
        visible: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Text(
              "Search",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),

      renderNextBtn: Visibility(
        visible: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Text(
              "Search",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),

      renderPrevBtn: Visibility(
        visible: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Text(
              "Search",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),

      renderDoneBtn: Visibility(
        visible: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Text(
              "Search",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),

      // Next button
      /*renderNextBtn: this.renderNextBtn(),*/

      // Done button
      /*renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0x33ffcc5c),
      highlightColorDoneBtn: Color(0xffffcc5c),*/

      /*// Sign In Button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0x33ffcc5c),
      highlightColorDoneBtn: Color(0xffffcc5c),*/

      // Dot indicator
      colorDot: Colors.cyan,
      sizeDot: 11.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Show or hide status bar
      // shouldHideStatusBar: true,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}
