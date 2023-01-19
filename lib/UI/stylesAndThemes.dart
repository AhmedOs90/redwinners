import 'package:redwinners/engines/prevelant.dart';
import 'package:redwinners/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AdminPanel.dart';
import 'EditUser.dart';
import 'Settings.dart';
import 'QrScanner.dart';

final ButtonStyle mainTheme = ElevatedButton.styleFrom(
    minimumSize: Size(double.infinity, 50),
    primary: Colors.redAccent.shade700,
);
final ButtonStyle notActivatedTheme = ElevatedButton.styleFrom(
  minimumSize: Size(double.infinity, 50),
  primary: Colors.grey,


);
final ThemeData Alltheme = new ThemeData(
    primaryColor: Colors.redAccent.shade700,
    textTheme: TextTheme(
    bodyText1: TextStyle(
        fontSize: 20,
        color: Colors.redAccent.shade400
    ),
    bodyText2: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade800

    ),

  )
);
final ThemeData tabTheme = new ThemeData(
    primaryColor: Colors.redAccent.shade700,
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 25,
            color: Colors.redAccent.shade700
        ),
        bodyText2: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade800

        )
    )
);

appHead(String title, IconData icon, bool popmenu, BuildContext context)
{
  return Container(
    height: 75,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.redAccent.shade700,
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
              )
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top:8.0, bottom: 8, left: 12, right: 12),
              child: Row( mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title,style: TextStyle(color: Colors.white, fontSize: 14),),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Icon(icon, color: Colors.white,size: 15,),
                  ),
                ],
              ),
            ),decoration: BoxDecoration(
            color: Colors.redAccent.shade700.withOpacity(0.5),
            borderRadius: new BorderRadius.circular(30.0),
          ),
            margin: EdgeInsets.only(top: 10),),
          Container(width: 50,height: 50,
            child: popmenu ? (Prevalent.admin ? PopupMenuButton<String>(
              icon: Icon(Icons.more_horiz_outlined,color: Colors.white,),
              onSelected: (value){handleClick(value, context);},
              itemBuilder: (BuildContext context) {
                return {
                AppLocalizations.of(context)!.settings,
                AppLocalizations.of(context)!.logout,
                  AppLocalizations.of(context)!.language,
                AppLocalizations.of(context)!.manageUsers,
                  AppLocalizations.of(context)!.linkDevice
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
                : PopupMenuButton<String>(

              icon: Icon(Icons.more_horiz_outlined,color: Colors.white,),
              onSelected: (value){handleClick(value, context);},
              itemBuilder: (BuildContext context) {
                return {AppLocalizations.of(context)!.settings,
                  AppLocalizations.of(context)!.logout,
                  AppLocalizations.of(context)!.language,
                  AppLocalizations.of(context)!.linkDevice,
                }.map((
                    String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )) : Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                )
            ),

          ),


          // Container(
          //   height: double.infinity,
          //   width: double.infinity,
          //   child: Stack(
          //       alignment: Alignment.bottomCenter,
          //       children:[
          //
          //       ]
          //   ),
          //
          //
          // )
        ],
      ),
    ),
  );
}

appHeadWithBack(String title, IconData icon, bool popmenu, BuildContext context)
{
  return Container(
    height: 75,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.redAccent.shade700,
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          InkWell(
            child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(Icons.arrow_back_ios, color: Colors.white,size: 20,),
                )
            ),
            onTap: (){
              Navigator.of(context).maybePop();
            },
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top:8.0, bottom: 8, left: 12, right: 12),
              child: Row( mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title,style: TextStyle(color: Colors.white, fontSize: 14),),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Icon(icon, color: Colors.white,size: 15,),
                  ),
                ],
              ),
            ),decoration: BoxDecoration(
            color: Colors.redAccent.shade700.withOpacity(0.5),
            borderRadius: new BorderRadius.circular(30.0),
          ),
            margin: EdgeInsets.only(top: 10),),
          Container(width: 50,height: 50,
            child: popmenu ? (Prevalent.admin ? PopupMenuButton<String>(
              icon: Icon(Icons.more_horiz_outlined,color: Colors.white,),
              onSelected: (value){handleClick(value, context);},
              itemBuilder: (BuildContext context) {
                return {
                AppLocalizations.of(context)!.settings,
                AppLocalizations.of(context)!.logout,
                  AppLocalizations.of(context)!.language,
                AppLocalizations.of(context)!.manageUsers,
                  AppLocalizations.of(context)!.linkDevice,
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
                : PopupMenuButton<String>(

              icon: Icon(Icons.more_horiz_outlined,color: Colors.white,),
              onSelected: (value){handleClick(value, context);},
              itemBuilder: (BuildContext context) {
                return {AppLocalizations.of(context)!.settings,
                  AppLocalizations.of(context)!.logout,
                  AppLocalizations.of(context)!.language,
                  AppLocalizations.of(context)!.linkDevice,
                }.map((
                    String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )) : Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                )
            ),

          ),


          // Container(
          //   height: double.infinity,
          //   width: double.infinity,
          //   child: Stack(
          //       alignment: Alignment.bottomCenter,
          //       children:[
          //
          //       ]
          //   ),
          //
          //
          // )
        ],
      ),
    ),
  );
}


Future<void> handleClick(String value, BuildContext context) async {
  switch (value) {
    case 'Settings':
      Navigator.push(context, MaterialPageRoute(builder:
          (context) =>Settings()));
      break;
    case 'اعدادات':
      Navigator.push(context, MaterialPageRoute(builder:
          (context) =>Settings()));
      break;
    case 'Logout':
      Prevalent.logOut(context);
      break;
    case 'تسجيل الخروج':
      Prevalent.logOut(context);
      break;
    case 'العربية':
      SharedPreferences currentLocal = await SharedPreferences.getInstance();

      Prevalent.local = 'ar';
      await currentLocal.setString('local', 'ar');
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomePage("","","",'ar')), (route) => false);
      break;
    case 'English':
      SharedPreferences currentLocal = await SharedPreferences.getInstance();
      Prevalent.local = 'en';
      await currentLocal.setString('local', 'en');
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomePage("","","",'en')), (route) => false);
      break;
    case 'Manage Users':
      Navigator.push(context, MaterialPageRoute(builder:
          (context) =>AdminPanel()));
      break;
    case 'ادارة الحسابات':
      Navigator.push(context, MaterialPageRoute(builder:
          (context) =>AdminPanel()));
      break;
    case "Link Device":
      Navigator.push(context, MaterialPageRoute(builder:
      (context) =>QrCode()));
      break;
    case "ربط جهاز":
      Navigator.push(context, MaterialPageRoute(builder:
          (context) =>QrCode()));
      break;
  }
}