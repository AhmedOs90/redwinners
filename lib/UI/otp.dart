import 'dart:async';

import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'LogIn.dart';
import 'home.dart';

class OTP extends StatefulWidget {
  final String Phone;
  String src;
  OTP(this.Phone,this.src);

  @override
  State<OTP> createState() => _OTPState(this.Phone, this.src);

}

class _OTPState extends State<OTP> {
  String _verifcation ="1";
  String Pin = "";
  String Src;
  late Timer _timer;
  int _start = 45;
  double progress = 0.0;
  int? ReToken;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  var counter = 30;
  @override
  void initState() {
    VerifyPhone(phone1);
    startTimer();
    super.initState();
  }

  _OTPState(this.phone1, this.Src);
  final String phone1;
  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);
    return Scaffold(
      body:
      Container(
        height: double.infinity,
        width: double.infinity,
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         colors: [
        //           Colors.redAccent.shade700,
        //           Colors.redAccent.shade700,
        //           Colors.redAccent.shade400,
        //           Colors.redAccent.shade300,
        //         ],
        //         stops: [.1, .4, .7, .9]
        //     )
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appHeadWithBack(loc!.verify,Icons.verified_user,false,context),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(loc!.sendingCodeTo +phone1+"..",textAlign: TextAlign.center,style:  TextStyle(
                        letterSpacing: 2,
                        color: Colors.grey.shade800,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 2.0),
                            blurRadius: 15.0,
                            color: Colors.black.withOpacity(.5),
                          ),
                        ]
                    ),),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                      child: Pinput(length: 6,
                        onCompleted: (pin){
                          Pin = pin;
                          ProgressDialogue(context, loc!.verifying);
                          verify(pin);
                        },
                        onSubmitted: (pin){
                          Pin = pin;
                         ProgressDialogue(context, loc!.verifying);
                          verify(pin);
                        },)),
                ),

                    Container(margin: EdgeInsets.all(20),
                        child: ElevatedButton(
                          onPressed: _start == 0?() {
                            setState(() {
                              _start = -1;
                            });
                            reVerifyPhone(phone1);
                          }:null,
                          style: mainTheme,
                          child: _start > 0? Text(loc!.resendCodeIn + _start.toString()):Text(loc!.resendCode),)),


          ],
        ),
      )
    );
  }
  verify(pin) async {
    var loc = AppLocalizations.of(context);
    try {
      await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider
          .credential(verificationId: _verifcation, smsCode: pin)).then((
          value) =>
      {
        if(value.user != null)
          {
            if (Src == "SignUp"){
              showDialog<String>(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) =>

                      AlertDialog(
                        title: Text(loc!.phoneVerified),
                        content: Text(loc!.continueToCreateAccount),
                        actions: <Widget>[

                          TextButton(
                            onPressed: () =>
                            {
                              Navigator.pop(context),
                              Navigator.pushAndRemoveUntil(
                                  context, MaterialPageRoute(builder:
                                  (context) => Login()), (route) => false)
                            },
                            child: Text(loc!.continu),
                          ),
                        ],
                      ))
            }
            else if (Src == "login"){
              showDialog<String>(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        title: Text(loc!.phoneVerified),
                        content: Text(loc!.continueToHome),
                        actions: <Widget>[

                          TextButton(
                            onPressed: () =>
                            {

                              Prevalent.logInProtocol(Prevalent.currentOnlineUser.accountName, Prevalent.currentOnlineUser.userName, Prevalent.currentOnlineUser.password, context, true)

                            },
                            child: Text(loc!.continu),
                          ),
                        ],
                      ))
            }
          }
        else {
          showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: Text(loc!.problemEncountered),
                    content: Text(loc!.pleaseTryAgain),
                    actions: <Widget>[

                      TextButton(
                        onPressed: () =>
                        {
                          Navigator.pop(context),
                          Navigator.pop(context),
                        },
                        child: Text(loc!.continu),
                      ),
                    ],
                  ))

        }
      });
    }
    catch (e) {

      FocusScope.of(context).unfocus();
      showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: Text(loc!.invalidOTP),
                content: Text(loc!.pleaseTryAgain),
                actions: <Widget>[

                  TextButton(
                    onPressed: () =>
                    {
                      Navigator.pop(context),
                      Navigator.pop(context)
                    },
                    child: Text(loc!.ok),
                  ),
                ],
              ));
    }
  }
    VerifyPhone(String phone) async{
        await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: phone,
            verificationCompleted:  (PhoneAuthCredential credential) async {
              await FirebaseAuth.instance
                  .signInWithCredential(credential)
                  .then((value) async {
                if (value.user != null) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                          (route) => false);
                }
              });
            },
            verificationFailed: (exc){},
            codeSent: (code, reSend){
              ReToken = reSend;
            _verifcation = code;
            },
            codeAutoRetrievalTimeout: (code){
              setState(() {
                _verifcation = code;
              });
            },
            timeout: Duration(seconds: 60),

            );

}
    reVerifyPhone(phone) async{
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted:  (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                      (route) => false);
            }
          });
        },
        verificationFailed: (exc){},
        codeSent: (code, reSend){
          ReToken = reSend;
          _verifcation = code;
        },
        codeAutoRetrievalTimeout: (code){
          setState(() {
            _verifcation = code;
          });
        },
        timeout: Duration(seconds: 120),
        forceResendingToken: ReToken
      );

    }


    ProgressDialogue(BuildContext context,String message){
      showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: Text(message),
                content: Container(
                    width: 30,
                    height: 60,
                      child: Center(child: CircularProgressIndicator(color: Colors.redAccent,))),

                actions: <Widget>[

                  // TextButton(
                  //   onPressed: () =>
                  //   {
                  //     Navigator.pop(context),
                  //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                  //         (context) => SignUp(phone)), (route) => false)
                  //   },
                  //   child: const Text('Continue..'),
                  // ),
                ],
              ));
    }
}
