//convert from fireStore to model

import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:redwinners/Model/Accounts.dart';
import 'package:redwinners/Model/Requests.dart';
import 'package:redwinners/Model/values.dart';
import 'package:redwinners/UI/LogIn.dart';
import 'package:redwinners/UI/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../UI/PhoneNumber.dart';
import '../UI/StuffPannel.dart';

class Prevalent {
  static var local = "en";
  static bool triallogin = false;
  static bool userlogin = false;
  static String database = "users";
  static bool usernamelogin = false;
  static bool passlogin = false;
  static bool statuslogin = false;
  static bool expirelogin = false;
  static bool conditionlogin = false;
  static bool phoneLogin = false;
  static bool phoneEmptyLogin = false;
  static bool currentUserlogin = false;
  static bool cond = false;
  static bool exist = false;
  static late DateTime expire;
  static late DateTime created;
  static var random;
  static AvUser currentOnlineUser = new AvUser.a();
  static var currentUser;
  static Requests request = new Requests.empty();
  static bool username = false;
  static bool pass = false;
  static bool random1 = false;
  static bool condition = false;
  static bool admin = false;
  static bool status = true;
  static bool expirebool = true;
  static bool phone = true;
  static String phoneregistered = "";
  static String adminUltPass = "";
  static AvUser avUser = AvUser.a();
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static const _numbers = 'abcdefghijklmnopqrstuvwxyz1234567890';
  static Random _rnd = Random();
  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  static String getRandompass(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _numbers.codeUnitAt(_rnd.nextInt(_numbers.length))));

  static listenToUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        currentUser = user;
      } else {
        currentUser = null;
      }
    });
  }

  static Future getValues() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Values2");
    DatabaseEvent event = await ref.once();

    //region Location
    values.locationEnglish = [];
    List<dynamic> data = event.snapshot.child("locationEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.locationEnglish.add(data[i]);
    }
    values.locationArabic = [];
    data = event.snapshot.child("locationArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.locationArabic.add(data[i]);
    }
    //endregion
    //region subLocationNewCapital
    values.subLocationNewCapitalEnglish = [];
    data = event.snapshot.child("subLocationNewCapitalEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subLocationNewCapitalEnglish.add(data[i]);
    }
    values.subLocationNewCapitalArabic = [];
    data = event.snapshot.child("subLocationNewCapitalArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subLocationNewCapitalArabic.add(data[i]);
    }
    //endregion
    //region subLocationNewCairo
    values.subLocationNewCairoEnglish = [];
    data = event.snapshot.child("subLocationNewCairoEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subLocationNewCairoEnglish.add(data[i]);
    }
    values.subLocationNewCairoArabic = [];
    data = event.snapshot.child("subLocationNewCairoArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subLocationNewCairoArabic.add(data[i]);
    }
    //endregion
    // region subLocationOctoberZayed
    values.subLocationOctoberZayedEnglish = [];
    data = event.snapshot.child("subLocationOctoberZayedEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subLocationOctoberZayedEnglish.add(data[i]);
    }
    values.subLocationOctoberZayedArabic = [];
    data = event.snapshot.child("subLocationOctoberZayedArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subLocationOctoberZayedArabic.add(data[i]);
    }
    //endregion
    //region subLocationNorthCoast
    values.subLocationNorthCoastEnglish = [];
    data = event.snapshot.child("subLocationNorthCoastEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subLocationNorthCoastEnglish.add(data[i]);
    }
    values.subLocationNorthCoastArabic = [];
    data = event.snapshot.child("subLocationNorthCoastArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subLocationNorthCoastArabic.add(data[i]);
    }
    //endregion
//region subLocationElSokhna
    values.subLocationElSokhnaEnglish = [];
    data = event.snapshot.child("subLocationElSokhnaEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subLocationElSokhnaEnglish.add(data[i]);
    }
    values.subLocationElSokhnaArabic = [];
    data = event.snapshot.child("subLocationElSokhnaArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subLocationElSokhnaArabic.add(data[i]);
    }
    //endregion
//region subLocationElShrouk
    values.subLocationElShroukEnglish = [];
    data = event.snapshot.child("subLocationElShroukEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subLocationElShroukEnglish.add(data[i]);
    }
    values.subLocationElShroukArabic = [];
    data = event.snapshot.child("subLocationElShroukArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subLocationElShroukArabic.add(data[i]);
    }
    //endregion
//region Location
    values.subLocationElMostakblEnglish = [];
    data = event.snapshot.child("subLocationElMostakblEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subLocationElMostakblEnglish.add(data[i]);
    }
    values.subLocationElMostakblArabic = [];
    data = event.snapshot.child("subLocationElMostakblArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subLocationElMostakblArabic.add(data[i]);
    }
    //endregion
//region Location
    values.typeEnglish = [];
    data = event.snapshot.child("typeEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.typeEnglish.add(data[i]);
    }
    values.typeArabic = [];
    data = event.snapshot.child("typeArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.typeArabic.add(data[i]);
    }
    //endregion
//region Location
    values.subTypeCommercialEnglish = [];
    data = event.snapshot.child("subTypeCommercialEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subTypeCommercialEnglish.add(data[i]);
    }
    values.subTypeCommercialArabic = [];
    data = event.snapshot.child("subTypeCommercialArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subTypeCommercialArabic.add(data[i]);
    }
    //endregion
//region Location
    values.subTypeAdminEnglish = [];
    data = event.snapshot.child("subTypeAdminEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subTypeAdminEnglish.add(data[i]);
    }
    values.subTypeAdminArabic = [];
    data = event.snapshot.child("subTypeAdminArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.subTypeAdminArabic.add(data[i]);
    }
    //endregion
//region Location
    values.yearsEnglish = [];
    data = event.snapshot.child("yearsEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.yearsEnglish.add(data[i]);
    }
    values.yearsArabic = [];
    data = event.snapshot.child("yearsArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.yearsArabic.add(data[i]);
    }
    //endregion
//region Location
    values.ppmEnglish = [];
    data = event.snapshot.child("ppmEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.ppmEnglish.add(data[i]);
    }
    values.ppmArabic = [];
    data = event.snapshot.child("ppmArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.ppmArabic.add(data[i]);
    }
    //endregion
//region Location
    values.roomsNoEnglish = [];
    data = event.snapshot.child("roomsNoEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.roomsNoEnglish.add(data[i]);
    }
    values.roomsNoArabic = [];
    data = event.snapshot.child("roomsNoArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.roomsNoArabic.add(data[i]);
    }
    //endregion
//region Location
    values.roomsVillaNoEnglish = [];
    data = event.snapshot.child("roomsVillaNoEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.roomsVillaNoEnglish.add(data[i]);
    }
    values.roomsVillaNoArabic = [];
    data = event.snapshot.child("roomsVillaNoArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.roomsVillaNoArabic.add(data[i]);
    }
    //endregion
//region Location
    values.roomsChaletNoEnglish = [];
    data = event.snapshot.child("roomsChaletNoEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.roomsChaletNoEnglish.add(data[i]);
    }
    values.roomsChaletNoArabic = [];
    data = event.snapshot.child("roomsChaletNoArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.roomsChaletNoArabic.add(data[i]);
    }
    //endregion
//region Location
    values.deliveredInEnglish = [];
    data = event.snapshot.child("deliveredInEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.deliveredInEnglish.add(data[i]);
    }
    values.deliveredInArabic = [];
    data = event.snapshot.child("deliveredInArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.deliveredInArabic.add(data[i]);
    }
    //endregion
//region Location
    values.finishEnglish = [];
    data = event.snapshot.child("finishEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.finishEnglish.add(data[i]);
    }
    values.finishArabic = [];
    data = event.snapshot.child("finishArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.finishArabic.add(data[i]);
    }
    //endregion
//region apartmentsPrice
    values.apartmentsPriceEnglish = [];
    data = event.snapshot.child("apartmentsPriceEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.apartmentsPriceEnglish.add(data[i]);
    }
    values.apartmentsPriceArabic = [];
    data = event.snapshot.child("apartmentsPriceArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.apartmentsPriceArabic.add(data[i]);
    }
    //endregion
//region villaPrice
    values.villaPriceEnglish = [];
    data = event.snapshot.child("villaPriceEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.villaPriceEnglish.add(data[i]);
    }
    values.villaPriceArabic = [];
    data = event.snapshot.child("villaPriceArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.villaPriceArabic.add(data[i]);
    }
    //endregion
//region villaBUA
    values.villaBUAEnglish = [];
    data = event.snapshot.child("villaBUAEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.villaBUAEnglish.add(data[i]);
    }
    values.villaBUAArabic = [];
    data = event.snapshot.child("villaBUAArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.villaBUAArabic.add(data[i]);
    }
    //endregion
//region pricePerMeterCom
    values.pricePerMeterComEnglish = [];
    data = event.snapshot.child("pricePerMeterComEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.pricePerMeterComEnglish.add(data[i]);
    }
    values.pricePerMeterComArabic = [];
    data = event.snapshot.child("pricePerMeterComArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.pricePerMeterComArabic.add(data[i]);
    }
    //endregion
//region floorCommercial
    values.floorCommercialEnglish = [];
    data = event.snapshot.child("floorCommercialEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.floorCommercialEnglish.add(data[i]);
    }
    values.floorCommercialArabic = [];
    data = event.snapshot.child("floorCommercialArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.floorCommercialArabic.add(data[i]);
    }
    //endregion
//region floorApartment
    values.floorApartmentEnglish = [];
    data = event.snapshot.child("floorApartmentEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.floorApartmentEnglish.add(data[i]);
    }
    values.floorApartmentArabic = [];
    data = event.snapshot.child("floorApartmentArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.floorApartmentArabic.add(data[i]);
    }
    //endregion
//region apartmentType
    values.apartmentTypeEnglish = [];
    data = event.snapshot.child("apartmentTypeEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.apartmentTypeEnglish.add(data[i]);
    }
    values.apartmentTypeArabic = [];
    data = event.snapshot.child("apartmentTypeArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.apartmentTypeArabic.add(data[i]);
    }
    //endregion
//region pricePerMeterAdmin
    values.pricePerMeterAdminEnglish = [];
    data = event.snapshot.child("pricePerMeterAdminEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.pricePerMeterAdminEnglish.add(data[i]);
    }
    values.pricePerMeterAdminArabic = [];
    data = event.snapshot.child("pricePerMeterAdminArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.pricePerMeterAdminArabic.add(data[i]);
    }
    //endregion
//region areaAdmin
    values.areaAdminEnglish = [];
    data = event.snapshot.child("areaAdminEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.areaAdminEnglish.add(data[i]);
    }
    values.areaAdminArabic = [];
    data = event.snapshot.child("areaAdminArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.areaAdminArabic.add(data[i]);
    }
    //endregion
//region areaCommercial
    values.areaCommercialEnglish = [];
    data = event.snapshot.child("areaCommercialEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.areaCommercialEnglish.add(data[i]);
    }
    values.areaCommercialArabic = [];
    data = event.snapshot.child("areaCommercialArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.areaCommercialArabic.add(data[i]);
    }
    //endregion
//region areaApartment
    values.areaApartmentEnglish = [];
    data = event.snapshot.child("areaApartmentEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.areaApartmentEnglish.add(data[i]);
    }
    values.areaApartmentArabic = [];
    data = event.snapshot.child("areaApartmentArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.areaApartmentArabic.add(data[i]);
    }
    //endregion
    //region areaChalet
    values.areaChaletEnglish = [];
    data = event.snapshot.child("areaChaletEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.areaChaletEnglish.add(data[i]);
    }
    values.areaChaletArabic = [];
    data = event.snapshot.child("areaChaletArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.areaChaletArabic.add(data[i]);
    }
    //endregion
    //region landArea
    values.landAreaEnglish = [];
    data = event.snapshot.child("landAreaEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.landAreaEnglish.add(data[i]);
    }
    values.landAreaArabic = [];
    data = event.snapshot.child("landAreaArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.landAreaArabic.add(data[i]);
    }
    //endregion
    //region serviceArea
    values.serviceAreaEnglish = [];
    data = event.snapshot.child("serviceAreaEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.serviceAreaEnglish.add(data[i]);
    }
    values.serviceAreaArabic = [];
    data = event.snapshot.child("serviceAreaArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.serviceAreaArabic.add(data[i]);
    }
    //endregion
    //region typeVilla
    values.typeVillaEnglish = [];
    data = event.snapshot.child("typeVillaEnglish").value as List;
    for (int i = 0; i < data.length; i++) {
      values.typeVillaEnglish.add(data[i]);
    }
    values.typeVillaArabic = [];
    data = event.snapshot.child("typeVillaArabic").value as List;
    for (int i = 0; i < data.length; i++) {
      values.typeVillaArabic.add(data[i]);
    }
    //endregion
    //region usersCount
    values.usersCountEnglish = [];
    data = event.snapshot.child("usersCount").value as List;
    for (int i = 0; i < data.length; i++) {
      values.usersCountEnglish.add(data[i]);
    }
    //endregion
  }

  static uploadValues() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Values2");

    for (int i = 0; i < values.allValues.length; i++) {
      Map<String, dynamic> map = new Map<String, dynamic>();
      for (int f = 0; f < values.allValues[i].length; f++) {
        map[f.toString()] = values.allValues[i][f];
      }
      {
        //await val.doc(values.allValuesNames[i]).set(map);
        ref.child(values.allValuesNames[i]).set(map);
      }
    }
  }


  //region New Login Protocol
  static Future<bool> checkIfAccountExist(passWord, company, userName, context) async {
    bool Exist = false;
    username = false;
    pass = false;
    database = "users";
    CollectionReference Users = FirebaseFirestore.instance.collection(database);
    await Users.doc(company).get().then((DocumentSnapshot doc) async {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        status = data["status"];
        if (data["admin"] == userName) {
          if (data["adminPassword"] == passWord) {
            Prevalent.admin = true;
          } else {
            Prevalent.admin = false;
          }
        }
        Map<String, dynamic> users = data["users"];
        Map<String, dynamic> user = new Map();
        for (int i = 0; i < users.length; i++) {
          user = users[i.toString()];

          if (user["userName"] == userName) {
            username = true;
            if (user["password"] == passWord) {
              pass = true;
              if(company == "Staff")
                {
                  Prevalent.adminUltPass = data["adminPassword"];
                }
              avUser.fromMap(user);
              break;
            }
          }
        }

      }
    });
    if(username && pass)
    {
      userlogin = true;
      triallogin = false;
      Exist = true;
    }
    else {
      username = false;
      pass = false;
      database = "trial";
      CollectionReference Trials =
      FirebaseFirestore.instance.collection(database);
      await Trials.doc(company).get().then((DocumentSnapshot doc) async {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          status = data["status"];
          if (data["admin"] == userName) {
            if (data["adminPassword"] == passWord) {
              Prevalent.admin = true;
            } else {
              Prevalent.admin = false;
            }
          }
          Map<String, dynamic> users = data["users"];
          Map<String, dynamic> user = new Map();
          for (int i = 0; i < users.length; i++) {
            user = users[i.toString()];
            if (user["userName"] == userName) {
              username = true;
              if (user["password"] == passWord) {
                pass = true;
                avUser.fromMap(user);
                print("User: " +avUser.phone);
                print("User: " +avUser.UID);
                print("User: " +avUser.database);
                print("User: " +avUser.companyCode);
                break;
              }
            }
          }

        }
      });
      if (username && pass) {
        triallogin = true;
        userlogin = false;
        Exist = true;
      }
      else {
        triallogin = false;
        userlogin = false;
        Exist = false;
      }
    }
    return Exist;
  }

  static Future<bool> checkIfCompanySubscriber() async {
    if(avUser.companyCode != "056741230" && avUser.companyCode != "")
     {
         return true;
     }
   return false;
  }

  static Future<bool> checkIfFreeTrial() async {
   if (avUser.expire.isAfter(DateTime.now()))
    {
     return true;
    }
     return false;

  }

  static Future<bool> checkIfCompanyExpired() async {
   if(status && await checkIfFreeTrial())
   {
    return true;
   }
   return false;
  }

  static bool missingField(passWord, company, userName) {
    if (passWord == "" || company == "" || userName == "") {
      return true;
    } else {
      return false;
    }
  }

  static bool checkRegistery(){
    if(currentUser != null)
      {
        return true;
      }
    else{
      return false;
    }
  }

  static bool checkPhone(){
    if (avUser.phone.isEmpty)
      {
        savePhone();
        return true;
      }
    else if (avUser.phone == currentUser.phoneNumber)
      {
        return true;
      }
    else{
      return false;
    }
  }

  static void registerNewPhone(context) {
    Prevalent.saveCurrentOnlineUser(
        avUser.accountName,
        avUser.userName,
        avUser.password,
        avUser.index,
        avUser.rand,
        avUser.created,
        avUser.expire,
        "",
        avUser.subscriberId,
        avUser.subscriberPeriod,
        avUser.companyCode,
        database);
    Navigator.pop(context);
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>
    EntrPhone("login")));
  }


  static void savePhone(){
    CollectionReference Users = FirebaseFirestore.instance.collection(database);
    Users.doc(avUser.accountName).update({
      'users.' + avUser.index+ '.phone':
      currentUser.phoneNumber
    });
  }

  static login(company, userName, passWord, _rememberMe, context) {

    CollectionReference Users = FirebaseFirestore.instance.collection(database);
    if (userlogin) {
      random = Prevalent.getRandomString(10);
      Users.doc(company).update({'users.' + avUser.index + '.rand': random});
      Users.doc(company).update({'users.' + avUser.index + '.database': database});

      Prevalent.saveCurrentOnlineUser(company, userName, passWord, avUser.index,
          random, avUser.created, avUser.expire, "+201020398525",avUser.subscriberId,
          avUser.subscriberPeriod,
          avUser.companyCode,database);
      if (_rememberMe) {
        Prevalent.Remember();
      }
      if (company == "Staff") {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => StuffPanel()),
            (route) => false);
      } else {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
      }
    }
    else if (triallogin) {
      random = Prevalent.getRandomString(10);
      Users.doc(company).update({'users.' + avUser.index + '.rand': random});
      Prevalent.saveCurrentOnlineUser(company, userName, passWord, avUser.index,
          random, avUser.created, avUser.expire, currentUser.phone,avUser.subscriberId,
          avUser.subscriberPeriod,
          avUser.companyCode,database);
      if (_rememberMe) {
        Prevalent.Remember();
      }
      if (company == "Staff") {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => StuffPanel()),
            (route) => false);
      } else {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
      }
    }
  }

  static logInProtocol(
      company, userName, passWord, context, _rememberMe) async {
    ProgressDialogue(context, "Logging In");
    Prevalent.admin= false;
    if (missingField(passWord, company, userName)) {
      Navigator.pop(context);
      popMessage(
          "Missing Field", "one of the fields is missing", context, "Back");
      return;
    }
    if (await checkIfAccountExist(passWord, company, userName, context)) {
      if (company == "Staff"||company =="Axa") {
        login(company, userName, passWord, true, context);
        return;
      }
      if (await checkIfCompanySubscriber()) {
          if (await checkIfCompanyExpired()) {


            if(await checkRegistery()) {
              if(await checkPhone()){
                login(company, userName, passWord, _rememberMe, context);
              }
              else{
                Navigator.pop(context);
                popWhatsappMessagr('Account Already registered', "this account is already registered to another phone number, "
                    "if you believe that this account belongs to you, please contact your admin for support"
                    ",or Send us message on whatsapp for support, or verify another phone number", context);
              }
            }
            else
            {
              registerNewPhone(context);
            }
          }
          else {
            Navigator.pop(context);
            popMessage("Problem Logging in", "We couldn't Log you in, either your account has been deactivated, or someone logged in with your credentials "
                "on Another Device, contact your admin", context, "back");
            //contact admin
          }
        }
      else if (await checkIfFreeTrial()) {


        if(await checkRegistery()) {
          if(await checkPhone()){
            login(company, userName, passWord, _rememberMe, context);
          }
          else{
            Navigator.pop(context);
            popWhatsappMessagr('Account Already registered', "this account is already registered to another phone number, "
                "if you believe that this account belongs to you, please contact your admin for support"
                ",or Send us message on whatsapp for support, or verify another phone number", context);
          }
        }
        else
        {
          registerNewPhone(context);
        }
          }
      else {
        if(await checkRegistery()) {
          if(await checkPhone()){
            Navigator.pop(context);
            Prevalent.saveCurrentOnlineUser(company,
                userName,
                passWord,
                avUser.index,
                "", avUser.created, avUser.expire,
                avUser.phone, avUser.subscriberId, avUser.subscriberPeriod, avUser.companyCode, database);
            subscriptionExpired("Subscription Expired", "You need to renew your Subscription", context, "ok");
            //SubscribeUI.fetchOffers(context);
          }
          else{
            Navigator.pop(context);
            popWhatsappMessagr('Account Already registered', "this account is already registered to another phone number, "
                "if you believe that this account belongs to you, please contact your admin for support"
                ",or Send us message on whatsapp for support, or verify another phone number", context);
          }
        }
        else
        {
          registerNewPhone(context);
        }
          }
        }
    else {
      //retry or create new Account.
      Navigator.pop(context);
      popMessage(
          "Account Doesn't Exist", "one of the fields is incorrect", context, "back");
    }
  }
  static checkInProtocol(context) async{
    bool trial = false;
    String passWord = Prevalent.currentOnlineUser.password;
    String company = Prevalent.currentOnlineUser.accountName;
    String userName = Prevalent.currentOnlineUser.userName;
    if (await checkIfAccountExist(passWord, company, userName, context)) {
      if (company == "Staff"||company =="Axa") {
        return;
      }
      if (await checkIfCompanySubscriber()) {
        if (await checkIfCompanyExpired()) {
          if(await checkRegistery()) {
            if(await checkPhone()){
              Prevalent.saveCurrentOnlineUser(company,
                  userName,
                  passWord,
                  avUser.index,
                  "", avUser.created, avUser.expire,
                  avUser.phone, avUser.subscriberId, avUser.subscriberPeriod, avUser.companyCode, database);
              trial = true;
            }
            else{
              Navigator.pop(context);
              popMessageLoggingOut(context);
            }
          }
          else
          {
            Navigator.pop(context);
            popMessageLoggingOut(context);
          }
        }
        else {
          Navigator.pop(context);
          popMessageLoggingOut(context);
          //contact admin
        }
      }
      else if (await checkIfFreeTrial()) {
        if(await checkRegistery()) {
          if(await checkPhone()){
            Prevalent.saveCurrentOnlineUser(company,
                userName,
                passWord,
                avUser.index,
                "", avUser.created, avUser.expire,
                avUser.phone, avUser.subscriberId, avUser.subscriberPeriod, avUser.companyCode, database);
            trial = true;
          }
          else{
            Navigator.pop(context);
            popMessageLoggingOut(context);
          }
        }
        else
        {
          Navigator.pop(context);
          popMessageLoggingOut(context);
        }
      }
      else {
        Navigator.pop(context);
        popMessageLoggingOut(context);
      }
    }
    else {
      //retry or create new Account.
      Navigator.pop(context);
      popMessageLoggingOut(context);
    }
  }
  //endregion

  //region Actions
  static saveCurrentOnlineUser(String company,String userName,String passWord,String index,
      String random,DateTime created,DateTime expire,String phoneNumber,String subscriberId,
      String subscriberPeriod, String companyCode , String Database) {
    Prevalent.currentOnlineUser.accountName = company;
    Prevalent.currentOnlineUser.userName = userName;
    Prevalent.currentOnlineUser.password = passWord;
    Prevalent.currentOnlineUser.index = index;
    Prevalent.currentOnlineUser.rand = random;
    Prevalent.currentOnlineUser.created = created;
    Prevalent.currentOnlineUser.expire = expire;
    Prevalent.currentOnlineUser.phone = phoneNumber;
    Prevalent.currentOnlineUser.subscriberId = subscriberId;
    Prevalent.currentOnlineUser.subscriberPeriod = subscriberPeriod;
    Prevalent.currentOnlineUser.companyCode = companyCode;
    Prevalent.currentOnlineUser.database = Database;
  }
  static updateUserOnDataBase()
  {
    Map<String, dynamic> data = Prevalent.currentOnlineUser.toMap();

    CollectionReference use = FirebaseFirestore.instance.collection(Prevalent.currentOnlineUser.database);
    use.doc(Prevalent.currentOnlineUser.accountName).update({'users.' + currentOnlineUser.index : data});
  }
  static getLocal() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences currentLocal = await SharedPreferences.getInstance();
    var Local = currentLocal.getString('local');
    if (Local!= null) {
      Prevalent.local = Local;
    }
    print("Local: " + Local.toString());
    return Local;
  }

  static Future<void> retrieveUser(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userName = prefs.getString('userName');
    var accountName = prefs.getString('accountName');
    var index = prefs.getString('index');
    var password = prefs.getString('password');
    var random = prefs.getString('random');
    bool? admin = prefs.getBool('admin');
    if (userName != null &&
        accountName != null &&
        index != null &&
        password != null &&
        random != null) {
      Prevalent.currentOnlineUser.accountName = accountName;
      Prevalent.currentOnlineUser.userName = userName;
      Prevalent.currentOnlineUser.password = password;
      Prevalent.currentOnlineUser.index = index;
      Prevalent.currentOnlineUser.rand = random;
      Prevalent.admin = admin!;
    }
  }

  static Remember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', Prevalent.currentOnlineUser.userName);
    prefs.setString('accountName', Prevalent.currentOnlineUser.accountName);
    prefs.setString('index', Prevalent.currentOnlineUser.index);
    prefs.setString('password', Prevalent.currentOnlineUser.password);
    prefs.setString('random', Prevalent.currentOnlineUser.rand);
    prefs.setBool('admin', Prevalent.admin);
  }

  static void logOut(BuildContext context) async {
    currentOnlineUser = new AvUser.a();
    avUser = new AvUser.a();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userName');
    prefs.remove('accountName');
    prefs.remove('index');
    prefs.remove('password');
    prefs.remove('random');
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }

  static ProgressDialogue(BuildContext context, String message) {
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(message),
              content: Container(
                  width: 30,
                  height: 60,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.redAccent,
                  ))),
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

  static updateUser(BuildContext context) async {
    ProgressDialogue(context, "retrieving your account");
    CollectionReference use = FirebaseFirestore.instance.collection(database);
    await use
        .doc(Prevalent.currentOnlineUser.accountName)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Map<String, dynamic> Users = data["users"];

        Map<String, dynamic> user = Users[Prevalent.currentOnlineUser.index];
        AvUser avUser = AvUser.a();
        avUser.fromMap(user);
        print("User: " +avUser.phone);
        print("User: " +avUser.UID);
        print("User: " +avUser.database);
        print("User: " +avUser.companyCode);
        if (avUser.phone.isNotEmpty) {
          if (currentUser.phoneNumber == avUser.phone) {
            var random = Prevalent.getRandomString(10);
            use.doc(Prevalent.currentOnlineUser.accountName).update({
              'users.' + Prevalent.currentOnlineUser.index + '.rand': random
            });
            Prevalent.saveCurrentOnlineUser(
                avUser.accountName,
                avUser.userName,
                avUser.password,
                avUser.index,
                random,
                avUser.created,
                avUser.expire,
                avUser.phone,
            avUser.subscriberId,
            avUser.subscriberPeriod,
            avUser.companyCode,
            database);
            if (true) {
              Prevalent.Remember();
            }
            if (Prevalent.currentOnlineUser.accountName == "Staff") {
              Prevalent.adminUltPass = data["adminPassword"];
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => StuffPanel()),
                  (route) => false);
            } else {
              //Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
            }
          } else {
            Navigator.pop(context);
            showDialog<String>(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text('Account Already registered'),
                      content: Text(
                          "this account is already registered to another phone number, "
                          "if you believe that this account belongs to you, please contact your admin"
                          ", or Send us message on whatsapp for support, or verify another phone number"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async => {
                            Navigator.pop(context),
                            await launchUrl(Uri.parse(link)),
//                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
//                      (context) => Login()), (route) => false),
                          },
                          child: const Text(
                            'Whatsapp',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                        TextButton(
                          onPressed: () => {
                            Navigator.pop(context),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EntrPhone("login")))
//                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
//                      (context) => Login()), (route) => false),
                          },
                          child: const Text('Verify another Number'),
                        ),
                        TextButton(
                          onPressed: () => {
                            Navigator.pop(context),
                            Prevalent.logOut(context)
//                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
//                      (context) => Login()), (route) => false),
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ));
          }
        } else {
          use.doc(Prevalent.currentOnlineUser.accountName).update({
            'users.' + Prevalent.currentOnlineUser.index + '.phone':
                currentUser.phoneNumber
          });
          var random = Prevalent.getRandomString(10);
          use.doc(Prevalent.currentOnlineUser.accountName).update(
              {'users.' + Prevalent.currentOnlineUser.index + '.rand': random});
          Prevalent.currentOnlineUser.rand = random;
          if (true) {
            Prevalent.Remember();
          }
          if (Prevalent.currentOnlineUser.accountName == "Staff") {
            Prevalent.adminUltPass = data["adminPassword"];
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => StuffPanel()),
                (route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                (route) => false);
          }
        }
      }
    });
  }

  
  //endregion
  static final link =
      "whatsapp://send?phone=+201020398525&text=I%20have%20a%20problem%20logging%20in.";
  var whatsappUrl = "whatsapp://send?phone=2010209452104";

  static void popMessage(title, message, context, String button) {
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  onPressed: () => {
                    Navigator.pop(context),
                  },
                  child: Text(button),
                ),
              ],
            ));
  }
  static void popMessageLoggingOut(context) {
    //(, ,context, "Logout");
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Ops"),
          content: Text("Sorry, we encountered a problem with your account. Please login again"),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                Prevalent.logOut(context)
              },
              child: Text("Logout"),
            ),
          ],
        ));
  }
  static void popWhatsappMessagr(title, message, context){

    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(
              message),
          actions: <Widget>[
            TextButton(
              onPressed: () async => {
                Navigator.pop(context),
                await launchUrl(Uri.parse(link)),
//                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
//                      (context) => Login()), (route) => false),
              },
              child: const Text(
                'Whatsapp',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            TextButton(
              onPressed: () => {
                Navigator.pop(context),
                registerNewPhone(context)
//                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
//                      (context) => Login()), (route) => false),
              },
              child: const Text('Verify another Number'),
            ),
            TextButton(
              onPressed: () => {
                Navigator.pop(context),
                Prevalent.logOut(context)
//                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
//                      (context) => Login()), (route) => false),
              },
              child: const Text('Cancel'),
            ),
          ],
        ));
  }

  static void subscriptionExpired(title, message, context, String button) {
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                Navigator.pop(context)
              },
              child: Text(button),
            ),
          ],
        ));
  }



  static Future<bool> getSharingCode(Code) async {
    DateTime expir = DateTime.now();
    Map<String, dynamic>? map = new Map<String, dynamic>();
    Timestamp expire  = Timestamp.fromDate(DateTime.now());
    CollectionReference share = FirebaseFirestore.instance.collection("sharing");
    await share.doc(Code).get().then((DocumentSnapshot doc) =>
    {
      if(doc.exists){
        map = doc.data() as Map<String, dynamic>,
        expire = map!["expire"] == null
            ? Timestamp.fromDate(DateTime.now())
            : map!["expire"],
        expir = map!["expire"] == null ? DateTime.now() : expire.toDate(),
        if(expir.isAfter(DateTime.now())){
          cond = true
        },

      }
      else {
        cond = false
      }
    });
    print(DateTime.now().toString());
    print(expir.toString());
    print(cond.toString());
    return cond;
  }


}


