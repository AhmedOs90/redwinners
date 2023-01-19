import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'otp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class EntrPhone extends StatefulWidget {
  String src;

  EntrPhone(this.src);

  @override
  State<EntrPhone> createState() => _EntrPhoneState(src);
}

class _EntrPhoneState extends State<EntrPhone> {
  late String number;
  String Src;
  bool valid = false;

  _EntrPhoneState(this.Src);

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);

    return Scaffold(

        body:
        Container( //BackGround
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //       Colors.redAccent.shade200,
              //       Colors.redAccent.shade400,
              //       Colors.redAccent.shade700,
              //       Colors.redAccent.shade400,
              //     ],
              //     stops: [.1, .4, .7, .9]
              // )
          ),
          child: ListView(
              children: [ Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    textDirection: TextDirection.ltr,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Image(
                            width: 300,
                            height: 150,
                            image: AssetImage('assets/redwinners.png')),
                      ), //logo
                      Card(
                        elevation: 10,
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.ltr,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              // UserName

                              Container(
                                margin: EdgeInsets.only(bottom: 40,left: 20, right: 20),
                                alignment: Alignment.centerLeft,
                                height: 70,
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
                                child:  Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: InternationalPhoneNumberInput(
                                    countries: ['EG','AE','KW', 'SA', 'QA','OM','LB','JO'],
                                    maxLength: 13,
                                    autoValidateMode: AutovalidateMode.onUserInteraction,
                                    onInputValidated: (value){
                                      valid = value;
                                    },

                                    onInputChanged:
                                        (PhoneNumber value) {
                                      number = value.toString();
                                    },
                                    // onInputValidated: (value){
                                    //   numberBool = value;
                                    // },
                                  ),
                                ),
                                // TextField(
                                //   keyboardType: TextInputType.number,
                                //   decoration: new InputDecoration(
                                //       hintText: 'Phone Number (Enter Valid Phone Number)',
                                //       border: InputBorder.none,
                                //       prefixIcon: Icon(
                                //         Icons.phone,
                                //         color: Colors.redAccent,
                                //       )
                                //   ),
                                //   onChanged: (newValue) {
                                //     number = newValue;
                                //   },
                                // ),
                              ), //phone number
//

                            ],
                          ),
                        ),
                      ),
                      Container(margin: EdgeInsets.only(
                          left: 20, top: 20, right: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              if(valid) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder:
                                        (context) => OTP(number, Src)));
                              }
                              else{
                                showDialog<String>(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: Text(loc!.enterValidNumber),
                                          content: Text(loc!.youneedtoenteravalidphonenumber),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                              {
                                                Navigator.pop(context),
                                              },
                                              child: Text(loc!.back),
                                            ),
                                          ],
                                        )
                                );
                              }
                              //CheckAndProceed(company);
                            },
                            style: mainTheme,
                            child: Text(loc!.verifyPhoneNumber),)),
                      Container(margin: EdgeInsets.all(20),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: mainTheme,
                            child: Text(loc!.backtoLogIn),)),
                    ]
                ),
              ),
              ]
          ),

        )


    );
  }
}
