
import 'package:redwinners/Model/Accounts.dart';
import 'package:redwinners/Model/values.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class CreatAccount extends StatefulWidget {
  @override
  _CreatAccountState createState() => _CreatAccountState();
}

class _CreatAccountState extends State<CreatAccount> {
  String usersCount = "20";
  late String accountName = "";
  var msgController = TextEditingController();
  String Expire = "1 week";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[


            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10, right: 10),
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
                decoration: new InputDecoration(
                    hintText: 'Account Name',
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.account_box,
                      color: Colors.redAccent,
                    )
                ),

                controller: msgController,
                onChanged: (value) {
                  accountName = value;
                },
              ),
            ), // UserName
            Text("Users Count"),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 5),
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
              child:
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        hintText: 'Number of Accounts',
                        border: InputBorder.none,

                        prefixIcon: Icon(
                          Icons.account_box,
                          color: Colors.redAccent,
                        )
                    ),


                    onChanged: (value) {
                      usersCount = value;
                    },
                  ),
              ),
            ),
            Text("Expire"),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 5),
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
              child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:ExpireSpinner(),
              ),
            ),
            Container(margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    CheckAndProceed(accountName, usersCount);
                  },
                  style: mainTheme,
                  child: Text("Create"),)),
          ],
        ),
      ),

    );
  }

  ExpireSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Any count"),
        value: Expire,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            Expire = newValue!;
          });
        },
        items: values.expire.map<DropdownMenuItem<String>>((
            String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }

  CheckAndProceed(String AccountName, String UserCount) {
    if (AccountName == null) {
      return null;
    }
    else {
      CollectionReference users = FirebaseFirestore.instance.collection(
          'users');
      var exp;
      switch (Expire)
      {
        case "1 week":
          exp = DateTime.now().add(Duration(days: 8));
          break;
        case "1 month":
          exp = DateTime.now().add(Duration(days: 31));
          break;
        case "3 months":
          exp = DateTime.now().add(Duration(days: 92));
          break;
        case "6 months":
          exp = DateTime.now().add(Duration(days: 182));
          break;
        case "12 months":
          exp = DateTime.now().add(Duration(days: 365));
          break;
      }
      users.doc(AccountName).get().then((doc) {

        if(!doc.exists){
          String cCode = Prevalent.getRandomString(9);
          int userCount = int.parse(UserCount);
          Account account = new Account(userCount, AccountName);
          account.creating();
          Map<String, dynamic> map2 = new Map<String, dynamic>();
          for (int i = 0; i < account.count; i++) {
            if (i == 0) {
              map2[i.toString()] = {
                "account": accountName,
                "userName": account.admin,
                "password": account.adminPassword,
                "created": DateTime.now(),
                "expire" : exp,
                "index": i.toString(),
                "subscriberPeriod": "",
                "subscriberId": "",
                "companyCode": cCode,
                "database" : "trial",
              };
            }
            else {
              map2[i.toString()] = {
                "account": accountName,
                "userName": account.Users[i].userName,
                "password": account.Users[i].password,
                "created": DateTime.now(),
                "expire" : exp,
                "index": i.toString(),
                "subscriberPeriod": "",
                "subscriberId": "",
                "companyCode": cCode,
                "database" : "trial",
              };
            }
          }
          Map<String, dynamic> map = new Map<String, dynamic>();
          map = {
            "accountName": account.accountName,
            "admin": account.admin,
            "adminPassword": account.adminPassword,
            "count": userCount,
            "users": map2,
            "status" : true
          };


          users.doc(account.accountName).set(map).then((value) =>
          {
            showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Account created'),
                    actions: <Widget>[

                      TextButton(
                        onPressed: () =>
                        {
                          Navigator.pop(context),
                          Navigator.pop(context)
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            ),
          }

          );
        }

        else {
          showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Account exist'),
                    content: Text("Account Already Exist, please Try Another name"),
                    actions: <Widget>[

                      TextButton(
                        onPressed: () =>
                        {
                          Navigator.pop(context),
                        },
                        child: const Text('Back'),
                      ),
                    ],
                  )
          );
        }
      });
    }
  }
}