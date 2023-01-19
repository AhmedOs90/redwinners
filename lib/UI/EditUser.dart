import 'package:redwinners/Model/Accounts.dart';
import 'package:redwinners/UI/Loading.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'ErrorServerPage.dart';
import 'home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditUser extends StatelessWidget {
  String oldUserName = "";
  String newUserName = "";
  String newPassword = "";
  String inputOldPassword = "";
  String userOldPassword = "";
  String repeatPassword = "";
  String userAdmin= "";
  List<AvUser> userList = [];
  late String Index;
  Account account = new Account.a();
  EditUser(this.Index);

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(Prevalent.currentOnlineUser.accountName).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return OpsError();
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return OpsError();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            Map<String, dynamic> users = data["users"];
            Map<String, dynamic> usermap = users[Index];
            account.fromMap(data);
            userAdmin = account.admin;
            for (int i = 0; i < account.count; i++)
              {
                AvUser user = new AvUser.a();
                Map<String, dynamic> usermap = users[i.toString()];
                user.fromMap(usermap);
                userList.add(user);
              }
            account.Users = userList;
            AvUser user = new AvUser.a();
            user.fromMap(usermap);
            oldUserName = user.userName;
            userOldPassword = user.password;
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
                title: Text(loc!.userDetails),
              ),
              body: ListView(
                children: [
                  EditPassWord(user, context),

                ],
              ),
            );
          }
          return Loading();
      });
  }

  void Change(BuildContext context) {
    var loc = AppLocalizations.of(context);
    //Check NewPasswor Rules
    if(Prevalent.admin)
      {

        if (newUserName.length < 5)
        {
          Navigator.pop(context);
          showDialog<String>(
              barrierDismissible: false,
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: Text(loc!.usernameTooShort),
                  content: Text(loc!.makeUserChar
                      ),
                  actions: <Widget>[

                    TextButton(
                      onPressed: () =>
                      {
                        Navigator.pop(context)

                      },
                      child: Text(loc!.ok),
                    ),
                  ],
                ));
          return;
        }
        if(newPassword.length < 5)
        {
          Navigator.pop(context);
          showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: Text(loc!.newPassTooShort),
                    content: Text(loc!.makSureNewPassIs5),
                    actions: <Widget>[

                      TextButton(
                        onPressed: () =>
                        {
                          Navigator.pop(context)

                        },
                        child: Text(loc!.ok),
                      ),
                    ],
                  ));
          return;
        }
        if(newUserName != oldUserName) {
          for (int i = 0; i < account.count; i++) {
            if (newUserName == account.Users[i].userName) {
              Navigator.pop(context);
              showDialog<String>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        title: Text(loc!.userAlreadyExist),
                        content: Text(loc!.someoneinyouraccounthasthsameusername),
                        actions: <Widget>[

                          TextButton(
                            onPressed: () =>
                            {
                              Navigator.pop(context)
                            },
                            child: Text(loc!.ok),
                          ),
                        ],
                      ));
              return;
            }
          }
        }
      }
    else
      {
        newUserName = oldUserName;
        if(repeatPassword == "" || newPassword == "" || inputOldPassword == "")
        {
          Navigator.pop(context);
          showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: Text(loc!.emptyField),
                    content: Text(loc!.entrAllFields),
                    actions: <Widget>[

                      TextButton(
                        onPressed: () =>
                        {
                          Navigator.pop(context)

                        },
                        child: Text(loc!.ok),
                      ),
                    ],
                  ));
          return;
        }
        if(inputOldPassword != userOldPassword)
          {
            Navigator.pop(context);
            showDialog<String>(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: Text(loc!.curentPassIncor),
                      content: Text(loc!.entrPassCore),
                      actions: <Widget>[

                        TextButton(
                          onPressed: () =>
                          {
                            Navigator.pop(context)
                          },
                          child: Text(loc!.ok),
                        ),
                      ],
                    ));
            return;
          }
        if(newPassword == userOldPassword)
        {
          Navigator.pop(context);
          showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: Text(loc!.notChangedPass),
                    content: Text(loc!.youNotChangedPass),
                    actions: <Widget>[

                      TextButton(
                        onPressed: () =>
                        {
                          Navigator.pop(context)

                        },
                        child: Text(loc!.ok),
                      ),
                    ],
                  ));
          return;
        }

        if(newPassword.length < 5)
        {
          Navigator.pop(context);
          showDialog<String>(
              barrierDismissible: false,
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: Text(loc!.newPassTooShort),
                  content: Text(loc!.makSureNewPassIs5),
                  actions: <Widget>[

                    TextButton(
                      onPressed: () =>
                      {
                        Navigator.pop(context)
                      },
                      child: Text(loc!.ok),
                    ),
                  ],
                ));
          return;
        }
        if(newPassword != repeatPassword)
        {
          Navigator.pop(context);
          showDialog<String>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: Text(loc!.passNotMatch),
                  content: Text(loc!.makeSureNewPassTwice),
                  actions: <Widget>[

                    TextButton(
                      onPressed: () =>
                      {
                        Navigator.pop(context)

                      },
                      child: Text(loc!.ok),
                    ),
                  ],
                ));
          return;
        }
      }


    Map<String, dynamic> map2 = new Map<String, dynamic>();
    var random = Prevalent.getRandomString(10);
    CollectionReference Users = FirebaseFirestore.instance.collection(Prevalent.currentOnlineUser.database);
    String phone ="";
    if(oldUserName == Prevalent.currentOnlineUser.userName)
    {
      phone = Prevalent.currentOnlineUser.phone;
    }
    map2 = {

      "account": Prevalent.currentOnlineUser.accountName,
      "userName": newUserName,
      "password": newPassword,
      "index": Index,
      "created": Prevalent.currentOnlineUser.created,
      "expire" : Prevalent.currentOnlineUser.expire,
      "phone" : phone,
      "rand" : random,
      "subscriberPeriod": Prevalent.currentOnlineUser.subscriberPeriod,
      "subscriberId": Prevalent.currentOnlineUser.subscriberId,
      "companyCode": Prevalent.currentOnlineUser.companyCode,
      "database" : Prevalent.currentOnlineUser.database,
    };


    Users.doc(Prevalent.currentOnlineUser.accountName).update({'users.'+Index : map2})
    .then((value) => {
      if(oldUserName == Prevalent.currentOnlineUser.userName)
        {
          Prevalent.saveCurrentOnlineUser(Prevalent.currentOnlineUser.accountName, newUserName, newPassword,
              Index, random, Prevalent.currentOnlineUser.created, Prevalent.currentOnlineUser.expire, phone,
              Prevalent.currentOnlineUser.subscriberId,
              Prevalent.currentOnlineUser.subscriberPeriod,
              Prevalent.currentOnlineUser.companyCode,
              Prevalent.currentOnlineUser.database)
        },
      Navigator.pop(context),
      showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: Text(loc!.successful),
              content: Text(loc!.changesSaved),
              actions: <Widget>[

                TextButton(
                  onPressed: () =>
                  {
                  Navigator.pop(context)
                  },
                  child: Text(loc!.ok),
                ),
              ],
            )
    )}
    );

  }
  EditPassWord(AvUser user, BuildContext context) {
    var loc = AppLocalizations.of(context);
    if(Prevalent.admin)
      {
        newUserName = user.userName;
        newPassword = user.password;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.ltr,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: 20, left: 20, bottom: 20, right: 20),
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
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.supervisor_account,
                      color: Colors.redAccent,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
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
                  left: 20, bottom: 20, right: 20),
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
              child: TextFormField(
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.sentences,
                initialValue: user.userName,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Colors.redAccent,
                    )
                ),
                onChanged: (newValue) {
                  newUserName = newValue;
                },
              ),
            ), // UserName
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
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                initialValue: user.password,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.redAccent,
                    )
                ),
                onChanged: (newValue) {
                  newPassword = newValue;
                },
              ),
            ), //Password
//
            Container(
                margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Change(context);
                  },
                  style: mainTheme,
                  child: Text(loc!.saveChanges),)),
          ],
        );
      }
    else
      {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.ltr,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: 20, left: 20, bottom: 20, right: 20),
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
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.supervisor_account,
                      color: Colors.redAccent,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
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
                  top: 20, left: 20, bottom: 10, right: 20),
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
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.account_box,
                      color: Colors.redAccent,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
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
                  left: 20, bottom: 20, right: 20),
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
                    hintText: loc!.oldPassword,
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.redAccent,
                    )
                ),
                onChanged: (newValue) {
                  inputOldPassword = newValue;
                },
              ),
            ), // OldPassword
            Container(
              margin: EdgeInsets.only(left: 20, right: 20,bottom: 10, top: 10),
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
                    hintText: loc!.newPassword,
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.redAccent,
                    )
                ),
                onChanged: (newValue) {
                  newPassword = newValue;
                },
              ),
            ), //New Password
//
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
                    hintText: loc!.repeatPassword,
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.redAccent,
                    )
                ),
                onChanged: (newValue) {
                  repeatPassword = newValue;
                },
              ),
            ), //Repeat Password
//
            Container(
                margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Prevalent.ProgressDialogue(context, loc!.savingchanges);
                    Change(context);
                  },
                  style: mainTheme,
                  child: Text(loc!.saveChanges),)),
          ],
        );
      }

  }
}


