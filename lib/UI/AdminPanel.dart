import 'package:redwinners/Model/Accounts.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'EditUser.dart';
import 'ErrorServerPage.dart';
import 'Loading.dart';
import 'stylesAndThemes.dart';

class AdminPanel extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    var loc = AppLocalizations.of(context);
    DocumentReference Users = FirebaseFirestore.instance.collection('users').doc(Prevalent.currentOnlineUser.accountName);
    final Stream<DocumentSnapshot> _projectsStream = Users.snapshots();
//
    return Scaffold(
        body: Column(
          children: [

            appHeadWithBack(loc!.users,Icons.supervisor_account, false, context),
            Expanded(
              child: ListofUsers(_projectsStream),
            )

          ],
        ));
  }
  Widget ListofUsers(Stream<DocumentSnapshot<Object?>> projectsStream)
  {
    return StreamBuilder<DocumentSnapshot>(
        stream: projectsStream,
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return OpsError();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
//                Center(child: Text("Loading"));
          }

            List<AvUser> usersList = [];
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            Map<String, dynamic> users = data["users"];
            for (int i = 0; i < users.length; i++) {
              Map<String, dynamic> usermap = users[i.toString()];
              AvUser user = new AvUser.a();
              user.fromMap(usermap);
              usersList.add(user);
            }
            return Container(
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: usersList.length,
                      //itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return userCard(usersList[index], context);
                      }),
            );


        }
    );

  }

  Widget userCard(AvUser user, BuildContext context) {
    var loc = AppLocalizations.of(context);
    return Container(
        width: MediaQuery.of(context).size.width,
         height: 60,
        child: Card(
           child: Row(
              children: [
                      Expanded (
                        child: Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                   loc!.userName,
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                   user.userName,
                                   textAlign: TextAlign.start,
                                   ),
                                ],
                              ),

                              Row(
                                children: [
                                  Text(
                                    loc!.password,
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    user.password,
                                    textAlign: TextAlign.start,

                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                user.index == "0"?Container():InkWell(
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Colors.redAccent.withOpacity(.5),borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(loc!.reset),
                      ),
                    ),
                  ),
                  onTap: (){ Prevalent.ProgressDialogue(context, loc!.resetting);
                    Reset(user.index, context);},),
                      InkWell(
                          child: Container(

                            decoration:
                            BoxDecoration(color: Colors.redAccent.withOpacity(.5),borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(loc!.edit),
                              ),
                            ),
                            margin: EdgeInsets.all(5),
                          ),
                        onTap: (){ Navigator.push(context, MaterialPageRoute(builder:
                            (context) =>EditUser(user.index)));},),

                ]
        ),

          ),
    );
  }

  Reset(String index, BuildContext context) {
    var loc = AppLocalizations.of(context);
    Map<String, dynamic> map2 = new Map<String, dynamic>();
    CollectionReference Users = FirebaseFirestore.instance.collection(Prevalent.currentOnlineUser.database);
    map2 = {

      "account": Prevalent.currentOnlineUser.accountName,
      "userName": "User"+index,
      "password": Prevalent.getRandompass(4),
      "index": index,
      "created": Prevalent.currentOnlineUser.created,
      "expire" : Prevalent.currentOnlineUser.expire,
      "phone" :"",
      "rand" : "",
      "subscriberPeriod": Prevalent.currentOnlineUser.subscriberPeriod,
      "subscriberId": "",
      "companyCode": Prevalent.currentOnlineUser.companyCode,
      "database" : Prevalent.currentOnlineUser.database,
    };


    Users.doc(Prevalent.currentOnlineUser.accountName).update({'users.'+index : map2})
        .then((value) => {
      showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: Text(loc!.successful),
                content: Text(loc!.userReset),
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
              )
      )}
    );
  }
}






