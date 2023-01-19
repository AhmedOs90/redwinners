
import 'package:redwinners/Model/Requests.dart';
import 'package:redwinners/UI/Projectlist.dart';
import 'package:redwinners/UI/scheme.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'AceessِRequest.dart';
import 'EditUser.dart';
import 'NotificationService.dart';
import 'SpecificRequest.dart';
import 'browse.dart';
import 'creat Account.dart';

class StuffPanel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    tz.initializeTimeZones();
    WidgetsFlutterBinding.ensureInitialized();
    NotificationService().initNotification();
    final docRef = FirebaseFirestore.instance.collection("requests");
    docRef.snapshots().listen(

          (event) {
            for (var change in event.docChanges) {
              Map<String, dynamic> data = change.doc.data() as Map<String, dynamic>;
              switch (change.type) {
                case DocumentChangeType.added:
                  NotificationService().showNotification(
                      1, "New Request", "Name: "+ data["name"].toString() + "\n company: "+data["company"], 10);
                  break;
                case DocumentChangeType.modified:
                  NotificationService().showNotification(
                      1, "Request Edited", data["name"].toString() + "\n company: "+data["company"], 10);
                  break;

              }
            }


          });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent.shade700,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          actionsIconTheme: IconThemeData(color: Colors.grey.shade700),
          leading: PopupMenuButton<String>(
            icon: Icon(Icons.more_horiz_outlined),
            onSelected: (selected) => handleClick(selected, context),
            itemBuilder: (BuildContext context) {
              return {'Edit Username/Password', 'Logout', 'العربية'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
          title: Text(Prevalent.currentOnlineUser.userName,),

        ),
          body: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                textDirection: TextDirection.ltr,
                children: [
                  Image(
                      width: 300,
                      height: 300,
                      image: AssetImage('assets/logo.png')),
                  Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget> [

                      Container( margin: EdgeInsets.only(left: 20,bottom:20,right: 20),
                          child:ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context) =>CreatAccount()));
                            },
                            style:mainTheme,
                            child: Text("Create Account"),)),
                      Container( margin: EdgeInsets.only(left: 20,bottom: 20, right: 20),
                          child: ElevatedButton(
                              onPressed: (){
                                { Navigator.push(context, MaterialPageRoute(builder:
                                    (context) =>ProjectList("All Projects", "All Projects", new Requests.empty(), "Staff")));}
                              },
                              style: mainTheme,
                              child: Text("Edit Projects"))),
                      Container( margin: EdgeInsets.only(left: 20,bottom: 20, right: 20),
                          child: ElevatedButton(
                              onPressed: (){
                                { Navigator.push(context, MaterialPageRoute(builder:
                                    (context) =>ProjectList(Prevalent.currentOnlineUser.userName, Prevalent.currentOnlineUser.userName, new Requests.empty(), "Staff")));}
                              },
                              style: mainTheme,
                              child: Text("My Projects"))),
                      Container( margin: EdgeInsets.only(left: 20,bottom: 20, right: 20),
                          child: ElevatedButton(
                              onPressed: (){
                                getPass("Enter Password", context);
                              },
                              style: mainTheme,
                              child: Text("Requests"))),
                      Container( margin: EdgeInsets.only(left: 20,bottom: 20, right: 20),
                          child: ElevatedButton(
                              onPressed: (){
                                updateDelivery(context);
                              },
                              style: mainTheme,
                              child: Text("Update Delivery"))),
                    ],
                  ),
                ]
            ),
            ]
          )


    );


  }
  void getPass( String message, BuildContext context) {
    String Pass = "";
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text(message),
            actions: <Widget>[
              TextField(
                keyboardType: TextInputType.visiblePassword,
                onChanged: (newValue){
                  Pass = newValue;
                },
              ),
              TextButton(
                onPressed: () =>
                {
                  print(Pass),
                  print(Prevalent.adminUltPass),
                  if(Pass == Prevalent.adminUltPass)
                    {
                      Navigator.pop(context),
                      Navigator.push(context, MaterialPageRoute(builder:
                         (context) =>userRequest()))

                    }
                  else
                    {
                      Navigator.pop(context),
                      getPass("Wrong Password",context),
                    },

                },
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () =>
                {
                  Navigator.pop(context),
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }

  void handleClick(String value,BuildContext context ) {
    switch (value) {
      case 'Edit Username/Password':
        Navigator.push(context, MaterialPageRoute(builder:
            (context) =>EditUser(Prevalent.currentOnlineUser.index)));
        break;
      case 'Logout':
        Prevalent.logOut(context);
        break;
      case 'العربية':
        break;

    }
  }

  void updateDelivery(BuildContext context)async {

    CollectionReference Units = FirebaseFirestore.instance.collection(
        "testUnits");
    await Units.where("delivery", isEqualTo: "1/1/2022").get()
        .then((value) async =>
    {
      for(var doc in value.docs)
        {
        await doc.reference.update({

        'delivery': "1/1/2023",
        })
        }

    }).then((value) => showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text('Database updated'),
            actions: <Widget>[

              TextButton(
                onPressed: () =>
                {
                  Navigator.pop(context),
                },
                child: const Text('OK'),
              ),
            ],
          ),
    ));

  }



}
