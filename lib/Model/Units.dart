import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SearchUnit {
  late String id,projectID,instalmentYears;
  var price,cashPrice;

  SearchUnit(this.id, this.projectID, this.price, this.cashPrice,this.instalmentYears);

  SearchUnit.a();

  void fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.price = map["price"];
    this.cashPrice = map["cashPrice"];
    this.projectID = map["projectID"];
    this.instalmentYears = map["instalmentYears"];
  }


}

class ProjectCarding {
  var projectName,photo1,type,developer,areaInFeddan,location,lowestPPM,id;
  ProjectCarding.a();

  fromMap(Map map) {
    this.id = map["id"];
    this.projectName = map["projectName"];
    this.developer = map["developer"];
    this.areaInFeddan = map["areaInFeddan"];
    this.location = map["location"];
    this.type = map["type"];
    this.photo1 = map["photo1"];
    this.lowestPPM = map["lowestPPM"];
  }

}
class Apartments {

  late String id,
      areaRange,
      delivery,
      finish,
      developer,
      loadPercent,
      location,
      maintenance,
  inLoaction,
      paymentPlan,
      cashDiscount,
      projectName,
      type,
      apartmentType,
      floor,
      contactPerson1,
      phoneNumber1,
      contactPerson2,
      phoneNumber2,
      currentOffer,
      rooms,
      projectID,
  ppmRange;
  late String image0,
      image1,
      image2,
      image3,
      image4,
      image5,
      image6,
      image7,
      image8,
      image9,
      instalmentYears,
      installmentRange;
  var price, cashPrice, bua, garden, ppm;
  late bool gardenBool, roofBool;


  Apartments(
      this.id,
      this.bua,
      this.areaRange,
      this.delivery,
      this.finish,
      this.developer,
      this.garden,
      this.gardenBool,
      this.roofBool,
      this.loadPercent,
      this.location,
      this.maintenance,
      this.paymentPlan,
      this.cashDiscount,
      this.projectName,
      this.type,
      this.inLoaction,
      this.apartmentType,
      this.image0,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5,
      this.image6,
      this.image7,
      this.image8,
      this.image9,
      this.rooms,
      this.price,
      this.cashPrice,
      this.floor,
      this.phoneNumber1,
      this.contactPerson1,
      this.contactPerson2,
      this.phoneNumber2,
      this.currentOffer,
      this.ppm,
      this.projectID,
      this.instalmentYears,
      this.installmentRange,
      this.ppmRange);

  Apartments.a();

  fromMap(Map map) {
    this.id = map["id"];
    this.bua = map["bua"];
    this.areaRange = map["areaRange"];
    this.delivery = map["delivery"];
    DateTime deliver = new DateFormat('MM/dd/yyyy').parse(delivery);
    var deliver1 = (deliver.difference(DateTime.now()).inDays)/356;
    this.delivery = deliver1.round().toString();
    this.finish = map["finish"];
    this.developer = map["developer"];
    this.garden = map["garden"];
    this.gardenBool = map["gardenBool"];
    this.roofBool = map["roofBool"];
    this.loadPercent = map["loadPercent"];
    this.location = map["location"];
    this.inLoaction = map["inLocation"];
    this.apartmentType = map["apartmentType"];
    this.maintenance = map["maintenance"];
    this.paymentPlan = map["paymentPlan"];
    this.cashDiscount = map["cashDiscount"];
    this.projectName = map["projectName"];
    this.type = map["type"];
    this.image0 = map["image0"];
    this.image1 = map["image1"];
    this.image2 = map["image2"];
    this.image3 = map["image3"];
    this.image4 = map["image4"];
    this.image5 = map["image5"];
    this.image6 = map["image6"];
    this.image7 = map["image7"];
    this.image8 = map["image8"];
    this.image9 = map["image9"];
    this.rooms = map["rooms"];
    this.price = map["price"];
    this.cashPrice = map["cashPrice"];
    this.floor = map["floor"];
    this.phoneNumber1 = map["phoneNumber1"];
    this.contactPerson1 = map["contactPerson1"];
    this.phoneNumber2 = map["phoneNumber2"];
    this.contactPerson2 = map["contactPerson2"];
    this.currentOffer = map["currentOffer"];
    this.ppm = map["ppm"];
    this.projectID = map["projectID"];
    this.instalmentYears = map["instalmentYears"];
    this.installmentRange = map["installmentRange"];
    this.apartmentType = map["apartmentType"];
    this.ppmRange = map["ppmRange"];
  }
  toMap() {
    Map<String, dynamic> map = new Map();
    map["id"] = this.id;
    map["bua"] = this.bua;
    map["areaRange"] = this.areaRange;
    switch(this.delivery)
    {
      case "0":
        map["delivery"] = "1/1/2022";
        break;
      case "1":
        map["delivery"] = "1/1/2023";
        break;
      case "2":
        map["delivery"] = "1/1/2024";
        break;
      case "3":
        map["delivery"] = "1/1/2025";
        break;
      case "4":
        map["delivery"] = "1/1/2026";
        break;
      default:
        map["delivery"] = this.delivery;
    }
    map["finish"] = this.finish;
    map["developer"] =this.developer;
    map["garden"] = this.garden;
    map["gardenBool"] =this.gardenBool;
    map["roofBool"] =this.roofBool;
    map["loadPercent"] = this.loadPercent;
    map["location"] =this.location;
    map["inLocation"] =this.inLoaction;
    map["apartmentType"] = this.apartmentType;
    map["maintenance"] = this.maintenance;
    map["paymentPlan"] = this.paymentPlan;
    map["cashDiscount"] = this.cashDiscount;
    map["projectName"] = this.projectName;
    map["type"] = this.type;
    map["image0"] = this.image0;
    map["image1"] = this.image1 ;
    map["image2"] = this.image2;
    map["image3"] =this.image3;
    map["image4"] = this.image4 ;
    map["image5"] = this.image5 ;
    map["image6"] = this.image6;
    map["image7"]= this.image7;
    map["image8"] = this.image8  ;
    map["image9"] =this.image9  ;
    map["rooms"] =this.rooms  ;
    map["price"] = this.price ;
    map["cashPrice"] =this.cashPrice;
    map["floor"] = this.floor  ;
    map["phoneNumber1"] =this.phoneNumber1  ;
    map["contactPerson1"] = this.contactPerson1  ;
    map["phoneNumber2"] = this.phoneNumber2  ;
    map["contactPerson2"] = this.contactPerson2  ;
    map["currentOffer"] = this.currentOffer  ;
    map["ppm"] = this.ppm  ;
    map["projectID"] = this.projectID  ;
    map["instalmentYears"] = this.instalmentYears  ;
    map["installmentRange"] = this.installmentRange  ;
    map["apartmentType"] = this.apartmentType  ;
    map["ppmRange"] = this.ppmRange  ;
    return map;
  }

  List<String> images() {
    List<String> imag = [
      image0,
      image1,
      image2,
      image3,
      image4,
      image5,
      image6,
      image7,
      image8,
      image9
    ];
    return imag;
  }

  void fromMapReq(Map<String, dynamic> map) {

  }
}

class Villas {
  late String id,
      areaRange,
      landAreaRange,
      delivery,
      finish,
      developer,
      location,
      inLocation,
      maintenance,
      paymentPlan,
      cashDiscount,
      projectName,
      rooms,
      type,
      villaType,
      image0,
      image1,
      image2,
      image3,
      image4,
      image5,
      image6,
      image7,
      image8,
      image9,
      contactPerson1,
      phoneNumber1,
      contactPerson2,
      phoneNumber2,
      currentOffer,
      projectID,
      instalmentYears,
      installmentRange;
  var price, cashPrice, bua, landArea;
  Villas(
      this.id,
      this.areaRange,
      this.landArea,
      this.landAreaRange,
      this.delivery,
      this.finish,
      this.developer,
      this.location,
      this.inLocation,
      this.maintenance,
      this.paymentPlan,
      this.cashDiscount,
      this.projectName,
      this.rooms,
      this.type,
      this.villaType,
      this.image0,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5,
      this.image6,
      this.image7,
      this.image8,
      this.image9,
      this.contactPerson1,
      this.phoneNumber1,
      this.contactPerson2,
      this.phoneNumber2,
      this.currentOffer,
      this.projectID,
      this.instalmentYears,
      this.price,
      this.cashPrice,
      this.bua,
      this.installmentRange);

  Villas.a();

  List<String> images() {
    List<String> imag = [
      image0,
      image1,
      image2,
      image3,
      image4,
      image5,
      image6,
      image7,
      image8,
      image9
    ];
    return imag;
  }

  fromMap(Map map) {
    this.id = map["id"];
    this.bua = map["bua"];
    this.areaRange = map["areaRange"];
    this.landArea = map["landArea"];
    this.landAreaRange = map["landAreaRange"];
    this.delivery = map["delivery"];
    DateTime deliver = new DateFormat('MM/dd/yyyy').parse(delivery);
    var deliver1 = (deliver.difference(DateTime.now()).inDays)/356;
    this.delivery = deliver1.round().toString();
    this.finish = map["finish"];
    this.developer = map["developer"];
    this.location = map["location"];
    this.inLocation = map ["inLocation"];
    this.maintenance = map["maintenance"];
    this.paymentPlan = map["paymentPlan"];
    this.cashDiscount = map["cashDiscount"].toString();
    this.projectName = map["projectName"];
    this.type = map["type"];
    this.villaType = map["villaType"];
    this.image0 = map["image0"];
    this.image1 = map["image1"];
    this.image2 = map["image2"];
    this.image3 = map["image3"];
    this.image4 = map["image4"];
    this.image5 = map["image5"];
    this.image6 = map["image6"];
    this.image7 = map["image7"];
    this.image8 = map["image8"];
    this.image9 = map["image9"];
    this.rooms = map["rooms"];
    this.price = map["price"];
    this.cashPrice = map["cashPrice"];
    this.phoneNumber1 = map["phoneNumber2"];
    this.contactPerson1 = map["contactPerson2"];
    this.phoneNumber2 = map["phoneNumber2"];
    this.contactPerson2 = map["contactPerson2"];
    this.currentOffer = map["currentOffer"];
    this.projectID = map["projectID"];
    this.instalmentYears = map["instalmentYears"];
    this.installmentRange = map["installmentRange"];
  }
  toMap() {
    Map<String, dynamic> map = new Map();
    map["id"] = this.id;
    map["bua"] = this.bua;
    map["areaRange"] = this.areaRange;
    map["landArea"] = this.landArea;
    map["landAreaRange"] = this.landAreaRange;
    map["finish"] = this.finish;
    map["developer"] = this.developer;
    switch(this.delivery)
    {
      case "0":
        map["delivery"] = "1/1/2022";
        break;
      case "1":
        map["delivery"] = "1/1/2023";
        break;
      case "2":
        map["delivery"] = "1/1/2024";
        break;
      case "3":
        map["delivery"] = "1/1/2025";
        break;
      case "4":
        map["delivery"] = "1/1/2026";
        break;
      default:
        map["delivery"] = this.delivery;
    }
    map["location"] = this.location;
    map ["inLocation"] = this.inLocation;
    map["maintenance"] = this.maintenance;
    map["paymentPlan"] = this.paymentPlan;
    map["cashDiscount"] =this.cashDiscount;
    map["projectName"] = this.projectName;
    map["type"] = this.type;
    map["villaType"] = this.villaType;
    map["image0"] = this.image0;
    map["image1"] = this.image1;
    map["image2"] = this.image2;
    map["image3"] = this.image3;
    map["image4"] = this.image4;
    map["image5"] = this.image5;
    map["image6"] = this.image6;
    map["image7"] = this.image7;
    map["image8"] = this.image8;
    map["image9"] = this.image9;
    map["rooms"] = this.rooms;
    map["price"] = this.price;
    map["cashPrice"] = this.cashPrice;
    map["phoneNumber1"] = this.phoneNumber1;
    map["contactPerson1"] = this.contactPerson1;
    map["phoneNumber2"] = this.phoneNumber2;
    map["contactPerson2"] = this.contactPerson2;
    map["currentOffer"] = this.currentOffer;
    map["projectID"] = this.projectID;
    map["instalmentYears"] = this.instalmentYears;
    map["installmentRange"] = this.installmentRange;
    return map;
  }
}

class ServicedApartments {
  late String id,
      areaRange,
      delivery,
      finish,
      developer,
      loadPercent,
      location,
      inLocation,
      maintenance,
      paymentPlan,
      cashDiscount,
      projectName,
      type,
      image0,
      image1,
      image2,
      image3,
      image4,
      image5,
      image6,
      image7,
      image8,
      image9,
      contactPerson1,
      phoneNumber1,
      contactPerson2,
      phoneNumber2,
      currentOffer,
      projectID,
      instalmentYears,
      installmentRange;
  var bua, price, cashPrice;





ServicedApartments(
      this.id,
      this.bua,
      this.areaRange,
      this.delivery,
      this.finish,
      this.developer,
      this.loadPercent,
      this.location,
      this.inLocation,
      this.maintenance,
      this.paymentPlan,
      this.cashDiscount,
      this.projectName,
      this.type,
      this.image0,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5,
      this.image6,
      this.image7,
      this.image8,
      this.image9,
      this.contactPerson1,
      this.phoneNumber1,
      this.contactPerson2,
      this.phoneNumber2,
      this.currentOffer,
      this.projectID,
      this.instalmentYears,
      this.price,
      this.cashPrice,
      this.installmentRange);

  ServicedApartments.a();
  fromMap(Map map) {
    this.id = map["id"];
    this.bua = map["bua"];
    this.areaRange = map["areaRange"];
    this.delivery = map["delivery"];
    DateTime deliver = new DateFormat('MM/dd/yyyy').parse(delivery);
    var deliver1 = (deliver.difference(DateTime.now()).inDays)/356;
    this.delivery = deliver1.round().toString();
    this.finish = map["finish"];
    this.developer = map["developer"];
    this.loadPercent = map["loadPercent"];
    this.location = map["location"];
    this.inLocation = map["inLocation"];
    this.maintenance = map["maintenance"];
    this.paymentPlan = map["paymentPlan"];
    this.cashDiscount = map["cashDiscount"].toString();
    this.projectName = map["projectName"];
    this.type = map["type"];
    this.image0 = map["image0"];
    this.image1 = map["image1"];
    this.image2 = map["image2"];
    this.image3 = map["image3"];
    this.image4 = map["image4"];
    this.image5 = map["image5"];
    this.image6 = map["image6"];
    this.image7 = map["image7"];
    this.image8 = map["image8"];
    this.image9 = map["image9"];
    this.price = map["price"];
    this.cashPrice = map["cashPrice"];
    this.phoneNumber1 = map["phoneNumber1"];
    this.contactPerson1 = map["contactPerson1"];
    this.phoneNumber2 = map["phoneNumber2"];
    this.contactPerson2 = map["contactPerson2"];
    this.currentOffer = map["currentOffer"];
    this.projectID = map["projectID"];
    this.instalmentYears = map["instalmentYears"];
    this.installmentRange = map["installmentRange"];
  }
  toMap() {
    Map<String, dynamic> map = Map();
    map["id"] = this.id;
    map["bua"] = this.bua;
    map["areaRange"] = this.areaRange ;
    switch(this.delivery)
    {
      case "0":
        map["delivery"] = "1/1/2022";
        break;
      case "1":
        map["delivery"] = "1/1/2023";
        break;
      case "2":
        map["delivery"] = "1/1/2024";
        break;
      case "3":
        map["delivery"] = "1/1/2025";
        break;
      case "4":
        map["delivery"] = "1/1/2026";
        break;
      default:
        map["delivery"] = this.delivery;
    }
    map["finish"] = this.finish ;
    map["developer"] = this.developer;
    map["loadPercent"] = this.loadPercent;
    map["location"] = this.location;
    map["inLocation"] = this.inLocation;
    map["maintenance"] = this.maintenance;
    map["paymentPlan"] = this.paymentPlan;
    map["cashDiscount"] = this.cashDiscount;
    map["projectName"] = this.projectName;
    map["type"] = this.type;
    map["image0"] = this.image0;
    map["image1"] = this.image1;
    map["image2"] = this.image2;
    map["image3"] = this.image3;
    map["image4"] = this.image4;
    map["image5"] = this.image5;
    map["image6"] = this.image6;
    map["image7"] = this.image7;
    map["image8"] = this.image8;
    map["image9"] = this.image9;
    map["price"] = this.price;
    map["cashPrice"] = this.cashPrice;
    map["phoneNumber1"] = this.phoneNumber1;
    map["contactPerson1"] =this.contactPerson1;
    map ["phoneNumber2"] = this.phoneNumber2;
    map["contactPerson2"] = this.contactPerson2;
    map["currentOffer"] = this.currentOffer ;
    map["projectID"] = this.projectID ;
    map["instalmentYears"] = this.instalmentYears ;
    map["installmentRange"] = this.installmentRange ;
    return map;
  }

  List<String> images() {
    List<String> imag = [
      image0,
      image1,
      image2,
      image3,
      image4,
      image5,
      image6,
      image7,
      image8,
      image9
    ];
    return imag;
  }
}

class Commercials {

  late String id,
      areaRange,
      type,
      subType,
      delivery,
      finish,
      developer,
      loadPercent,
      location,
      inLocation,
      maintenance,
      paymentPlan,
      cashDiscount,
      projectName,
      ppmRange,
      image0,
      image1,
      image2,
      image3,
      image4,
      image5,
      image6,
      image7,
      image8,
      image9,
      floor,
      contactPerson1,
      phoneNumber1,
      contactPerson2,
      phoneNumber2,
      currentOffer,
      projectID,
      instalmentYears,
      installmentRange;
  var price,
      cashPrice,
      bua,
      ppm,
      outdoorArea;
      late bool outDoorBool;

  Commercials(
      this.id,
      this.areaRange,
      this.type,
      this.subType,
      this.delivery,
      this.finish,
      this.developer,
      this.loadPercent,
      this.location,
      this.inLocation,
      this.maintenance,
      this.paymentPlan,
      this.cashDiscount,
      this.projectName,
      this.ppmRange,
      this.outDoorBool,
      this.image0,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5,
      this.image6,
      this.image7,
      this.image8,
      this.image9,
      this.floor,
      this.contactPerson1,
      this.phoneNumber1,
      this.contactPerson2,
      this.phoneNumber2,
      this.currentOffer,
      this.projectID,
      this.instalmentYears,
      this.price,
      this.cashPrice,
      this.bua,
      this.ppm,
      this.outdoorArea,
      this.installmentRange);

  Commercials.a();



  fromMap(Map map) {
    this.id = map["id"];
    this.bua = map["bua"];
    this.areaRange = map["areaRange"];
    this.type = map["type"];
    this.subType = map["subType"];
    this.delivery = map["delivery"];
    DateTime deliver = new DateFormat('MM/dd/yyyy').parse(delivery);
    var deliver1 = (deliver.difference(DateTime.now()).inDays)/356;
    this.delivery = deliver1.round().toString();
    this.finish = map["finish"];
    this.developer = map["developer"];
    this.loadPercent = map["loadPercent"];
    this.location = map["location"];
    this.inLocation = map["inLocation"];
    this.maintenance = map["maintenance"];
    this.paymentPlan = map["paymentPlan"];
    this.cashDiscount = map["cashDiscount"].toString();
    this.projectName = map["projectName"];
    this.ppm = map["ppm"];
    this.ppmRange = map["ppmRange"];
    this.outDoorBool = map["outDoorBool"];
    this.outdoorArea = map["outdoorArea"];
    this.image0 = map["image0"];
    this.image1 = map["image1"];
    this.image2 = map["image2"];
    this.image3 = map["image3"];
    this.image4 = map["image4"];
    this.image5 = map["image5"];
    this.image6 = map["image6"];
    this.image7 = map["image7"];
    this.image8 = map["image8"];
    this.image9 = map["image9"];
    this.floor = map["floor"];
    this.price = map["price"];
    this.cashPrice = map["cashPrice"];
    this.phoneNumber1 = map["phoneNumber1"];
    this.contactPerson1 = map["contactPerson1"];
    this.phoneNumber2 = map["phoneNumber2"];
    this.contactPerson2 = map["contactPerson2"];
    this.currentOffer = map["currentOffer"];
    this.projectID = map["projectID"];
    this.instalmentYears = map["instalmentYears"];
    this.installmentRange = map["installmentRange"];
  }
  toMap(){
    Map<String, dynamic> map = new Map();
    map["id"] = this.id;
    map["bua"] = this.bua;
    map["areaRange"] = this.areaRange;
    map["type"] =this.type;
    map["subType"] =this.subType ;
    switch(this.delivery)
    {
      case "0":
        map["delivery"] = "1/1/2022";
        break;
      case "1":
        map["delivery"] = "1/1/2023";
        break;
      case "2":
        map["delivery"] = "1/1/2024";
        break;
      case "3":
        map["delivery"] = "1/1/2025";
        break;
      case "4":
        map["delivery"] = "1/1/2026";
        break;
      default:
        map["delivery"] = this.delivery;
    }
    map["finish"]=this.finish;
    map["developer"]= this.developer ;
    map["loadPercent"]= this.loadPercent ;
    map["location"] = this.location ;
    map["inLocation"] = this.inLocation ;
    map["maintenance"] = this.maintenance ;
    map["paymentPlan"] = this.paymentPlan ;
    map["cashDiscount"] = this.cashDiscount;
    map["projectName"] =this.projectName;
    map["ppm"]= this.ppm ;
    map["ppmRange"] = this.ppmRange;
    map["outDoorBool"] = this.outDoorBool;
    map["outdoorArea"]= this.outdoorArea;
    map["image0"] = this.image0;
    map["image1"] = this.image1;
    map["image2"] = this.image2;
    map["image3"] = this.image3;
    map["image4"] = this.image4;
    map["image5"] = this.image5;
    map["image6"] = this.image6;
    map["image7"] = this.image7;
    map["image8"] = this.image8;
    map["image9"] = this.image9;
    map["floor"] = this.floor ;
    map["price"]=this.price;
    map["cashPrice"] =this.cashPrice ;
    map["phoneNumber1"] = this.phoneNumber1;
    map["contactPerson1"] = this.contactPerson1;
    map["phoneNumber2"] = this.phoneNumber2 ;
    map["contactPerson2"] = this.contactPerson2;
    map["currentOffer"] = this.currentOffer;
    map["projectID"] = this.projectID;
    map["instalmentYears"] = this.instalmentYears;
    map["installmentRange"] = this.installmentRange;
    return map;
  }
  List<String> images() {
    List<String> imag = [
      image0,
      image1,
      image2,
      image3,
      image4,
      image5,
      image6,
      image7,
      image8,
      image9
    ];
    return imag;
  }
}

class AdminClinics {
  late String id,
      areaRange,
      type,
      delivery,
      finish,
      developer,
      loadPercent,
      location,
      inLocation,
      maintenance,
      paymentPlan,
      cashDiscount,
      projectName,
      ppmRange,
      image0,
      image1,
      image2,
      image3,
      image4,
      image5,
      image6,
      image7,
      image8,
      image9,
      floor,
      contactPerson1,
      phoneNumber1,
      contactPerson2,
      phoneNumber2,
      currentOffer,
      projectID,
      instalmentYears,
      installmentRange;
  var price, cashPrice, bua, ppm;
  late bool typeClinics, typeOffice;

  AdminClinics(
      this.id,
      this.areaRange,
      this.type,
      this.typeClinics,
      this.typeOffice,
      this.delivery,
      this.finish,
      this.developer,
      this.loadPercent,
      this.location,
      this.inLocation,
      this.maintenance,
      this.paymentPlan,
      this.cashDiscount,
      this.projectName,
      this.ppmRange,
      this.image0,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5,
      this.image6,
      this.image7,
      this.image8,
      this.image9,
      this.floor,
      this.contactPerson1,
      this.phoneNumber1,
      this.contactPerson2,
      this.phoneNumber2,
      this.currentOffer,
      this.projectID,
      this.instalmentYears,
      this.price,
      this.cashPrice,
      this.bua,
      this.ppm,
      this.installmentRange);

  AdminClinics.a();

  fromMap(Map map) {
    this.id = map["id"];
    this.bua = map["bua"];
    this.areaRange = map["areaRange"];
    this.type = map["type"];
    this.typeClinics = map["typeClinics"];
    this.typeOffice = map["typeOffice"];
    this.delivery = map["delivery"];
    DateTime deliver = new DateFormat('MM/dd/yyyy').parse(delivery);
    var deliver1 = (deliver.difference(DateTime.now()).inDays)/356;
    this.delivery = deliver1.round().toString();
    this.finish = map["finish"];
    this.developer = map["developer"];
    this.loadPercent = map["loadPercent"];
    this.location = map["location"];
    this.inLocation = map["inLocation"];
    this.maintenance = map["maintenance"];
    this.paymentPlan = map["paymentPlan"];
    this.cashDiscount = map["cashDiscount"].toString();
    this.projectName = map["projectName"];
    this.ppm = map["ppm"];
    this.ppmRange = map["ppmRange"];
    this.image0 = map["image0"];
    this.image1 = map["image1"];
    this.image2 = map["image2"];
    this.image3 = map["image3"];
    this.image4 = map["image4"];
    this.image5 = map["image5"];
    this.image6 = map["image6"];
    this.image7 = map["image7"];
    this.image8 = map["image8"];
    this.image9 = map["image9"];
    this.floor = map["floor"];
    this.price = map["price"];
    this.cashPrice = map["cashPrice"];
    this.phoneNumber1 = map["phoneNumber1"];
    this.contactPerson1 = map["contactPerson1"];
    this.phoneNumber2 = map["phoneNumber2"];
    this.contactPerson2 = map["contactPerson2"];
    this.currentOffer = map["currentOffer"];
    this.projectID = map["projectID"];
    this.instalmentYears = map["instalmentYears"];
    this.installmentRange = map["installmentRange"];

  }
  toMap() {
    Map<String, dynamic> map = new Map();
    map["id"] = this.id ;
    map["bua"] = this.bua;
    map["areaRange"] = this.areaRange;
    map["type"] = this.type;
    map["typeClinics"]= this.typeClinics;
    map["typeOffice"] = this.typeOffice;
    switch(this.delivery)
    {
      case "0":
        map["delivery"] = "1/1/2022";
        break;
      case "1":
        map["delivery"] = "1/1/2023";
        break;
      case "2":
        map["delivery"] = "1/1/2024";
        break;
      case "3":
        map["delivery"] = "1/1/2025";
        break;
      case "4":
        map["delivery"] = "1/1/2026";
        break;
      default:
        map["delivery"] = this.delivery;
    }
    map["finish"] = this.finish ;
    map["developer"] =this.developer ;
    map["loadPercent"] = this.loadPercent;
    map["location"] = this.location;
    map["inLocation"] = this.inLocation;
    map["maintenance"] = this.maintenance;
    map["paymentPlan"] =this.paymentPlan;
    map["cashDiscount"] = this.cashDiscount;
    map["projectName"] =this.projectName;
    map["ppm"] = this.ppm ;
    map["ppmRange"] = this.ppmRange;
    map["image0"] = this.image0;
    map["image1"] = this.image1;
    map["image2"] = this.image2;
    map["image3"] = this.image3;
    map["image4"] = this.image4;
    map["image5"] = this.image5;
    map["image6"] = this.image6;
    map["image7"] = this.image7;
    map["image8"] = this.image8;
    map["image9"] = this.image9;
    map["floor"] = this.floor  ;
    map["price"] = this.price ;
    map["cashPrice"] =this.cashPrice ;
    map["phoneNumber1"] = this.phoneNumber1;
    map["contactPerson1"] = this.contactPerson1;
    map["phoneNumber2"] = this.phoneNumber2;
    map["contactPerson2"] = this.contactPerson2 ;
    map["currentOffer"] = this.currentOffer;
    map["projectID"] = this.projectID ;
    map["instalmentYears"] = this.instalmentYears ;
    map["installmentRange"] = this.installmentRange ;
    return map;
  }

  List<String> images() {
    List<String> imag = [
      image0,
      image1,
      image2,
      image3,
      image4,
      image5,
      image6,
      image7,
      image8,
      image9
    ];
    return imag;
  }


}

class Chalet {
  late String id,
      areaRange,
      delivery,
      finish,
      developer,
      loadPercent,
      location,
      inLocation,
      maintenance,
      paymentPlan,
      cashDiscount,
      projectName,
      type,
      floor,
      contactPerson1,
      phoneNumber1,
      contactPerson2,
      phoneNumber2,
      currentOffer,
      projectID;
  late String image0,
      image1,
      image2,
      image3,
      image4,
      image5,
      image6,
      image7,
      image8,
      image9,
      instalmentYears,
      installmentRange;
  var price, cashPrice, bua, garden, rooms;
  late bool gardenBool, roofBool;


  Chalet(
      this.id,
      this.bua,
      this.areaRange,
      this.delivery,
      this.finish,
      this.developer,
      this.garden,
      this.gardenBool,
      this.roofBool,
      this.loadPercent,
      this.location,
      this.inLocation,
      this.maintenance,
      this.paymentPlan,
      this.cashDiscount,
      this.projectName,
      this.type,
      this.image0,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5,
      this.image6,
      this.image7,
      this.image8,
      this.image9,
      this.rooms,
      this.price,
      this.cashPrice,
      this.floor,
      this.phoneNumber1,
      this.contactPerson1,
      this.phoneNumber2,
      this.contactPerson2,
      this.currentOffer,
      this.projectID,
      this.instalmentYears,
      this.installmentRange);
  Chalet.a();
  fromMap(Map map) {
    this.id = map["id"];
    this.bua = map["bua"];
    this.areaRange = map["areaRange"];
    this.delivery = map["delivery"];
    DateTime deliver = new DateFormat('MM/dd/yyyy').parse(delivery);
    var deliver1 = (deliver.difference(DateTime.now()).inDays)/356;
    this.delivery = deliver1.round().toString();
    this.finish = map["finish"];
    this.developer = map["developer"];
    this.garden = map["garden"];
    this.gardenBool = map["gardenBool"];
    this.roofBool = map["roofBool"];
    this.loadPercent = map["loadPercent"];
    this.location = map["location"];
    this.inLocation = map["inLocation"];
    this.maintenance = map["maintenance"];
    this.paymentPlan = map["paymentPlan"];
    this.cashDiscount = map["cashDiscount"];
    this.projectName = map["projectName"];
    this.type = map["type"];
    this.image0 = map["image0"];
    this.image1 = map["image1"];
    this.image2 = map["image2"];
    this.image3 = map["image3"];
    this.image4 = map["image4"];
    this.image5 = map["image5"];
    this.image6 = map["image6"];
    this.image7 = map["image7"];
    this.image8 = map["image8"];
    this.image9 = map["image9"];
    this.rooms = map["rooms"];
    this.price = map["price"];
    this.cashPrice = map["cashPrice"];
    this.floor = map["floor"];
    this.phoneNumber1 = map["phoneNumber1"];
    this.contactPerson1 = map["contactPerson1"];
    this.phoneNumber2 = map["phoneNumber2"];
    this.contactPerson2 = map["contactPerson2"];
    this.currentOffer = map["currentOffer"];
    this.projectID = map["projectID"];
    this.instalmentYears = map["instalmentYears"];
    this.installmentRange = map["installmentRange"];
  }
  toMap() {
    Map<String, dynamic> map = Map();
    map["id"] = this.id;
    map["bua"] = this.bua;
    map["areaRange"] = this.areaRange;
    map["finish"] = this.finish;
    switch(this.delivery)
    {
      case "0":
        map["delivery"] = "1/1/2022";
        break;
      case "1":
        map["delivery"] = "1/1/2023";
        break;
      case "2":
        map["delivery"] = "1/1/2024";
        break;
      case "3":
        map["delivery"] = "1/1/2025";
        break;
      case "4":
        map["delivery"] = "1/1/2026";
        break;
      default:
        map["delivery"] = this.delivery;
    }
    map["developer"] = this.developer;
    map["garden"] = this.garden;
    map["gardenBool"] = this.gardenBool;
    map["roofBool"] = this.roofBool;
    map["loadPercent"] = this.loadPercent;
    map["location"] = this.location;
    map["inLocation"] = this.inLocation;
    map["maintenance"] = this.maintenance;
    map["paymentPlan"] = this.paymentPlan;
    map["cashDiscount"] = this.cashDiscount;
    map["projectName"] = this.projectName;
    map["type"] = this.type;
    map["image0"] = this.image0;
    map["image1"] = this.image1;
    map["image2"] =this.image2;
    map["image3"] = this.image3;
    map["image4"] = this.image4;
    map["image5"] = this.image5;
    map["image6"] = this.image6;
    map["image7"] = this.image7;
    map["image8"] = this.image8;
    map["image9"] = this.image9;
    map["rooms"] = this.rooms;
    map["price"] = this.price;
    map["cashPrice"] =this.cashPrice;
    map["floor"] = this.floor;
    map["phoneNumber1"] = this.phoneNumber1;
    map["contactPerson1"] =this.contactPerson1;
    map["phoneNumber2"] = this.phoneNumber2;
    map["contactPerson2"] = this.contactPerson2;
    map["currentOffer"] = this.currentOffer;
    map["projectID"] = this.projectID;
    map["instalmentYears"] =this.instalmentYears;
    map["installmentRange"] = this.installmentRange;
    return map;
  }
  List<String> images() {
    List<String> imag = [
      image0,
      image1,
      image2,
      image3,
      image4,
      image5,
      image6,
      image7,
      image8,
      image9
    ];
    return imag;
  }
}

class Unit {
  var image, id, price, bua, finish, type;

  Unit(this.image, this.id, this.price, this.bua, this.finish, this.type);
}

class Developer {
  late bool Arabic;
  late String Logo,
      id,
      developerName,
      dscription,
      contactperson1,
      phone1,
      contactperson2,
      phone2,
      project0,
      project1,
      project2,
      project3,
      project4,
      project5,
      project6,
      project7,
      project8,
      project9,
      project10,
      project11,
      project12,
      project13,
      project14,
      project15,
      project16,
      project17,
      project18,
      project19,
      project20,
      project21,
      project22,
      project23,
      project24,
      project25,
      project26,
      project27,
      project28,
      project29,
      project30,
      project31,
      project32,
      project33,
      project34,
      project35,
      project36,
      project37,
      project38,
      project39,
      project40,
      project41,
      project42,
      project43,
      project44,
      project45,
      project46,
      project47,
      project48,
      project49,
      project50;

  Developer(
      this.id,
      this.Logo,
      this.developerName,
      this.dscription,
      this.project0,
      this.project1,
      this.project2,
      this.project3,
      this.project4,
      this.project5,
      this.Arabic,
      this.project6,
      this.project7,
      this.project8,
      this.project9,
      this.project10,
      this.project11,
      this.project12,
      this.project13,
      this.project14,
      this.project15,
      this.project16,
      this.project17,
      this.project18,
      this.project19,
      this.project20,
      this.project21,
      this.project22,
      this.project23,
      this.project24,
      this.project25,
      this.project26,
      this.project27,
      this.project28,
      this.project29,
      this.project30,
      this.project31,
      this.project32,
      this.project33,
      this.project34,
      this.project35,
      this.project36,
      this.project37,
      this.project38,
      this.project39,
      this.project40,
      this.project41,
      this.project42,
      this.project43,
      this.project44,
      this.project45,
      this.project46,
      this.project47,
      this.project48,
      this.project49,
      this.project50,
  this.contactperson1,
  this.phone1,
  this.contactperson2,
  this.phone2);

  Developer.a();

  fromMap(Map map) {
    this.id = map["id"];
    this.Logo = map["logo"];
    this.developerName = map["developerName"];
    this.contactperson1= map["contactPerson1"];
    this.phone1= map["phone1"];
    this.contactperson2= map["contactPerson2"];
    this.phone2= map["phone2"];
    this.dscription = map["description"];
    this.project0 = map["project0"];
    this.project1 = map["project1"];
    this.project2 = map["project2"];
    this.project3 = map["project3"];
    this.project4 = map["project4"];
    this.project5 = map["project5"];
    this.project6 = map["project6"];
    this.project7 = map["project7"];
    this.project8 = map["project8"];
    this.project9 = map["project9"];
    this.project10 = map["project10"];
    this.project11 = map["project11"];
    this.project12 = map["project12"];
    this.project13 = map["project13"];
    this.project14 = map["project14"];
    this.project15 = map["project15"];
    this.project16 = map["project16"];
    this.project17 = map["project17"];
    this.project18 = map["project18"];
    this.project19 = map["project19"];
    this.project20 = map["project20"];
    this.project21 = map["project21"];
    this.project22 = map["project22"];
    this.project23 = map["project23"];
    this.project24 = map["project24"];
    this.project25 = map["project25"];
    this.project26 = map["project26"];
    this.project27 = map["project27"];
    this.project28 = map["project28"];
    this.project29 = map["project29"];
    this.project30 = map["project30"];
    this.project31 = map["project31"];
    this.project32 = map["project32"];
    this.project33 = map["project33"];
    this.project34 = map["project34"];
    this.project35 = map["project35"];
    this.project36 = map["project36"];
    this.project37 = map["project37"];
    this.project38 = map["project38"];
    this.project39 = map["project39"];
    this.project40 = map["project40"];
    this.project41 = map["project41"];
    this.project42 = map["project42"];
    this.project43 = map["project43"];
    this.project44 = map["project44"];
    this.project45 = map["project45"];
    this.project46 = map["project46"];
    this.project47 = map["project47"];
    this.project48 = map["project48"];
    this.project49 = map["project49"];
    this.project50 = map["project50"];
    this.Arabic = map["Arabic"];
  }

  List<String> projects() {
    List<String> projs = [
      project0,
      project1,
      project2,
      project3,
      project4,
      project5,
      project6,
      project7,
      project8,
      project9,
      project10,
      project11,
      project12,
      project13,
      project14,
      project15,
      project16,
      project17,
      project18,
      project19,
      project20,
      project21,
      project22,
      project23,
      project24,
      project25,
      project26,
      project27,
      project28,
      project29,
      project30,
      project31,
      project32,
      project33,
      project34,
      project35,
      project36,
      project37,
      project38,
      project39,
      project40,
      project41,
      project42,
      project43,
      project44,
      project45,
      project46,
      project47,
      project48,
      project49,
      project50,

    ];
    return projs;
  }
}

class Offer {
  var image, text, id, projectName, developer, location, offerHead, projectId;
  bool Arabic = false;
  Timestamp endDate = new Timestamp(00, 00);
  Offer(this.image, this.text, this.id, this.projectName, this.developer, this.location, this.endDate, this.offerHead, this.projectId, this.Arabic);

  Offer.a();

  fromMap(Map map)
  {
    this.id = map["id"];
    this.text = map["text"];
    this.image = map["image"];
    this.projectName = map["projectName"];
    this.developer = map["developer"];
    this.location = map["location"];
    this.endDate = map["endDate"];
    this.offerHead = map["offerHead"];
    this.projectId = map["projectId"];
    this.Arabic = map["Arabic"];
  }


}

class Launch {
  var image, text, projectName, developer, location, EOI, types, launchType, developerId;
  bool Arabic = false;
  Timestamp launchDate = new Timestamp(00, 00);
  Launch(this.image, this.text,  this.projectName, this.developer, this.location, this.launchDate, this.EOI, this.types, this.launchType, this.developerId, this.Arabic);

  Launch.a();

  fromMap(Map map)
  {
    this.text = map["text"];
    this.image = map["image"];
    this.projectName = map["projectName"];
    this.developer = map["developer"];
    this.location = map["location"];
    this.launchDate = map["launchDate"];
    this.EOI = map["EOI"];
    this.types = map["types"];
    this.launchType = map["launchType"];
    this.developerId = map["developerId"];
    this.Arabic = map["Arabic"];
  }


}

class Project {
  late String id,
      projectName,
      developer,
      description,
      arabicDescription,
      areaInFeddan,
      engineeringConsultant,
      contractor,
      location,
      subLocation,
      type,
      Facilities,
      arabicFacilities,
      garagePrice;
  late String clubPrice,
      maintanace,
      loadPercent,
      finish,
      paymentPlan,
      cashDiscount,
      longestYears,
      earliestDelivery,
      redwinnersSheet;
  late String currentOffer, contactPerson1,
      phoneNumber1, contactPerson2,
      phoneNumber2, brochure,
      masterPlan, locationMap,
      photo1,
      photo2,
      photo3,
      photo4;
  late String photo5, photo6, photo7, photo8, photo9, photo10;
  var lowestPPM, highestPPM, lastUpdate;
  bool arabic = false;
  late String developerId;

  Project(this.id,
      this.projectName,
      this.developer,
      this.description,
      this.areaInFeddan,
      this.engineeringConsultant,
      this.contractor,
      this.location,
      this.subLocation,
      this.type,
      this.Facilities,
      this.garagePrice,
      this.clubPrice,
      this.maintanace,
      this.loadPercent,
      this.finish,
      this.paymentPlan,
      this.cashDiscount,
      this.longestYears,
      this.earliestDelivery,
      this.redwinnersSheet,
      this.currentOffer,
      this.contactPerson1,
      this.phoneNumber1,
      this.contactPerson2,
      this.phoneNumber2,
      this.brochure,
      this.masterPlan,
      this.locationMap,
      this.photo1,
      this.photo2,
      this.photo3,
      this.photo4,
      this.photo5,
      this.photo6,
      this.photo7,
      this.photo8,
      this.photo9,
      this.photo10,
      this.lowestPPM,
      this.highestPPM,
      this.arabic,
      this.arabicDescription,
      this.arabicFacilities,
      this.lastUpdate,
      this.developerId);

  Project.a();

  fromMap(Map map) {
    this.id = map["id"];
    this.projectName = map["projectName"];
    this.developer = map["developer"];
    this.description = map["description"];
    this.areaInFeddan = map["areaInFeddan"];
    this.engineeringConsultant = map["engineeringConsultant"];
    this.contractor = map["contractor"];
    this.location = map["location"];
    this.subLocation = map["subLocation"];
    this.type = map["type"];
    this.Facilities = map["Facilities"];
    this.garagePrice = map["garagePrice"];
    this.clubPrice = map["clubPrice"];
    this.maintanace = map["maintanace"];
    this.loadPercent = map["loadPercent"];
    this.finish = map["finish"];
    this.paymentPlan = map["paymentPlan"];
    this.cashDiscount = map["cashDiscount"];
    this.longestYears = map["longestYears"];
    this.earliestDelivery = map["earliestDelivery"];
    DateTime deliver = new DateFormat('MM/dd/yyyy').parse(earliestDelivery);
    var delivery = (deliver
        .difference(DateTime.now())
        .inDays) / 356;
    this.earliestDelivery = delivery.round().toString();
    this.redwinnersSheet = map["availabilitySheet"];
    this.currentOffer = map["currentOffer"];
    this.contactPerson1 = map["contactPerson1"];
    this.phoneNumber1 = map["phoneNumber1"];
    this.contactPerson2 = map["contactPerson2"];
    this.phoneNumber2 = map["phoneNumber2"];
    this.masterPlan = map["masterPlan"];
    this.locationMap = map["locationMap"];
    this.photo1 = map["photo1"];
    this.photo2 = map["photo2"];
    this.photo3 = map["photo3"];
    this.photo4 = map["photo4"];
    this.photo5 = map["photo5"];
    this.photo6 = map["photo6"];
    this.photo7 = map["photo7"];
    this.photo8 = map["photo8"];
    this.photo9 = map["photo9"];
    this.photo10 = map["photo10"];
    this.lowestPPM = map["lowestPPM"];
    this.highestPPM = map["highestPPM"];
    this.arabic = map["arabic"];
    this.arabicDescription = map["arabicDescription"];
    this.arabicFacilities = map["arabicFacilities"];
    this.brochure = map["brochure"];
    this.lastUpdate = map["lastUpdate"];
    this.developerId = map["developerId"];
  }

  Map toMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["id"] = this.id;
    map["projectName"] = this.projectName;
    map["developer"] = this.developer;
    map["description"] = this.description;
    map["areaInFeddan"] = this.areaInFeddan;
    map["engineeringConsultant"] = this.engineeringConsultant;
    map["contractor"] = this.contractor;
    map["location"] = this.location;
    map["subLocation"] = this.subLocation;
    map["type"] = this.type;
    map["Facilities"] = this.Facilities;
    map["garagePrice"] = this.garagePrice;
    map["clubPrice"] = this.clubPrice;
    map["maintanace"] = this.maintanace;
    map["loadPercent"] = this.loadPercent;
    map["finish"] = this.finish;
    map["paymentPlan"] = this.paymentPlan;
    map["cashDiscount"] = this.cashDiscount;
    map["longestYears"] = this.longestYears;
    map["earliestDelivery"] = getdelivery(this.earliestDelivery);
    map["redwinnersSheet"] = this.redwinnersSheet;
    map["currentOffer"] = this.currentOffer;
    map["contactPerson1"] = this.contactPerson1;
    map["phoneNumber1"] = this.phoneNumber1;
    map["contactPerson2"] = this.contactPerson2;
    map["phoneNumber2"] = this.phoneNumber2;
    map["masterPlan"] = this.masterPlan;
    map["locationMap"] = this.locationMap;
    map["photo1"] = this.photo1;
    map["photo2"] = this.photo2;
    map["photo3"] = this.photo3;
    map["photo4"] = this.photo4;
    map["photo5"] = this.photo5;
    map["photo6"] = this.photo6;
    map["photo7"] = this.photo7;
    map["photo8"] = this.photo8;
    map["photo9"] = this.photo9;
    map["photo10"] = this.photo10;
    map["lowestPPM"] = this.lowestPPM;
    map["arabic"] = this.arabic;
    map["arabicDescription"] = this.arabicDescription;
    map["arabicFacilities"] = this.arabicFacilities;
    map["brochure"] = this.brochure;
    map["lastUpdate"] = this.lastUpdate;
    map["developerId"] = this.developerId;
    return map;
  }

  List<String> images() {
    List<String> imag = [
      photo1,
      photo2,
      photo3,
      photo4,
      photo5,
      photo6,
      photo7,
      photo8,
      photo9,
      photo10
    ];
    return imag;
  }

  setImages(List<String> imag) {
    this.photo1 = imag[0];
    this.photo2 = imag[1];
    this.photo3 = imag[2];
    this.photo4 = imag[3];
    this.photo5 = imag[4];
    this.photo6 = imag[5];
    this.photo7 = imag[6];
    this.photo8 = imag[7];
    this.photo9 = imag[8];
    this.photo10 = imag[9];
  }

  createProject(List<subUnit> unitsList) {
    List unitList = [];
    for (int i = 0; i < unitsList.length; i++) {
      switch (type) {
        case "Commercials":
          Commercials commercials = new Commercials(
              getunitID(id, unitsList[i].id),
              getAreaRange(unitsList[i].bua, type),
              type,
              unitsList[i].subType,
              unitsList[i].delivery,
              unitsList[i].finish,
              developer,
              loadPercent,
              location,
              subLocation,
              getMaintenance(maintanace, unitsList[i].price, unitsList[i].bua),
              paymentPlan,
              unitsList[i].cashDiscount,
              projectName,
              getPpmRange(unitsList[i].ppm),
              getOutDoorBool(unitsList[i].outdoorArea),
              photo1,
              photo2,
              photo3,
              photo4,
              photo5,
              photo6,
              photo7,
              photo8,
              photo9,
              photo10,
              unitsList[i].floor,
              contactPerson1,
              phoneNumber1,
              contactPerson2,
              phoneNumber2,
              currentOffer,
              id,
              unitsList[i].instalmentYears,
              unitsList[i].price,
              getCashPrice(unitsList[i].cashDiscount, unitsList[i].price),
              unitsList[i].bua,
              unitsList[i].ppm,
              unitsList[i].outdoorArea,
              getinstallmentRange(unitsList[i].instalmentYears));
          unitList.add(commercials);
          break;
        case "Administrative offices and clinics":
          AdminClinics Admin = new AdminClinics(
              getunitID(id, unitsList[i].id),
              getAreaRange(unitsList[i].bua, type),
              type,
              unitsList[i].typeClinics,
              unitsList[i].typeOffice,
              unitsList[i].delivery,
              unitsList[i].finish ==""?finish:unitsList[i].finish,
              developer,
              loadPercent,
              location, subLocation,
              getMaintenance(maintanace, unitsList[i].price, unitsList[i].bua),
              paymentPlan,
              unitsList[i].cashDiscount,
              projectName,
              getPpmRange(unitsList[i].ppm),
              photo1,
              photo2,
              photo3,
              photo4,
              photo5,
              photo6,
              photo7,
              photo8,
              photo9,
              photo10,
              unitsList[i].floor,
              contactPerson1,
              phoneNumber1,
              contactPerson2,
              phoneNumber2,
              currentOffer,
              id,unitsList[i].instalmentYears,
              unitsList[i].price,
              getCashPrice(unitsList[i].cashDiscount, unitsList[i].price),
              unitsList[i].bua,
              unitsList[i].ppm,
              getinstallmentRange(unitsList[i].instalmentYears));
          unitList.add(Admin);
          break;
        case "Serviced Apartments":
          ServicedApartments serv = ServicedApartments(
              getunitID(id, unitsList[i].id),
              unitsList[i].bua,
              getAreaRange(unitsList[i].bua, type),
              unitsList[i].delivery,
              unitsList[i].finish,
              developer,
              loadPercent,
              location, subLocation,
              getMaintenance(maintanace, unitsList[i].price, unitsList[i].bua),
              paymentPlan,
              unitsList[i].cashDiscount,
              projectName,
              type,
              photo1,
              photo2,
              photo3,
              photo4,
              photo5,
              photo6,
              photo7,
              photo8,
              photo9,
              photo10,
              contactPerson1, phoneNumber1,
              contactPerson2, phoneNumber2,
              currentOffer, unitsList[i].projectID,
              unitsList[i].instalmentYears,
              unitsList[i].price,
              getCashPrice(unitsList[i].cashDiscount, unitsList[i].price),
              getinstallmentRange(unitsList[i].instalmentYears));
          unitList.add(serv);
          break;
        case "Villas":
          Villas villa = new Villas(
              getunitID(id, unitsList[i].id),
              getAreaRange(unitsList[i].bua, type),
              unitsList[i].landArea,
              getlandAreaRange(unitsList[i].landArea),
              unitsList[i].delivery,
              finish,
              developer,
              location,
              subLocation,
              getMaintenance(maintanace, unitsList[i].price, unitsList[i].bua),
              paymentPlan,
              unitsList[i].cashDiscount,
              projectName,
              unitsList[i].rooms,
              type, unitsList[i].villaType,
              photo1,
              photo2,
              photo3,
              photo4,
              photo5,
              photo6,
              photo7,
              photo8,
              photo9,
              photo10,
              contactPerson1,
              phoneNumber1,
              contactPerson2,
              phoneNumber2, currentOffer,
              id, unitsList[i].instalmentYears, unitsList[i].price,
              getCashPrice(unitsList[i].cashDiscount, unitsList[i].price),
              unitsList[i].bua,
              getinstallmentRange(unitsList[i].instalmentYears));
          unitList.add(villa);
          break;
        case "Chalets":
          Chalet chalet = new Chalet(
              getunitID(id, unitsList[i].id),
              unitsList[i].bua, getAreaRange(unitsList[i].bua, type),
              unitsList[i].delivery,
              finish,
              developer,
              unitsList[i].garden,
              getGardenBool(unitsList[i].garden),
              GetRoofBool(unitsList[i].floor),
              loadPercent,
              location,
              subLocation,
              getMaintenance(maintanace, unitsList[i].price, unitsList[i].bua),
              paymentPlan,
              unitsList[i].cashDiscount,
              projectName,
              type,
              photo1,
              photo2,
              photo3,
              photo4,
              photo5,
              photo6,
              photo7,
              photo8,
              photo9,
              photo10,
              unitsList[i].rooms, unitsList[i].price,
              getCashPrice(unitsList[i].cashDiscount, unitsList[i].price),
              unitsList[i].floor,
              phoneNumber1,
              contactPerson1,
              phoneNumber2,
              contactPerson2,
              currentOffer, id, unitsList[i].instalmentYears,
    getinstallmentRange(unitsList[i].instalmentYears));
          unitList.add(chalet);
          break;
        case "Apartments and Duplexes":
          Apartments apartments = new Apartments(
              getunitID(id, unitsList[i].id), 
              unitsList[i].bua,
              getAreaRange(unitsList[i].bua, type),
              unitsList[i].delivery,
              finish,
              developer, 
              unitsList[i].garden,
              getGardenBool(unitsList[i].garden),
              GetRoofBool(unitsList[i].floor),
              loadPercent, 
              location,
              getMaintenance(maintanace, unitsList[i].price, unitsList[i].bua),
              paymentPlan,
              unitsList[i].cashDiscount,
              projectName, 
              type, subLocation,
              unitsList[i].apartmentType,
              photo1,
              photo2,
              photo3,
              photo4,
              photo5,
              photo6,
              photo7,
              photo8,
              photo9,
              photo10,
              unitsList[i].rooms, 
              unitsList[i].price,
              getCashPrice(unitsList[i].cashDiscount, unitsList[i].price),
              unitsList[i].floor,
              phoneNumber1, contactPerson1, contactPerson2, phoneNumber2, currentOffer, 
              unitsList[i].ppm,
              id, unitsList[i].instalmentYears, getinstallmentRange(unitsList[i].instalmentYears),
              getPpmRange(unitsList[i].ppm));
          unitList.add(apartments);
      }
    }
    return unitList;
  }

  //done for All
  String getunitID(String projId, unitId) {
    String uID = "";

      String num = DateTime
          .now()
          .microsecondsSinceEpoch
          .toString();
      uID = projId.substring(0, 8) + num.substring(12);
    return uID;
  }

  //done for All
  String getAreaRange(bua, type) {

    String areaRange = "";
    switch(type){
      case "Commercials":
        if (bua < 30)
          areaRange = "Below 30 meter square";
        else if (bua < 60)
          areaRange = "30 meter square - 59 meter square";
        else if (bua < 101)
          areaRange = "60 meter square - 100 meter square";
        else
          areaRange = "above 100 meter square";
        break;
      case "Administrative offices and clinics":
        if (bua < 30)
          areaRange = "Below 30 meter square";
        else if (bua < 60)
          areaRange = "30 meter square - 59 meter square";
        else if (bua < 101)
          areaRange = "60 meter square - 100 meter square";
        else
          areaRange = "above 100 meter square";
        break;
      case "Chalets":
        if (bua < 90)
          areaRange = "Below 90 meter square";
        else if (bua < 120)
          areaRange = "90 meter - 119 meter";
        else if (bua < 160)
          areaRange = "120 meter - 159 meter";
        else if (bua <= 200)
          areaRange = "160 meter - 200 meter";
        else
          areaRange = "above 200 meter";
        break;
      case "Apartments and Duplexes":
        if (bua < 90)
          areaRange = "Below 90 meter square";
        else if (bua < 120)
          areaRange = "90 meter - 119 meter";
        else if (bua < 160)
          areaRange = "120 meter - 159 meter";
        else if (bua < 200)
          areaRange = "160 meter - 200 meter";
        else if (bua < 250)
          areaRange = "200 meter - 249 meter";
        else if (bua <= 300)
          areaRange = "250 meter - 300 meter";
        else
          areaRange = "above 300 meter square";
        break;
      case "Villas":
        if (bua < 200)
          areaRange = "Below 200 meter square";
        else if (bua < 300)
          areaRange = "200 meter - 299 meter";
        else if (bua < 400)
          areaRange = "300 meter - 399 meter";
        else if (bua < 500)
          areaRange = "400 meter - 499 meter";
        else if (bua <= 600)
          areaRange = "500 meter - 600 meter";
        else
          areaRange = "above 600 meter square";
        break;
      case "Serviced Apartments":
        if (bua < 30)
          areaRange = "Below 50 meter square";
        else if (bua < 60)
          areaRange = "50 meter - 99 meter";
        else if (bua < 101)
          areaRange = "100 meter - 150 meter";
        else
          areaRange = "above 150 meter square";
        break;
    }

    return areaRange;
  }

  //done for all
  String getMaintenance(String maintanace, price, bua) {
    final oCcy = new NumberFormat("#,###", "en_US");
    maintanace = maintanace.replaceAll(new RegExp(r'[^0-9]'), '');
    double main = double.parse(maintanace);
    late double main2;
    if (main < 30)
      main2 = (main / 100) * price;
    else
      main2 = main * bua;

    return oCcy.format(main2.round()).toString();
  }

  //done for all
  getCashPrice(cashDiscount, price) {
    double cashPrice;
    cashDiscount = cashDiscount.replaceAll(new RegExp(r'[^0-9]'), '');
    if (cashDiscount
        .toString()
        .isEmpty) {
      cashPrice = price;
    }
    else if (cashDiscount
        .toString()
        .length > 3) {
      cashDiscount = cashDiscount.toString().substring(0, 2);
      double cas = double.parse(cashDiscount);
      cashPrice = ((100 - cas) / 100) * price;
    }

    else {
      double cas = double.parse(cashDiscount);
      cashPrice = ((100 - cas) / 100) * price;
    }
    return cashPrice.round();
  }

  //done for all
  String getinstallmentRange(installment) {
    var InstRange;

    double year = double.parse(installment);
    if (year >= 9)
      InstRange = "more than 9 years";
    else if (year >= 7)
      InstRange = "more than 7 years";
    else if (year >= 5)
      InstRange = "more than 5 years";
    else if (year >= 3)
      InstRange = "more than 3 years";
    else
      InstRange = "less than 3 years";

    return InstRange;
  }

  //done for All
  String getPpmRange(ppm) {
    ppm = ppm.replaceAll(new RegExp(r'[^0-9]'), '');
    var ppmRange;
    double ppmr = double.parse(ppm);
    switch (type) {
      case "Commercials":
        if (ppmr < 30000)
          ppmRange = "Below 30,000/meter";
        else if (ppmr < 60000)
          ppmRange = "30,000/meter - 59,999/meter";
        else if (ppmr < 100000)
          ppmRange = "60,000/meter - 99,999/meter";
        else if (ppmr < 150000)
          ppmRange = "100,000/meter - 149,999/meter";
        else if (ppmr < 200000)
          ppmRange = "150,000/meter - 200,000/meter";
        else
          ppmRange = "Above 200,000/meter";
        break;
      case "Administrative offices and clinics":
        if (ppmr < 20000)
          ppmRange = "Below 20,000/meter";
        else if (ppmr <25000)
          ppmRange = "20,000/meter - 24,999/meter";
        else if (ppmr < 30000)
          ppmRange = "25,000/meter - 29,999/meter";
        else if (ppmr < 40000)
          ppmRange = "30,000/meter - 39,999/meter";
        else if (ppmr < 50000)
          ppmRange = "40,000/meter - 50,000/meter";
        else
          ppmRange = "Above 50,000/meter";
        break;
      case "Apartments and Duplexes":
        if (ppmr < 5000)
          ppmRange = "less than 5,000/Meter";
        else if (ppmr < 8000)
          ppmRange = "5,000/Meter - 7,999/Meter";
        else if (ppmr < 10000)
          ppmRange = "8,000/Meter - 9,999/Meter";
        else if (ppmr < 14000)
          ppmRange = "10,000/Meter - 13,999/Meter";
        else if (ppmr < 17000)
          ppmRange ="14,000/Meter - 16,999/Meter";
          else if (ppmr <= 20000)
          ppmRange ="17,000/Meter - 19,999/Meter";
          else
          ppmRange = "more than 20,000/Meter";
        break;
    }
    return ppmRange;
  }

  //done for com
  bool getOutDoorBool(outdoor) {
    bool outdo = false;
    if (double.parse(outdoor) > 0)
      outdo = true;

    return outdo;
  }

  getdelivery(String earliestDelivery) {
    DateTime now = DateTime.now();
    String xy = now.toString().substring(5, 7);
    int x = int.parse(xy);
    if (x > 8)
      x = 1;
    else
      x = 0;

      if (int.parse(earliestDelivery) < 0) {
        String year = DateTime.now().toString().substring(0, 4);
        String ret = "1/1/" + (int.parse(year)+x).toString();
        print(ret);
        return ret;
      }
      else {

        String yea = now.add(
            Duration(days: 366 * (int.parse(earliestDelivery) + x))).toString();

        String ret = "1/1/" + yea.substring(0, 4);
        print(ret);
        return ret;
      }
    }

  bool getGardenBool(garden) {
    bool x = false;
    int.parse(garden)>0?x = true:x = false;
    return x;
  }

  String getlandAreaRange(landArea) {
    String areaRange = "";
    if (landArea < 200)
      areaRange = "Below 200 meter square";
    else if (landArea < 400)
      areaRange = "200 meter - 399 meter";
    else if (landArea < 600)
      areaRange = "400 meter - 599 meter";
    else if (landArea <= 1000)
      areaRange = "600 meter - 1000 meter";
    else
      areaRange = "above 1000 meter";

    return areaRange;
  }

  bool GetRoofBool(floor) {
    bool x = false;
    floor == "Penthouse"? x = true: x = false;
    return x;
  }
  }

class subUnit {
  var projectID, id, bua,	ppm,	price,	floor,	outdoorArea, area,	cashDiscount,	subType,	delivery,	finish,	instalmentYears;
  var landArea, garden, typeOffice, typeClinics,rooms, apartmentType, villaType;
  subUnit(
      this.projectID,
      this.id,this.bua,
      this.delivery,
      this.ppm,
      this.price,
      this.floor,
      this.outdoorArea,
      this.area,
      this.cashDiscount,
      this.subType,
      this.finish,
      this.instalmentYears,
  this.landArea, this.garden, this.typeOffice, this.typeClinics,this.rooms, this.apartmentType, this.villaType
      );

  subUnit.a();
  fromMap(Map map)
  {
    map["projectID"] == null?this.projectID = "":this.projectID = map["projectID"];
    map["id"] == null?this.id = "":this.id = map["id"];
    map["bua"] == null?this.bua = "":this.bua = map["bua"];
    map["subType"] == null?this.subType = "":this.subType = map["subType"];
    map["delivery"] == null?this.delivery = "":this.delivery = map["delivery"].toString();
    map["finish"] == null?this.finish = "":this.finish = map["finish"];
    map["cashDiscount"] == null?this.cashDiscount = "":this.cashDiscount = map["cashDiscount"].toString();
    map["ppm"] == null?this.ppm = "":this.ppm = map["ppm"];
    map["outdoorArea"] == null?this.outdoorArea = "":this.outdoorArea = map["outdoorArea"];
    map["floor"] == null?this.floor = "":this.floor = map["floor"];
    map["price"] == null?this.price = "":this.price = map["price"];
    map["instalmentYears"] == null?this.instalmentYears = "":this.instalmentYears = map["instalmentYears"];
    map["landArea"] == null?this.landArea = "":this.landArea =map["landArea"];
    map["garden"] == null?this.garden = "":this.garden =map["garden"];
    map["typeOffice"] == null?this.typeOffice="":this.typeOffice =map["typeOffice"];
    map["typeClinics"] == null?this.typeClinics="":this.typeClinics =map["typeClinics"];
    map["rooms"] == null?this.rooms = "":this.rooms =map["rooms"];
    map["apartmentType"] == null? this.apartmentType = "":this.apartmentType =map["apartmentType"];
    map["villaType"] == null?this.villaType = "":this.villaType =map["villaType"];
  }
}