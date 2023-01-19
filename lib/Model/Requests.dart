
import 'package:flutter/cupertino.dart';

class Requests{
  late String type, location,subLocation, delivery, finish;
  late Payment payment;
  late String apArea, apRooms, apFloor,apPPm, aptype;
  late String sAArea;
  late String viArea, viRooms, viType, viLandArea;
  late String chArea, chRooms, chFloor, chType;
  late String comArea, comOutdoorsArea,comType, comFloor, comPPM;
  late String adminArea, adminPPM, adminType;



  Requests.empty()
  {
  this.type = ""; this.location = ""; this.subLocation=""; this.apPPm = "";  this.delivery = ""; this.finish = ""; aptype = ""; this.payment = new Payment.e();
  this.apArea = ""; this.apRooms = ""; this.apFloor = ""; this.sAArea = ""; this.viArea = ""; this.viRooms = "";
  this.viType = ""; this.viLandArea = ""; this.chArea = ""; this.chRooms = ""; this.chFloor = "";
  this.comArea = "";this.comType=""; this.comOutdoorsArea = ""; this.comFloor = ""; this.comPPM=""; this.adminArea = ""; this.adminPPM= "";
   this.adminType = "";
}

  Requests.emp(this.type, this.location){

    this.apPPm = "All";           this.delivery = "All";             this.finish = "All";
    aptype = "All";               this.apArea = "All";               this.apRooms = "All";
    this.apFloor = "All";         this.sAArea = "All";                this.viArea = "All";
    this.viRooms = "All";         this.viType = "All";                this.viLandArea = "All";
    this.chArea = "All";          this.chRooms = "All";               this.chFloor = "All";
    this.comArea = "All";         this.comType="All";                 this.comOutdoorsArea = "All";
    this.comFloor = "All";        this.comPPM="All";                  this.adminArea = "All";
    this.adminPPM= "All";         this.subLocation = "All";           this.adminType = "All";
    this.payment = new Payment("Installments", 0, 0, 0);
  }
  Requests.ap(this.type, this.location, this.subLocation, this.delivery, this.apPPm, this.finish,
      this.apArea, this.apRooms, this.aptype, this.apFloor, this.payment);
  Requests.SA(this.type, this.location,this.subLocation, this.delivery, this.finish,
      this.sAArea, this.payment);
  Requests.vi(this.type, this.location,this.subLocation, this.delivery, this.finish,
      this.viArea, this.viLandArea, this.viRooms, this.viType, this.payment);
  Requests.ch(this.type, this.location,this.subLocation, this.delivery, this.finish,
      this.chArea,this.chFloor, this.chRooms,this.payment);
  Requests.com(this.type,
      this.location,this.subLocation,
      this.delivery,
      this.finish,
      this.comArea,
      this.comFloor,
      this.comPPM,
      this.comOutdoorsArea,
      this.comType,
      this.payment);
  Requests.admin(this.type, this.location,this.subLocation, this.delivery, this.finish,
      this.adminArea, this.adminPPM,this.adminType, this.payment);
}



class Payment{

  late String paymentSearch;
  var priceStart, priceEnd, longestYears;

  Payment(this.paymentSearch, this.priceStart, this.priceEnd, this.longestYears);

  Payment.e(){
    this.paymentSearch = ""; this.priceStart = 0; this.priceEnd = 0;
    this.longestYears = 0;
      }

}

class userReq{
  late String name, company, number, status;

  userReq(this.name, this.company, this.number, this.status);

  userReq.a();

  fromMap(Map map){
    this.name = map["name"];
    this.company = map["company"];
    this.number = map["mobile"] == null?map["number"]:map["mobile"];
    this.status = map["status"]==null?"New":map["status"];
  }

  Map toMap() {
    Map<String, dynamic>? map = new Map();
    map["name"] = this.name;
    map["company"] = this.company;
    map["number"] = this.number;
    map["status"] = "Handled";
    return map;
  }
}