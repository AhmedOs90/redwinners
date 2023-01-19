
import 'package:redwinners/UI/StuffPannel.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'EditUser.dart';
import 'PhoneNumber.dart';
import 'home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);
  return Scaffold(
    appBar: AppBar(
      leading: InkWell(
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: Icon(Icons.arrow_back_ios,size: 20,),
        ),
        onTap: (){
          Navigator.of(context).maybePop();
        },
      ),
      backgroundColor: Colors.redAccent.shade700,
      title: Text(loc!.settings),
    ),
    body: ListView(
      children: [
        Image(
            width: 200,
            height: 200,
            image: AssetImage('assets/redwinners.png')),//logo
        Column(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.ltr,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              top: 20, left: 10, right: 10),
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
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              children: [
                Icon(Icons.supervisor_account,
                  color: Colors.redAccent,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    Prevalent.currentOnlineUser.accountName,

                  ),
                ),
              ],
            ),
          ),
        ), // Company
        Container(
          margin: EdgeInsets.only(
              top: 5, left: 10, right: 10),
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
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              children: [
                Icon(Icons.account_box,
                  color: Colors.redAccent,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    Prevalent.currentOnlineUser.userName,

                  ),
                ),
              ],
            ),
          ),
        ), // userName
        Container(
          margin: EdgeInsets.only(
               left: 8, right: 8),
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: InkWell(
            child: Card(
              child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left:8.0, right: 8.0),
                        child: Text(loc!.changePassword)
                      ),
                  ]
              ),

            ),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditUser(Prevalent.currentOnlineUser.index)));
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: 8, right: 8),
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: InkWell(
            child: Card(
              child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left:8.0, right: 8.0),
                        child: Text(loc!.cancelSubscription)
                    ),

                  ]
              ),

            ),
            onTap: (){
              openPlayStoreAccount();
            },
          ),
        ),
        Container(
    margin: EdgeInsets.only(
    left: 8, right: 8, bottom: 20),
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: InkWell(
            child: Card(
              child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left:8.0, right: 8.0),
                        child: Text(loc!.privacyPolicy)
                    ),

                  ]
              ),

            ),
            onTap: (){
              openPrivacyPolicy();
            },
          ),
        ),
       
      ],
    )
      ],
    ),

  );
  }
   openPrivacyPolicy(){
     var loc = AppLocalizations.of(context);
     try {
       final link = "https://sites.google.com/view/redwinnerseg/privacy-poilcy";
       launchUrl(Uri.parse(link));
     } catch (e) {
       Prevalent.popMessage(loc!.error, loc!.cantOpenBrowser, context, loc!.back);
     }
   }
   openPlayStoreAccount() {
     var loc = AppLocalizations.of(context);
     if (Prevalent.currentOnlineUser.companyCode == "056741230") {
       if(Prevalent.currentOnlineUser.subscriberId != "") {
         try {
           final link = "https://play.google.com/store/account/subscriptions";
           launchUrl(Uri.parse(link));
         } catch (e) {
           Prevalent.popMessage(loc!.error, loc!.cantOpenBrowser, context, loc!.back);
         }

       }
       else {
         Prevalent.popMessage(loc!.error, loc!.youareonyoufreetrial, context, loc!.back);
       }
     }
     else
       {
         Prevalent.popMessage(loc!.error, loc!.youhaveacompanyaccount, context, loc!.back);
       }
   }


}

