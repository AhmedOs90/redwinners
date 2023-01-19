
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../engines/prevelant.dart';

class Account{
  late String accountName;
  late String admin, adminPassword;
  late int count;
  late bool status;
  late List<AvUser> Users;

  Account.a();
  Account(this.count, this.accountName);
  fromMap(Map map)
  {
     this.accountName = map["accountName"];
     this.admin =map["admin"];
     this.adminPassword = map["adminPassword"];
     this.count = map["count"];
     Map<String, dynamic> users = map["users"];

     //this.Users = map["users"];
  }
  creating()
  {
    this.Users = [];
    for (int i = 0; i < count; i++)
      {
        AvUser user = AvUser(accountName, "User" + i.toString(), Prevalent.getRandompass(4));
        Users.add(user);
      }
    this.admin = accountName.replaceAll(" ", "") + "Admin";
    this.adminPassword = accountName.replaceAll(" ", "") + "Admin";
  }
}

class AvUser{
  late String accountName, userName, password, index, rand, UID, phone;
  late DateTime created, expire;
  late String subscriberPeriod, subscriberId, companyCode, database;

  set Expire(DateTime expir) {
    expire = expir;
  }

  AvUser(this.accountName, this.userName, this.password);
  AvUser.a(){
    this.database = "";
    accountName = ""; userName = ""; password = ""; index = "";
    rand = ""; UID = ""; phone = ""; created = DateTime.now();
    expire = DateTime.now().add(Duration(days: 8));
    subscriberPeriod = "";subscriberId = "";companyCode = "";
  }



  fromMap(Map map)
  {
    this.accountName = map["account"];
    this.index = map["index"];
    this.userName = map["userName"];
    this.password = map["password"];
    Timestamp expire = map["expire"] == null? Timestamp.fromDate(DateTime.now()): map["expire"];
    Timestamp create = map["created"] == null? Timestamp.fromDate(DateTime.now()): map["created"];
    this.created = map["created"]==null? DateTime.now(): create.toDate();
    this.expire = map["expire"]==null? DateTime.now(): expire.toDate();
    this.UID = map["UID"] == null? "": map["UID"];
    this.phone = map["phone"] == null? "": map["phone"];
    this.rand =  (map["rand"]==null? "":map["rand"]);
    this.subscriberPeriod = (map["subscriberPeriod"]==null?"zero":map["subscriberPeriod"]);
    this.subscriberId = (map["subscriberId"]==null?"":map["subscriberId"]);
    this.companyCode = (map["companyCode"]==null?"056741230":map["companyCode"]);
    this.database = (map["database"]==null?"":map["database"]);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map["account"] = this.accountName;
    map["index"] = this.index;
    map["userName"] = this.userName;
    map["password"] = this.password;
    map["created"] = this.created;
    map["expire"] = this.expire;
    map["UID"] = this.UID;
    map["phone"] =this.phone;
    map["rand"] = this.rand;
    map["subscriberPeriod"] = this.subscriberPeriod;
    map["subscriberId"]=  this.subscriberId;
    map["companyCode"] = this.companyCode;
    map["database"] = this.database;
    return map;
  }
}

class Subscriber extends AvUser{
  Subscriber.a() : super.a();

}