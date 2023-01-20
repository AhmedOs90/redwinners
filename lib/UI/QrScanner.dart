
import 'dart:async';

import 'package:redwinners/engines/prevelant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home.dart';

class QrCode extends StatefulWidget {
  const QrCode({Key? key}) : super(key: key);

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
String key = "";
late Timer _timer;
int _start = 15;


  @override
  Widget build(BuildContext context) {

    var loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc!.mobileScanner),backgroundColor: Colors.redAccent.shade700,),
      body: MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) {
            if (barcode.rawValue == null) {
            }
            else {
              Prevalent.ProgressDialogue(context, loc!.logIn);
              startTimer();
              final String code = barcode.rawValue!;
              key = getKey(code);
              Map<String, dynamic> upload = new Map<String, dynamic>();
              upload = Prevalent.currentOnlineUser.toMap();
              final colRef = FirebaseFirestore.instance.collection("PCs");
              colRef.doc(code).update({
                "user":upload,
                "key":key,
                "phone":Prevalent.currentOnlineUser.phone
              }).then((value) =>
              {
                startlistening(code)
              });
            }
          }),
    );
  }
startlistening(code){
  var loc = AppLocalizations.of(context);
  FirebaseFirestore.instance.collection("PCs").doc(code).snapshots().listen(
          (event) {
        Map<String, dynamic> data2 = event.data() as Map<String, dynamic>;
        if(data2["Status"]){
          _timer.cancel();
          showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(loc!.successful),
                content: Text(
                    loc!.deviceLinkedSuccessfully),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async => {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                          (context) => Home()), (route) => false)
                    },
                    child: Text(loc!.ok),
                  ),

                ],
              ));
        }
      });
}

String getKey(String cod){

  String toBeInt = cod.substring(0,3) + cod.substring(50,52) + cod.substring(100,103) + cod.substring(150,154) + cod.substring(180,182);
  int num = int.parse(toBeInt);
  num = ((num/15) * 12).round();
  return num.toString();
}
  void startTimer() {
    var loc = AppLocalizations.of(context);
  const oneSec = const Duration(seconds: 1);
  _timer = new Timer.periodic(
    oneSec,
        (Timer timer) {
      if (_start == 0) {
        _timer.cancel();
        showDialog<String>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(loc!.failedLoggingin),
              content: Text(
                  loc!.checkyourinternetconnection),
              actions: <Widget>[
                TextButton(
                  onPressed: () async => {
                  _timer.cancel(),
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                  (context) => Home()), (route) => false)
                  },
                  child: Text(loc!.ok),
                ),

              ],
            ));
      } else {
        _start--;
      }
    },
  );
}

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }
}



