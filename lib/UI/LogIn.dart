//import 'dart:ffi';
//import 'dart:math';

import 'package:redwinners/UI/StuffPannel.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PhoneNumber.dart';
import 'home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _rememberMe = true;
  String company = "Red Winners";
  String userName = "";
  String passWord = "";
  String index = "";
  String random = "";
  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);
    return Scaffold(
        body:
            Container(//BackGround
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [
              //     Colors.redAccent.shade200,
              //     Colors.redAccent.shade400,
              //     Colors.redAccent.shade700,
              //     Colors.redAccent.shade400,
              //   ],
              //    stops: [.1,.4,.7,.9]
              // )
            ),
              child:  ListView(
                  children: [ Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    textDirection: TextDirection.ltr,
                    children: [

                      Image(
                          width: 300,
                          height: 300,
                          image: AssetImage('assets/redwinners.png')),//logo
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget> [
                          Container(
                          margin: EdgeInsets.only(left: 20, bottom: 20, right: 20),
                          alignment: Alignment.centerLeft,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                              ),
                              BoxShadow(
                                color: Colors.grey.shade100,
                                spreadRadius: -2.0,
                                blurRadius: 2.0,
                              ),
                            ],
                          ),
                          child: TextField(
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: new InputDecoration(
                                hintText: loc!.userNameHint,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  //color: Colors.redAccent,
                                )
                            ),
                            onChanged: (newValue){
                              userName = newValue;
                            },
                          ),
                        ),// UserName
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            alignment: Alignment.centerLeft,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  spreadRadius: -2.0,
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            child: TextField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: new InputDecoration(
                                  hintText: loc!.passwordHint,
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    //color: Colors.redAccent,
                                  )
                              ),
                              onChanged: (newValue){
                                passWord = newValue;
                              },
                            ),
                          ), //Password
                          Container( margin: EdgeInsets.only(left: 10, right: 30),
                            child: Row(
                              children: [
                                Theme(
                                      data: ThemeData(unselectedWidgetColor: Colors.grey.shade200),
                                      child: Checkbox(

                                        value: _rememberMe,
                                      onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value!;
                                      });
                                      },

                                    checkColor: Colors.black,
                                    activeColor: Colors.grey.shade200,
                                    focusColor: Colors.white,
                                  hoverColor: Colors.white,),
                                ),
                                Text(loc!.rememberMe, ),
                              ],
                            ),
                          ),// Remember me, Sign up
//
                          Container( margin: EdgeInsets.all(20),
                              child:ElevatedButton(
                                onPressed: () {
                                        if(userName == "Staff.Ah90"){
                                          company = "Staff";
                                          userName = "Ah90";
                                        }
                                        if(userName == "Axa.User7"){
                                          company = "Axa";
                                          userName = "User7";
                                        }
                                  Prevalent.logInProtocol(company, userName,passWord,context,_rememberMe);
                                },
                                style:mainTheme,
                                child: Text(loc!.logIn),)),
                      ],
                    ),
                  ]
              ),
            ),
            ]
          ),

        )


    );
  }


}
