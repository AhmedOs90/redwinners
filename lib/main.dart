import 'package:redwinners/Model/Requests.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'UI/SharedProjectView.dart';
import 'engines/l10/L10n.dart';
import 'model/values.dart';
import 'UI/AdminPanel.dart';
import 'UI/ErrorServerPage.dart';
import 'UI/Loading.dart';
import 'UI/LogIn.dart';
import 'UI/Projectlist.dart';
import 'UI/SpecificRequest.dart';
import 'UI/StuffPannel.dart';
import 'UI/UnitList.dart';
import 'UI/home.dart';
import 'UI/scheme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

}
class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  String Myurl, ProjID, Code;

  HomePage(this.Myurl, this.ProjID, this.Code, this.local);

  String local;
  @override
  State<HomePage> createState() => _HomePageState(this.Myurl, this.ProjID, this.Code, local);
}

class _HomePageState extends State<HomePage> {
  String _local;
  String myurl, projID, code;

  _HomePageState( this.myurl, this.projID, this.code, this._local);

  @override
  Widget build(BuildContext context)  {
    setState(() {
      Prevalent.local = _local;
    });
    return MaterialApp(        theme: Alltheme,
        debugShowCheckedModeBanner: false,
        supportedLocales: L10n.all,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: Locale(_local),
        home: intializing(myurl,projID,code));
  }
}


void main() async {
  String myurl = Uri.base.toString(); //get complete url
  String? projID = Uri.base.queryParameters["projID"]!= null?Uri.base.queryParameters["projID"]:"" ; //get parameter with attribute "para1"
  String? code = Uri.base.queryParameters["code"] != null?Uri.base.queryParameters["code"]:"" ;


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Prevalent.listenToUser();
  FlutterError.onError =
      FirebaseCrashlytics.instance.recordFlutterError;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  String x = "en";
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {

    if (message.notification != null) {
    }
  });
 try {
    x = await Prevalent.getLocal();
 }
 catch (e){
   x = "en";
 }
  runApp(HomePage(myurl, projID!, code!,x));

}

class intializing extends StatefulWidget {
  String Myurl, ProjID, Code;

  intializing(this.Myurl, this.ProjID, this.Code);

  @override
  _intializingState createState() => _intializingState(this.Myurl, this.ProjID, this.Code);

}

class _intializingState extends State<intializing> {
  String myurl, projID, code;


  _intializingState(this.myurl, this.projID,
      this.code); //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context)  {


    if(projID == "") {
      return FutureBuilder(
        // Initialize FlutterFire:
          //Prevalent.uploadValues()
          future: Prevalent.getValues(),
          builder: (context, snapshot) {
            // Check for errors

            if (snapshot.hasError) {

              return FutureBuilder(
                  future: Prevalent.retrieveUser(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return OpsError();
                    }
                    if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (Prevalent.currentOnlineUser.userName ==
                          "") {
                        return Login();
                      }
                      if (Prevalent.currentOnlineUser.userName !=
                          "") {
                        return Home();
                      }
                    }

                    return Loading();
                  });
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return FutureBuilder(
                  future: Prevalent.retrieveUser(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return OpsError();
                    }
                    if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (Prevalent.currentOnlineUser.userName ==
                          "") {
                        return Login();
                      }
                      if (Prevalent.currentOnlineUser.userName !=
                          "") {
                        return Home();
                      }
                    }

                    return Loading();
                  });
            }
            return Loading();
          });
    }
    else{

      return FutureBuilder(
        // Initialize FlutterFire:
          future: Prevalent.getValues(),
          builder: (context, snapshot) {
            // Check for errors

            if (snapshot.hasError) {
              //Prevalent.uploadValues();
              return FutureBuilder(
                  future: Prevalent.retrieveUser(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return OpsError();
                    }
                    if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (Prevalent.currentOnlineUser.userName ==
                          "") {
                        return Login();
                        //return countDown();
                      }
                      if (Prevalent.currentOnlineUser.userName !=
                          "") {
                        return Home();
                        //return countDown();
                      }
                    }

                    return Loading();
                  });
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return FutureBuilder(
                  future: Prevalent.getSharingCode(code),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return OpsError();
                    }
                    if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if(Prevalent.cond) {
                        return SharedProjectView(
                            "All Projects", projID, new Requests.empty());
                      }
                      else{
                        return OpsError();
                      }
                    }

                    return Loading();
                  });
            }
            return Loading();
          });
    }
        return Loading();
      }

}
