import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/utilities/constants.dart';
import 'package:flutter_app/validation/validation.dart';

class InputData{


  static Widget buildNameTF(TextEditingController myText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: kLabelStyle,
        ),

        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            textCapitalization: TextCapitalization.words,
            controller: myText,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            validator: ValidationData.firstNameValidate,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  static Widget buildEmailTF(TextEditingController myText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            textCapitalization: TextCapitalization.words,
            controller: myText,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            validator: ValidationData.emailValidate,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  static Widget buildPasswordTF(TextEditingController myText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child:  TextFormField(
            controller: myText,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            validator: ValidationData.passwordValidate,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  static Widget buildNumberTF(TextEditingController myText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   'Phone Number',
        //   style: kLabelStyle,
        //
        // ),
        // SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child:  TextFormField(
            controller: myText,
            obscureText: false,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',

            ),
            validator: ValidationData.mobileValidate,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.call,
                color: Colors.black,
              ),
              hintText: 'Enter your Phone Number',
              hintStyle: kHintTextStyle,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
          ),
        ),
      ],
    );
  }

  static Widget buildLoginBtn(var buttonTitle, Function function) {
    return Container(
      height: 90,
      padding: EdgeInsets.only(right: 40,left: 40,bottom: 15,top: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          function();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.cyan,
        child: Text(
          buttonTitle,
          style: TextStyle(
            color:  Colors.white,
            letterSpacing: 1.5,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  static Widget buildSignupSigninBtn(var quetion, var pageName, Function function) {
    return Padding(padding: EdgeInsets.only(bottom: 0,top: 5),child: GestureDetector(
      onTap: () {
        function();
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: quetion,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: pageName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),);
  }

  static Widget yourAppbar(var title, Icon icon, Function function){
    return AppBar(
      centerTitle: true,
      backgroundColor: Color(0xFF73AEF5),
      title: Text(title,style: TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
      ),),
      actions: <Widget>[
        IconButton(icon: icon, onPressed: (){
          function();
        })
      ],
    );
  }

}