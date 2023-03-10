import 'package:redwinners/engines/prevelant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class values{
//region list


static List<String> locationEnglish = ["New Cairo", "October and Zayed", "New Capital", "North Coast"
    , "El Sokhna", "El Shrouk", "EL Mostakbl City", "El Obour City","Misr El Gdeda","Nasr City","Alexandria","PortSaid","ElMenia", "Marsa Matrouh","Sharm ElSheikh"];
  static List<String> subLocationNewCapitalEnglish = ["All","DownTown", "R7", "R8", "R3"
    , "MU23", "CBD (Central Business Distrect)","Government and financial district"];
  static List<String> subLocationNewCairoEnglish = ["All","Golden Square", "5th Settlemnts"];
  static List<String> subLocationOctoberZayedEnglish= ["All","Sheikh Zayed", "New Zayed", "October City","Hadayek October"];
  static List<String> subLocationNorthCoastEnglish = ["All","Al Alamin", "Old Coast", "New Coast"];
  static List<String> subLocationElSokhnaEnglish = ["All","El Sokhna", "El Galala"];
  static List<String> subLocationElShroukEnglish = ["All"];
  static List<String> subLocationElMostakblEnglish = ["All"];
  static List<String> typeEnglish = ["Apartments and Duplexes","Serviced Apartments"
    , "Villas", "Chalets", "Commercials", "Administrative offices and clinics"];
  static List<String> subTypeCommercialEnglish = ["All","Commercial","Pharmacy"];
  static List<String> subTypeAdminEnglish = ["All","Office","Clinic"];
  static List<String> yearsEnglish = ["All", "more than 9 years", "more than 7 years", "more than 5 years", "more than 3 years"
    , "less than 3 years"];
  static List<String> ppmEnglish = ["All", "less than 5,000/Meter","5,000/Meter - 7,999/Meter","8,000/Meter - 9,999/Meter", ""
      "10,000/Meter - 13,999/Meter", "14,000/Meter - 16,999/Meter", "17,000/Meter - 19,999/Meter", "more than 20,000/Meter"];
  static List<String> roomsNoEnglish = ["All","1","2","3","4","5","more than 5 rooms"];
  static List<String> roomsVillaNoEnglish = ["All","3","4","5","6","more than 6 rooms"];
  static List<String> roomsChaletNoEnglish = ["All","1","2","3","more than 3 rooms"];
  static List<String> deliveredInEnglish =["All", "Immediate Delivery" , "1 year", "2 years", "3 years", "4 years"];
  static List<String> finishEnglish =["All", "Core and Shell", "Semi Finished", "Fully Finished", "Fully Finished with facilities"];
  static List<String> apartmentsPriceEnglish =["All", "500K - 2 Millions", "2 Millions - 4 Millions", "Above 4 Millions"];
  static List<String> villaPriceEnglish =["All", "2 Millions - 5 Millions", "5 Millions - 8 Millions", "8 Millions - 11 Millions"
    ,"11 Millions - 15 Millions","Above 15 Millions"];
  static List<String> villaBUAEnglish =["All", "Below 200 meter square", "200 meter - 299 meter","300 meter - 399 meter",
    "400 meter - 499 meter","500 meter - 599 meter", "above 600 meter square"];
  static List<String> pricePerMeterComEnglish =["All", "Below 30,000/meter", "30,000/meter - 59,999/meter", "60,000/meter - 99,999/meter",
    "100,000/meter - 149,999/meter", "150,000/meter - 200,000/meter",
    "Above 200,000/meter"];
  static List<String> floorCommercialEnglish =["All", "Ground", "First", "Second", "Above Second"];
  static List<String> floorApartmentEnglish =["All", "Ground", "Typical", "Penthouse"];
//static List<String> apartmentType = retApartmentType();
  static List<String> apartmentTypeEnglish = ["All", "Apartment", "Duplex"];
  static List<String> pricePerMeterAdminEnglish =["All", "Below 20,000/meter",
    "20,000/meter - 24,999/meter", "25,000/meter - 29,999/meter", "30,000/meter - 39,999/meter", "40,000/meter - 50,000/meter",
    "Above 50,000/meter"];
  static List<String> areaAdminEnglish =["All", "Below 30 meter square", "30 meter square - 59 meter square",
    "60 meter square - 100 meter square", "above 100 meter square"];
  static List<String> areaCommercialEnglish =["All", "Below 30 meter square", "30 meter square - 59 meter square",
    "60 meter square - 100 meter square", "above 100 meter square"];
  static List<String> yesNoEnglish =["All", "Yes", "No"];
  static List<String> areaApartmentEnglish =["All", "Below 90 meter square", "90 meter - 119 meter",
    "120 meter - 159 meter", "160 meter - 199 meter","200 meter - 249 meter", "250 meter - 299 meter", "above 300 meter square"];
  static List<String> areaChaletEnglish =["All", "Below 90 meter square", "90 meter - 119 meter",
    "120 meter - 159 meter", "160 meter - 199 meter","above 200 meter square"];
  static List<String> landAreaEnglish =["All", "Below 200 meter square", "200 meter - 399 meter",
    "400 meter - 599 meter", "600 meter - 1000 meter","above 1000 meter square"];
  static List<String> serviceAreaEnglish =["All", "Below 50 meter square", "50 meter - 99 meter",
    "100 meter - 150 meter", "above 150 meter square"];
  static List<String> typeVillaEnglish =["All", "Town House", "Twin House", "Stand Alone"];
  static List<String> usersCountEnglish = ["20","50","100","150"];
//endregion
//region Arabiclist
  static List<String> locationArabic = ["?????????????? ??????????????", "???????????? ??????????", "?????????????? ???????????????? ??????????????", "???????????? ??????????????"
    , "????????????", "????????????", "?????????? ????????????????", "?????????? ????????????","?????? ??????????????","?????????? ??????","????????????????????","??????????????","????????????", "???????? ??????????","?????? ??????????"];
  static List<String> subLocationNewCapitalArabic =["????????","???????????? ????????", "R7", "R8", "R3"
    , "MU23", "?????????????? ????????????????","???? ???????????????? ???????????? ????????????????" ];
  static List<String> subLocationNewCairoArabic = ["????????","?????????????? ??????????", "???????????? ????????????"];
  static List<String> subLocationOctoberZayedArabic= ["????????","?????????? ????????", "???????? ??????????????", "?????????? ????????????"];
  static List<String> subLocationNorthCoastArabic = ["????????","????????????????", "???????????? ????????????", "???????????? ????????????"];
  static List<String> subLocationElSokhnaArabic = ["????????","????????????", "??????????????"];
  static List<String> subLocationElShroukArabic = ["????????"];
  static List<String> subLocationElMostakblArabic = ["????????"];
  static List<String> typeArabic = ["?????? ??????????????????","?????? ????????????"
    , "??????????", "??????????????", "?????????? ????????????", "?????????? ???????????? ??????????????"];
  static List<String> subTypeCommercialArabic = ["????????","??????????","????????????"];
  static List<String> subTypeAdminArabic = ["????????","????????","??????????"];
  static List<String> yearsArabic = ["????????", "???????? ???? 9 ????????", "???????? ???? 7 ????????", "???????? ???? 5 ????????", "???????? ???? 3 ????????"
    , "?????? ???? 3 ????????"];
  static List<String> ppmArabic = ["????????", "?????? ???? 5,000/??????????","5,000/?????????? - 7,999/??????????","8,000/?????????? - 9,999/??????????",
      "10,000/?????????? - 13,999/??????????", "14,000/?????????? - 16,999/??????????", "17,000/?????????? - 19,999/??????????", "???????? ???? 20,000/??????????"];
  static List<String> roomsNoArabic = ["????????","1","2","3","4","5","???????? ???? 5 ??????"];
  static List<String> roomsVillaNoArabic = ["????????","3","4","5","6","???????? ???? 6 ??????"];
  static List<String> roomsChaletNoArabic = ["????????","1","2","3","???????? ???? 6 ??????"];
  static List<String> deliveredInArabic =["????????", "???????????? ????????" , "?????? ??????????", "??????????", "3 ????????", "4 ????????"];
  static List<String> finishArabic =["????????", "?????? ????????", "???? ??????????", "??????????", "?????????? ??????????????"];
  static List<String> apartmentsPriceArabic =["????????", "500 ?????? - 2 ??????????", "2 ?????????? - 4 ??????????", "???????? ???? 4 ????????????"];
  static List<String> villaPriceArabic =["????????", "2 ?????????? - 5 ??????????", "5 ?????????? - 8 ??????????", "8 ?????????? - 11 ??????????"
    ,"11 ?????????? - 15 ??????????","???????? ???? 15 ??????????"];
  static List<String> villaBUAArabic =["????????", "?????? ???? 200 ??????", "200 ?????? - 299 ??????","300 ?????? - 399 ??????",
    "400 ?????? - 499 ??????","500 ?????? - 599 ??????", "???????? ???? 600 ??????"];
  static List<String> pricePerMeterComArabic =["????????", "?????? ???? 30,000/??????????", "30,000/?????????? - 59,999/??????????", "60,000/?????????? - 99,999/??????????",
    "100,000/?????????? - 149,999/??????????", "150,000/?????????? - 200,000/??????????",
    "Above 200,000/meter"];
  static List<String> floorCommercialArabic =["????????", "????????", "??????", "????????", "???????? ???? ?????????? ????????????"];
  static List<String> floorApartmentArabic =["????????", "????????", "??????????", "??????????????"];
//static List<String> apartmentType = retApartmentType();
  static List<String> apartmentTypeArabic = ["????????", "??????", "????????????"];
  static List<String> pricePerMeterAdminArabic =["????????", "?????? ???? 20,000/??????????",
    "20,000?????????? - 24,999/??????????", "25,000?????????? - 29,999/??????????", "30,000?????????? - 39,999/??????????", "40,000?????????? - 50,000/??????????",
    "Above 50,000/meter"];
  static List<String> areaAdminArabic =["????????", "?????? ???? 30 ??????", "30 ?????? - 59 ??????",
    "60 ?????? - 100 ??????", "???????? ???? 100 ??????"];
  static List<String> areaCommercialArabic =["????????", "?????? ???? 30 ??????", "30 ?????? - 59 ??????",
    "60 ?????? - 100 ??????", "???????? ???? 100 ??????"];
  static List<String> yesNoArabic =["????????", "??????", "????"];
  static List<String> areaApartmentArabic =["????????","?????? ???? 90 ??????", "90 ?????? - 119 ??????",
    "120 ?????? - 159 ??????","160 ?????? - 199 ??????","249 ?????? - 200 ??????","250 ?????? - 300 ??????","???????? ???? 300 ??????"];
  static List<String> areaChaletArabic =["????????","?????? ???? 90 ??????", "90 ?????? - 119 ??????",
    "120 ?????? - 159 ??????","160 ?????? - 199 ??????","???????? ???? 200 ??????"];
  static List<String> landAreaArabic =["????????","?????? ???? 200 ??????", "200 ?????? - 399 ??????",
    "400 ?????? - 599 ??????","600 ?????? - 1000 ??????","???????? ???? 1000 ??????"];
  static List<String> serviceAreaArabic =["????????", "?????? ???? 50 ??????", "50 ?????? - 99 ??????",
    "100 ?????? - 150 ??????", "???????? ???? 150 ??????"];
  static List<String> typeVillaArabic =["????????", "???????? ????????", "???????? ????????", "???????? ????????????"];

//endregion
String _redwinners = "redwinners";

static List<List<String>> allValues=[locationEnglish, subLocationNewCapitalEnglish, subLocationNewCairoEnglish,subLocationOctoberZayedEnglish,subLocationNorthCoastEnglish,subLocationElSokhnaEnglish,subLocationElShroukEnglish
  ,subLocationElMostakblEnglish,typeEnglish,subTypeCommercialEnglish,
  subTypeAdminEnglish,yearsEnglish,ppmEnglish,roomsNoEnglish,roomsVillaNoEnglish,roomsChaletNoEnglish,deliveredInEnglish,finishEnglish,apartmentsPriceEnglish,villaPriceEnglish,villaBUAEnglish,pricePerMeterComEnglish
  , floorCommercialEnglish,floorApartmentEnglish,apartmentTypeEnglish,pricePerMeterAdminEnglish,areaAdminEnglish,
  areaCommercialEnglish,yesNoEnglish,areaApartmentEnglish,areaChaletEnglish,landAreaEnglish,serviceAreaEnglish,typeVillaEnglish,usersCountEnglish,
  locationArabic, subLocationNewCapitalArabic, subLocationNewCairoArabic,subLocationOctoberZayedArabic,
  subLocationNorthCoastArabic,subLocationElSokhnaArabic,subLocationElShroukArabic
  ,subLocationElMostakblArabic,typeArabic,subTypeCommercialArabic,
  subTypeAdminArabic,yearsArabic,ppmArabic,roomsNoArabic,roomsVillaNoArabic,roomsChaletNoArabic,deliveredInArabic,
  finishArabic,apartmentsPriceArabic,villaPriceArabic,villaBUAArabic,pricePerMeterComArabic
  , floorCommercialArabic,floorApartmentArabic,apartmentTypeArabic,pricePerMeterAdminArabic,areaAdminArabic,
  areaCommercialArabic,yesNoArabic,areaApartmentArabic,areaChaletArabic,landAreaArabic,serviceAreaArabic,
  typeVillaArabic];

static List<String> allValuesNames = ["locationEnglish", "subLocationNewCapitalEnglish", "subLocationNewCairoEnglish",
  "subLocationOctoberZayedEnglish","subLocationNorthCoastEnglish","subLocationElSokhnaEnglish","subLocationElShroukEnglish"
  ,"subLocationElMostakblEnglish","typeEnglish","subTypeCommercialEnglish", "subTypeAdminEnglish",
  "yearsEnglish","ppmEnglish","roomsNoEnglish","roomsVillaNoEnglish",  "roomsChaletNoEnglish","deliveredInEnglish",
  "finishEnglish","apartmentsPriceEnglish","villaPriceEnglish","villaBUAEnglish","pricePerMeterComEnglish"
  , "floorCommercialEnglish","floorApartmentEnglish","apartmentTypeEnglish","pricePerMeterAdminEnglish",
  "areaAdminEnglish",  "areaCommercialEnglish","yesNoEnglish","areaApartmentEnglish","areaChaletEnglish",
  "landAreaEnglish","serviceAreaEnglish","typeVillaEnglish","usersCountEnglish",  "locationArabic",
  "subLocationNewCapitalArabic", "subLocationNewCairoArabic","subLocationOctoberZayedArabic",
  "subLocationNorthCoastArabic","subLocationElSokhnaArabic","subLocationElShroukArabic","subLocationElMostakblArabic",
  "typeArabic","subTypeCommercialArabic",  "subTypeAdminArabic","yearsArabic","ppmArabic","roomsNoArabic",
  "roomsVillaNoArabic","roomsChaletNoArabic","deliveredInArabic",  "finishArabic","apartmentsPriceArabic",
  "villaPriceArabic","villaBUAArabic","pricePerMeterComArabic" , "floorCommercialArabic","floorApartmentArabic",
  "apartmentTypeArabic","pricePerMeterAdminArabic",'areaAdminArabic',  "areaCommercialArabic","yesNoArabic",
  'areaApartmentArabic',"areaChaletArabic","landAreaArabic","serviceAreaArabic","typeVillaArabic"];

  static List<String> expire = ["1 week","1 month", "3 months","6 months","12 months"];

  static List<String> location(){
    if(Prevalent.local == 'en'){
      return locationEnglish;
    }
    else {
      return locationArabic;
    }

  }
  static List<String> subLocationNewCapital(){
    if(Prevalent.local == 'en'){
      return subLocationNewCapitalEnglish;
    }
    else {
      return subLocationNewCapitalArabic;
    }

  }
  static List<String> subLocationNewCairo(){
    if(Prevalent.local == 'en'){
      return subLocationNewCairoEnglish;
    }
    else {
      return subLocationNewCairoArabic;
    }

  }
  static List<String> subLocationOctoberZayed(){
    if(Prevalent.local == 'en'){
      return subLocationOctoberZayedEnglish;
    }
    else {
      return subLocationOctoberZayedArabic;
    }

  }
  static List<String> subLocationNorthCoast(){
    if(Prevalent.local == 'en'){
      return subLocationNorthCoastEnglish;
    }
    else {
      return subLocationNorthCoastArabic;
    }

  }
  static List<String> subLocationElSokhna(){
    if(Prevalent.local == 'en'){
      return subLocationElSokhnaEnglish;
    }
    else {
      return subLocationElSokhnaArabic;
    }

  }
  static List<String> subLocationElShrouk(){
    if(Prevalent.local == 'en'){
      return subLocationElShroukEnglish;
    }
    else {
      return subLocationElShroukArabic;
    }

  }
  static List<String> subLocationElMostakbl(){
    if(Prevalent.local == 'en'){
      return subLocationElMostakblEnglish;
    }
    else {
      return subLocationElMostakblArabic;
    }

  }
  static List<String> type(){
    if(Prevalent.local == 'en'){
      return typeEnglish;
    }
    else {
      return typeArabic;
    }

  }
  static List<String> subTypeCommercial(){
    if(Prevalent.local == 'en'){
      return subTypeCommercialEnglish;
    }
    else {
      return subTypeCommercialArabic;
    }

  }
  static List<String> subTypeAdmin(){
    if(Prevalent.local == 'en'){
      return subTypeAdminEnglish;
    }
    else {
      return subTypeAdminArabic;
    }

  }
  static List<String> years(){
    if(Prevalent.local == 'en'){
      return yearsEnglish;
    }
    else {
      return yearsArabic;
    }

  }
  static List<String> ppm(){
    if(Prevalent.local == 'en'){
      return ppmEnglish;
    }
    else {
      return ppmArabic;
    }

  }
  static List<String> roomsNo(){
    if(Prevalent.local == 'en'){
      return roomsNoEnglish;
    }
    else {
      return roomsNoArabic;
    }

  }
  static List<String> roomsVillaNo(){
    if(Prevalent.local == 'en'){
      return roomsVillaNoEnglish;
    }
    else {
      return roomsVillaNoArabic;
    }

  }
  static List<String> roomsChaletNo(){
    if(Prevalent.local == 'en'){
      return roomsChaletNoEnglish;
    }
    else {
      return roomsChaletNoArabic;
    }

  }
  static List<String> deliveredIn(){
    if(Prevalent.local == 'en'){
      return deliveredInEnglish;
    }
    else {
      return deliveredInArabic;
    }

  }
  static List<String> finish(){
    if(Prevalent.local == 'en'){
      return finishEnglish;
    }
    else {
      return finishArabic;
    }

  }
  static List<String> apartmentsPrice(){
    if(Prevalent.local == 'en'){
      return apartmentsPriceEnglish;
    }
    else {
      return apartmentsPriceArabic;
    }

  }
  static List<String> villaPrice(){
    if(Prevalent.local == 'en'){
      return villaPriceEnglish;
    }
    else {
      return villaPriceArabic;
    }

  }
  static List<String> villaBUA(){
    if(Prevalent.local == 'en'){
      return villaBUAEnglish;
    }
    else {
      return villaBUAArabic;
    }

  }
  static List<String> pricePerMeterCom(){
    if(Prevalent.local == 'en'){
      return pricePerMeterComEnglish;
    }
    else {
      return pricePerMeterComArabic;
    }

  }
  static List<String> floorCommercial(){
    if(Prevalent.local == 'en'){
      return floorCommercialEnglish;
    }
    else {
      return floorCommercialArabic;
    }

  }
  static List<String> floorApartment(){
    if(Prevalent.local == 'en'){
      return floorApartmentEnglish;
    }
    else {
      return floorApartmentArabic;
    }

  }
  static List<String> apartmentType(){
    if(Prevalent.local == 'en'){
      return apartmentTypeEnglish;
    }
    else {
      return apartmentTypeArabic;
    }

  }
  static List<String> pricePerMeterAdmin(){
    if(Prevalent.local == 'en'){
      return pricePerMeterAdminEnglish;
    }
    else {
      return pricePerMeterAdminArabic;
    }

  }
  static List<String> areaAdmin(){
    if(Prevalent.local == 'en'){
      return areaAdminEnglish;
    }
    else {
      return areaAdminArabic;
    }

  }
  static List<String> areaCommercial(){
    if(Prevalent.local == 'en'){
      return areaCommercialEnglish;
    }
    else {
      return areaCommercialArabic;
    }

  }
  static List<String> yesNo(){
    if(Prevalent.local == 'en'){
      return yesNoEnglish;
    }
    else {
      return yesNoArabic;
    }

  }
  static List<String> areaApartment(){
    if(Prevalent.local == 'en'){
      return areaApartmentEnglish;
    }
    else {
      return areaApartmentArabic;
    }

  }
  static List<String> areaChalet(){
    if(Prevalent.local == 'en'){
      return areaChaletEnglish;
    }
    else {
      return areaChaletArabic;
    }

  }
  static List<String> landArea(){
    if(Prevalent.local == 'en'){
      return landAreaEnglish;
    }
    else {
      return landAreaArabic;
    }

  }
  static List<String> serviceArea(){
    if(Prevalent.local == 'en'){
      return serviceAreaEnglish;
    }
    else {
      return serviceAreaArabic;
    }

  }
  static List<String> typeVilla(){
    if(Prevalent.local == 'en'){
      return typeVillaArabic;
    }
    else {
      return typeVillaArabic;
    }

  }
String get redwinners => _redwinners;

values();

set redwinners(String value) {
  _redwinners = value;
}


//region translators
  static String translatePaymentSearch(value) {
    String ret = "";
    if (Prevalent.local == "en"){
      print("Local" +Prevalent.local);
      return value;}
    if(value == "??????")
      ret = "Cash";
    else{
      ret = "Installments";
    }


    return ret;
  }
  static String translateLocation(value) {
  List<String> list = location();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.locationEnglish[i];
    }
    return ret;
  }
  static String translatesubLocation(String value, String locat){
    String sublo = "All";


    switch(locat)
    {
      case "New Cairo":
        sublo = translatesubLocationNewCairo(value);
        break;
      case "October and Zayed":
        sublo = translatesubLocationOctoberZayed(value);
        break;
      case "New Capital":
        sublo = translatesubLocationNewCapital(value);
        break;
      case "North Coast":
        sublo = translatesubLocationNorthCoast(value);
        break;
      case "El Sokhna":
        sublo = translatesubLocationElSokhna(value);
        break;
      default:
        sublo = "All";
        break;

    }
    return sublo;

  }
  static String translatetype(String value) {
    List<String> list = type();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.typeEnglish[i];
    }
    return ret;
  }
  static String translatesubTypeCommercial(String value) {
    List<String> list = subTypeCommercial();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.subTypeCommercialEnglish[i];
    }
    return ret;
  }
  static String translatesubTypeAdmin(String value) {
    List<String> list = subTypeAdmin();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.subTypeAdminEnglish[i];
    }
    return ret;
  }
  static String translateyears(String value) {
    List<String> list = years();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.yearsEnglish[i];
    }
    return ret;
  }
  static String translateppm(String value) {
    List<String> list = ppm();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.ppmEnglish[i];
    }
    return ret;
  }
  static String translateroomsNo(String value) {
    List<String> list = roomsNo();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.roomsNoEnglish[i];
    }
    return ret;
  }
  static String translateroomsVillaNo(String value) {
    List<String> list = roomsVillaNo();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.roomsVillaNoEnglish[i];
    }
    return ret;
  }
  static String translateroomsChaletNo(String value) {
    List<String> list = roomsChaletNo();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.roomsChaletNoEnglish[i];
    }
    return ret;
  }
  static String translatedelivery(String value) {
    List<String> list = deliveredIn();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.deliveredInEnglish[i];
    }
    return ret;
  }
  static String translatefinish(String value) {
    List<String> list = finish();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.finishEnglish[i];
    }
    return ret;
  }
  static String translateapartmentsPrice(String value) {
    List<String> list = apartmentsPrice();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.apartmentsPriceEnglish[i];
    }
    return ret;
  }
  static String translatevillaPrice(String value) {
    List<String> list = villaPrice();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.villaPriceEnglish[i];
    }
    return ret;
  }
  static String translatevillaBUA(String value) {
    List<String> list = villaBUA();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.villaBUAEnglish[i];
    }
    return ret;
  }
  static String translatpricePerMeterCom(String value) {
    List<String> list = pricePerMeterCom();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.pricePerMeterComEnglish[i];
    }
    return ret;
  }
  static String translatefloorCommercial(String value) {
    List<String> list = floorCommercial();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.floorCommercialEnglish[i];
    }
    return ret;
  }
  static String translatefloorApartment(String value) {
    List<String> list = floorApartment();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.floorApartmentEnglish[i];
    }
    return ret;
  }
  static String translateapartmentType(String value) {
    List<String> list = apartmentType();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.apartmentTypeEnglish[i];
    }
    return ret;
  }
  static String translatepricePerMeterAdmin(String value) {
    List<String> list = pricePerMeterAdmin();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.pricePerMeterAdminEnglish[i];
    }
    return ret;
  }
  static String translateareaAdmin(String value) {
    List<String> list = areaAdmin();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.areaAdminEnglish[i];
    }
    return ret;
  }
  static String translateareaCommercial(String value) {
    List<String> list = areaCommercial();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.areaCommercialEnglish[i];
    }
    return ret;
  }
  static String translateyesNo(String value) {
    List<String> list = yesNo();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.yesNoEnglish[i];
    }
    return ret;
  }
  static String translateareaApartment(String value) {
    List<String> list = areaApartment();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.areaApartmentEnglish[i];
    }
    return ret;
  }
  static String translateareaChalet(String value) {
    List<String> list = areaChalet();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.areaChaletEnglish[i];
    }
    return ret;
  }
  static String translatelandArea(String value) {
    List<String> list = landArea();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.landAreaEnglish[i];
    }
    return ret;
  }
  static String translateserviceArea(String value) {
    List<String> list = serviceArea();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.serviceAreaEnglish[i];
    }
    return ret;
  }
  static String translatevillaType(String value) {
    List<String> list = typeVilla();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.typeVillaEnglish[i];
    }
    return ret;
  }
  static String translatesubLocationNewCapital(String value) {
    List<String> list = subLocationNewCapital();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.subLocationNewCapitalEnglish[i];
    }
    return ret;
  }
  static String translatesubLocationNewCairo(String value) {
    List<String> list = subLocationNewCairo();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.subLocationNewCairoEnglish[i];
    }
    return ret;
  }
  static String translatesubLocationOctoberZayed(String value) {
    List<String> list = subLocationOctoberZayed();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.subLocationOctoberZayedEnglish[i];
    }
    return ret;
  }
  static String translatesubLocationNorthCoast(String value) {
    List<String> list = subLocationNorthCoast();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.subLocationNorthCoastEnglish[i];
    }
    return ret;
  }
  static String translatesubLocationElSokhna(String value) {
    List<String> list = subLocationElSokhna();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.subLocationElSokhnaEnglish[i];
    }
    return ret;
  }
  static String translatesubLocationElShrouk(String value) {
    List<String> list = subLocationElShrouk();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.subLocationElShroukEnglish[i];
    }
    return ret;
  }
  static String translatesubLocationElMostakbl(String value) {
    List<String> list = subLocationElMostakbl();
    String ret = "All";
    for (int i = 0; i < list.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == list[i])
        ret = values.subLocationElMostakblEnglish[i];
    }
    return ret;
  }

  static String arabictranslateLocation(value) {
    if (Prevalent.local == "en"){
      print("Local" +Prevalent.local);
      return value;}

    String ret = "";
    for (int i = 0; i < locationEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == locationEnglish[i])
        ret = values.locationArabic[i];
    }
    return ret;
  }
  static String arabictranslatesubLocation(String value, String locat){
    if (Prevalent.local == "en")
      return value;
    String sublo = "";
    switch(locat)
    {
      case "New Cairo":
        sublo = arabictranslatesubLocationNewCairo(value);
        break;
      case "October and Zayed":
        sublo = arabictranslatesubLocationOctoberZayed(value);
        break;
      case "New Capital":
        sublo = arabictranslatesubLocationNewCapital(value);
        break;
      case "North Coast":
        sublo = arabictranslatesubLocationNorthCoast(value);
        break;
      case "El Sokhna":
        sublo = arabictranslatesubLocationElSokhna(value);
        break;
      default:
        sublo = "";
        break;

    }
    return sublo;

  }
  static String arabictranslatetype(String value) {
    if (Prevalent.local == "en")
      return value;
    String ret = "";
    for (int i = 0; i < typeEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == typeEnglish[i])
        ret = values.typeArabic[i];
    }
    return ret;
  }
  static String arabictranslatesubTypeCommercial(String value) {
    if (Prevalent.local == "en")
      return value;
    String ret = "";
    for (int i = 0; i < subTypeCommercialEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == subTypeCommercialEnglish[i])
        ret = values.subTypeCommercialArabic[i];
    }
    return ret;
  }
  static String arabictranslatesubTypeAdmin(String value) {

    if (Prevalent.local == "en")
      return value;
    String ret = "";
    for (int i = 0; i < subTypeAdminEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == subTypeAdminEnglish[i])
        ret = values.subTypeAdminArabic[i];
    }
    return ret;
  }
  static String arabictranslatefinish(String value) {
    if (Prevalent.local == "en")
      return value;
    String ret = "";
    for (int i = 0; i < finishEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == finishEnglish[i])
        ret = values.finishArabic[i];
    }
    return ret;
  }
  static String arabictranslatefloorCommercial(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < floorCommercialEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == floorCommercialEnglish[i])
        ret = values.floorCommercialArabic[i];
    }
    return ret;
  }
  static String arabictranslatefloorApartment(String value) {
    if (Prevalent.local == "en")
      return value;
    String ret = "";
    for (int i = 0; i < floorApartmentEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == floorApartmentEnglish[i])
        ret = values.floorApartmentArabic[i];
    }
    return ret;
  }
  static String arabictranslateapartmentType(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < apartmentTypeEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == apartmentTypeEnglish[i])
        ret = values.apartmentTypeArabic[i];
    }
    return ret;
  }

  static String arabictranslatevillaType(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < typeVillaEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == typeVillaEnglish[i])
        ret = values.typeVillaArabic[i];
    }
    return ret;
  }
  static String arabictranslatesubLocationNewCapital(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < subLocationNewCapitalEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == subLocationNewCapitalEnglish[i])
        ret = values.subLocationNewCapitalArabic[i];
    }
    return ret;
  }
  static String arabictranslatesubLocationNewCairo(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < subLocationNewCairoEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == subLocationNewCairoEnglish[i])
        ret = values.subLocationNewCairoArabic[i];
    }
    return ret;
  }
  static String arabictranslatesubLocationOctoberZayed(String value) {
    if (Prevalent.local == "en")
      return value;
    String ret = "";
    for (int i = 0; i < subLocationOctoberZayedEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == subLocationOctoberZayedEnglish[i])
        ret = values.subLocationOctoberZayedArabic[i];
    }
    return ret;
  }
  static String arabictranslatesubLocationNorthCoast(String value) {
    if (Prevalent.local == "en")
      return value;
    String ret = "";
    for (int i = 0; i < subLocationNorthCoastEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == subLocationNorthCoastEnglish[i])
        ret = values.subLocationNorthCoastArabic[i];
    }
    return ret;
  }
  static String arabictranslatesubLocationElSokhna(String value) {
    if (Prevalent.local == "en")
      return value;
  String ret = "";
    for (int i = 0; i < subLocationElSokhnaEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == subLocationElSokhnaEnglish[i])
        ret = values.subLocationElSokhnaArabic[i];
    }
    return ret;
  }
  static String arabictranslatesubLocationElShrouk(String value) {
    if (Prevalent.local == "en")
      return value;
    String ret = "";
    for (int i = 0; i < subLocationElShroukEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == subLocationElShroukEnglish[i])
        ret = values.subLocationElShroukArabic[i];
    }
    return ret;
  }
  static String arabictranslatesubLocationElMostakbl(String value) {
    if (Prevalent.local == "en")
      return value;
    String ret = "";
    for (int i = 0; i < subLocationElMostakblEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == subLocationElMostakblEnglish[i])
        ret = values.subLocationElMostakblArabic[i];
    }
    return ret;
  }

  static String arabictranslateyears(String value) {
    if (Prevalent.local == "en"){
      return value;}

    String ret = "";
    for (int i = 0; i < yearsEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == yearsEnglish[i])
        ret = values.yearsArabic[i];
    }
    return ret;
  }
  static String arabictranslateppm(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < ppmEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == ppmEnglish[i])
        ret = values.ppmArabic[i];
    }
    return ret;
  }
  static String arabictranslateroomsNo(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < roomsNoEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == roomsNoEnglish[i])
        ret = values.roomsNoArabic[i];
    }
    return ret;
  }
  static String arabictranslateroomsVillaNo(String value)  {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < roomsVillaNoEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == roomsVillaNoEnglish[i])
        ret = values.roomsVillaNoArabic[i];
    }
    return ret;
  }
  static String arabictranslateroomsChaletNo(String value)  {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < roomsChaletNoEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == roomsChaletNoEnglish[i])
        ret = values.roomsChaletNoArabic[i];
    }
    return ret;
  }
  static String arabictranslatedelivery(String value)  {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < deliveredInEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == deliveredInEnglish[i])
        ret = values.deliveredInArabic[i];
    }
    return ret;
  }

  static String arabictranslatevillaBUA(String value)  {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < villaBUAEnglish.length; i++){

      if(value == villaBUAEnglish[i])
        ret = values.villaBUAArabic[i];
    }
    return ret;
  }
  static String arabictranslatpricePerMeterCom(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < pricePerMeterComEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == pricePerMeterComEnglish[i])
        ret = values.pricePerMeterComArabic[i];
    }
    return ret;
  }
  static String arabictranslatepricePerMeterAdmin(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < pricePerMeterAdminEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == pricePerMeterAdminEnglish[i])
        ret = values.pricePerMeterAdminArabic[i];
    }
    return ret;
  }
  static String arabictranslateareaAdmin(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < areaAdminEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == areaAdminEnglish[i])
        ret = values.areaAdminArabic[i];
    }
    return ret;
  }
  static String arabictranslateareaCommercial(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < areaCommercialEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == areaCommercialEnglish[i])
        ret = values.areaCommercialArabic[i];
    }
    return ret;
  }
  static String arabictranslateyesNo(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < yesNoEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == yesNoEnglish[i])
        ret = values.yesNoArabic[i];
    }
    return ret;
  }
  static String arabictranslateareaApartment(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < areaApartmentEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == areaApartmentEnglish[i])
        ret = values.areaApartmentArabic[i];
    }
    return ret;
  }
  static String arabictranslateareaChalet(String value)  {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < areaChaletEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == areaChaletEnglish[i])
        ret = values.areaChaletArabic[i];
    }
    return ret;
  }
  static String arabictranslatelandArea(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < landAreaEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == landAreaEnglish[i])
        ret = values.landAreaArabic[i];
    }
    return ret;
  }
  static String arabictranslateserviceArea(String value) {
    if (Prevalent.local == "en")
      return value;

    String ret = "";
    for (int i = 0; i < serviceAreaEnglish.length; i++){
      // print("intake " + apartmentType);
      // print("intake " + apartmentType);
      if(value == serviceAreaEnglish[i])
        ret = values.serviceAreaArabic[i];
    }
    return ret;
  }


//endregion

}
