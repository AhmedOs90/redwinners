import 'package:redwinners/Model/Units.dart';
import 'package:redwinners/Model/Requests.dart';
import 'package:redwinners/Model/values.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/UI/unitFilter.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'ErrorServerPage.dart';
import 'Loading.dart';
import 'package:intl/intl.dart';
import 'UnitView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnitList extends StatefulWidget {
late String Path;
late Requests Specs;
String Origin;

UnitList(this.Path, this.Specs, this.Origin);

@override
  _unitListState createState() => _unitListState(this.Path, this.Specs, this.Origin);
}

class _unitListState extends State<UnitList> {
  final oCcy = new NumberFormat("#,###", "en_US");
  late String path;
  String origin;
  late Requests specs;
  late Query query;
  late String areaRange;
  List<Apartments> appUnits= [];
  List<Villas> villaUnits= [];
  List<Chalet> chaletUnits= [];
  List<ServicedApartments> servUnits= [];
  List<Commercials> comUnits= [];
  List<AdminClinics> adminUnits= [];
  bool pricing = true;
  List<Unit> unilList = [];
  List<String> sorting1 = [ 'Price: low to high',
    'Price: high to low',
    ];
  List<String> sorting2 = [ "الاسعار: من الاقل إلى الأعلى سعرا",
    "الاسعار: من الاعلى إلى الأقل سعرا",
  ];

  String order = "1";

  _unitListState(this.path, this.specs, this.origin);


  @override
  Widget build(BuildContext context) {

    var loc = AppLocalizations.of(context);

    query = FirebaseFirestore.instance.collection(origin == "Staff"? path : specs.type + " units");


    query = FilterQuery(query, specs);


    //query = orderQuery(query);
    final Stream<QuerySnapshot> _projectsStream = query.snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: _projectsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return OpsError();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }


          unilList = getUnits(snapshot, specs);
          unilList = Sorting(unilList, order);

            return Scaffold(
              appBar: AppBar(
                leading: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Icon(Icons.arrow_back_ios, size: 20,),
                  ),
                  onTap: (){
                    Navigator.of(context).maybePop();
                  },
                ),
                backgroundColor: Colors.redAccent.shade700,

                actions: [
                    InkWell(
                      child:
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.filter_alt,),
                          ),

                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context) => UnitFilter(path, specs))).then((
                            value) => value ? set() : null);
                      },),


                  PopupMenuButton<String>(
                      icon:
                          //Text("Sort"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort,),
                          ),

                      onSelected: handleClick,
                      itemBuilder: (BuildContext context) {
                        return
                          sorting1.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                      }
                  ),
                ],
              ),
              body: unilList.length > 0 ? Container(
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: unilList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProjectCard(
                            unilList[index], context);
                      })
              ) : Center(
                child: Container(
                  child: Text(loc!.noResultsFound),
                ),
              ),
            );
        });
  }

  Widget ProjectCard(Unit unit,
      BuildContext context) {

    var loc = AppLocalizations.of(context);

    return InkWell(
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          // height: 120,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeInImage(
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                  image: NetworkImage(unit.image),
                  imageErrorBuilder: (context, exception,stackTrace) {
                    return Image(height: 120,
                      width: 120,
                      image: AssetImage("assets/ErrorImage.png"),);
                  },
                  placeholder: AssetImage("assets/Eclipse-1s-200px.gif"),

                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(loc!.iD+unit.id, textAlign: TextAlign.start,
                          style: Alltheme.textTheme.bodyText1,),
                        Text(oCcy.format(unit.price) +loc!.lE, textAlign: TextAlign.start),
                        Divider(thickness: 1.5, color: Colors.grey.shade500),
                        Text(unit.bua.toString() + loc!.m2, textAlign: TextAlign.start),
                        Text(values.arabictranslatefinish(unit.finish), textAlign: TextAlign.start),
                        Text(values.arabictranslatetype(unit.type),
                            textAlign: TextAlign.start),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder:
              (context) => UnitView(specs.type + " units", unit.id, specs.type)));
        }
    );
  }

  Query<Object?> FilterQuery(Query<Object?> query, Requests requests) {
    if(origin == "Staff")
      {
        return query;
      }
    query = query.where("projectID", isEqualTo: path);
    switch (requests.type) {
      case "":
        return query;
      case "Apartments and Duplexes":
      //region Apartments
        print(requests.type);
        print(requests.location);
        print(requests.subLocation);
        print(requests.apArea);
        print(requests.apPPm);
        print(requests.apFloor);
        print(requests.aptype);
        print(requests.apRooms);
        print(requests.delivery);
        print(requests.finish);


        if (requests.apArea != "All") {
          query = query.where("areaRange", isEqualTo: requests.apArea);
        }
        if(requests.apPPm != "All") {
            query = query.where("ppmRange", isEqualTo: requests.apPPm);
          }
        if (requests.apFloor != "All") {
          query = query.where("floor", isEqualTo: requests.apFloor);
        }
        if (requests.aptype != "All") {
          query = query.where("apartmentType", isEqualTo: requests.aptype);
        }
        if (requests.apRooms != "All") {
          query = query.where("rooms", isEqualTo: requests.apRooms);
        }
        if (requests.delivery != "All") {
          query = query.where("delivery", isEqualTo: requests.delivery);
        }
        if (requests.finish != "All") {
          query = query.where("finish",whereIn: requests.finish== "Fully Finished"?["Fully Finished","Fully Finished with facilities" ]:[requests.finish]);
        }
        break;
    //endregion
      case "Villas":
      //region Villas
        if (requests.viArea != "All") {
          query = query.where("areaRange", isEqualTo: requests.viArea);
        }
        if (requests.viLandArea != "All") {
          query = query.where("landAreaRange", isEqualTo: requests.viLandArea);
        }
        if (requests.viRooms != "All") {
          query = query.where("rooms", isEqualTo: requests.viRooms);
        }
        if (requests.viType != "All") {
          query = query.where("villaType", isEqualTo: requests.viType);
        }
        if (requests.delivery != "All") {
          query = query.where("delivery", isEqualTo: requests.delivery);
        }
        if (requests.finish != "All") {
          query = query.where("finish",whereIn: requests.finish== "Fully Finished"?["Fully Finished","Fully Finished with facilities" ]:[requests.finish]);
        }
        break;
    //endregion
      case "Serviced Apartments":
      //region Serviced Apartment
        if (requests.sAArea != "All") {
          query = query.where("areaRange", isEqualTo: requests.sAArea);
        }
        if (specs.delivery != "All") {
          query = query.where("delivery", isEqualTo: specs.delivery);
        }
        if (requests.finish != "All") {
          query = query.where("finish",whereIn: requests.finish== "Fully Finished"?["Fully Finished","Fully Finished with facilities" ]:[requests.finish]);
        }
        break;
    //endregion
      case "Chalets":
      //region Chalet
        if (requests.chArea != "All") {
          query = query.where("areaRange", isEqualTo: requests.chArea);
        }
        if (specs.chFloor != "All") {
          query = query.where("floor", isEqualTo: specs.chFloor);
        }
        if (specs.chRooms != "All") {

          query = query.where("rooms", isEqualTo: specs.chRooms);
        }
        if (specs.delivery != "All") {
          query = query.where("delivery", isEqualTo: specs.delivery);
        }
        if (requests.finish != "All") {
          query = query.where("finish",whereIn: requests.finish== "Fully Finished"?["Fully Finished","Fully Finished with facilities" ]:[requests.finish]);
        }
        return query;
    //endregion
      case "Commercials":
      //region Commercial
        if (requests.comArea != "All") {
          query = query.where("areaRange", isEqualTo: requests.comArea);
        }
        if (requests.comType != "All")
        {
          query = query.where("subType", isEqualTo: requests.comType);
        }
        if (requests.comFloor != "All") {
          query = query.where("floor", isEqualTo: requests.comFloor);
        }
        if (requests.comPPM != "All") {
          query = query.where("ppmRange", isEqualTo: requests.comPPM);
        }
        if (requests.comOutdoorsArea != "All"){
          if(requests.comOutdoorsArea == "Yes") {
            query = query.where("outDoorBool", isEqualTo: true);
          }
          if(requests.comOutdoorsArea == "No") {
            query = query.where("outDoorBool", isEqualTo: false);
          }
        }


        if (specs.delivery != "All") {
          query = query.where("delivery", isEqualTo: specs.delivery);
        }
        if (requests.finish != "All") {
          query = query.where("finish",whereIn: requests.finish== "Fully Finished"?["Fully Finished","Fully Finished with facilities" ]:[requests.finish]);
        }
        break;
    //endregion
      case "Administrative offices and clinics":
      // region Admin
        if (requests.adminArea != "All") {
          query = query.where("areaRange", isEqualTo: requests.adminArea);
        }
        if (requests.adminType != "All") {
          if (requests.adminType == "Office")
        {  query = query.where("typeOffice", isEqualTo: true);}
          if (requests.adminType == "Clinic")
          {  query = query.where("typeClinics", isEqualTo: true);}
        }

        if (requests.adminPPM != "All") {
          query = query.where("ppmRange", isEqualTo: requests.adminPPM);
        }


        if (specs.delivery != "All") {
          query = query.where("delivery", isEqualTo: specs.delivery);
        }
        if (requests.finish != "All") {
          query = query.where("finish",whereIn: requests.finish== "Fully Finished"?["Fully Finished","Fully Finished with facilities" ]:[requests.finish]);
        }
        break;
    //endregion
    }
    return query;
  }

  void handleClick(String value) {
    switch (value) {
      case 'Price: low to high':
        setState(() {
          order = "1";
        });
        break;
      case 'Price: high to low':
        setState(() {
          order = "2";
        });
        break;
      case "الاسعار: من الاقل إلى الأعلى سعرا":
        setState(() {
          order = "1";
        });
        break;
      case "الاسعار: من الاعلى إلى الأقل سعرا":
        setState(() {
          order = "2";
        });
        break;
      case 'Delivery: near to far':
        setState(() {
          order = "3";
        });
        break;
      case 'Delivery: far to near':
        setState(() {
          order = "4";
        });
        break;
    }
  }

  set() {
    setState(() {
      specs = Prevalent.request;
    });
  }



  List<Unit> getUnits(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, Requests specs)
  {

    List<Unit> units = [];
    if(specs.type == "Apartments and Duplexes") {

      for (int i = 0; i < snapshot.data!.docs.length; i++) {
        Map<String, dynamic>? data = snapshot.data!.docs[i].data() as Map<
            String,
            dynamic>?;
        Apartments apartment = new Apartments.a();
        apartment.fromMap(data!);
        if (specs.payment.paymentSearch == "Cash")
        {
          if (specs.payment.priceEnd != 0) {
              if (apartment.cashPrice < specs.payment.priceEnd &&
                  apartment.cashPrice > specs.payment.priceStart) {
                Unit unit = new Unit(
                    apartment.image0, apartment.id, apartment.price, apartment.bua,
                    apartment.finish, apartment.apartmentType);
                units.add(unit);
              }
          }
          else {
              if (apartment.cashPrice > specs.payment.priceStart) {
                Unit unit = new Unit(
                    apartment.image0, apartment.id, apartment.price, apartment.bua,
                    apartment.finish, apartment.apartmentType);
                units.add(unit);
            }
          }
        }
        else
        {
          if (specs.payment.priceEnd != 0) {
              if (apartment.price < specs.payment.priceEnd &&
                  apartment.price > specs.payment.priceStart)
                {
                  Unit unit = new Unit(
                      apartment.image0, apartment.id, apartment.price, apartment.bua,
                      apartment.finish, apartment.apartmentType);
                  units.add(unit);
            }
          }
          else {
              if (apartment.price > specs.payment.priceStart) {
                Unit unit = new Unit(
                    apartment.image0, apartment.id, apartment.price, apartment.bua,
                    apartment.finish, apartment.apartmentType);
                units.add(unit);
            }
          }
        }

      //  appUnits.add(apartment);
      }
    }
    if(specs.type == "Villas") {
      for (int i = 0; i < snapshot.data!.docs.length; i++) {
        Map<String, dynamic>? data = snapshot.data!.docs[i].data() as Map<
            String,
            dynamic>?;
        Villas villa = new Villas.a();
        villa.fromMap(data!);
        if (specs.payment.paymentSearch == "Cash")
        {
          if (specs.payment.priceEnd != 0) {
            if (villa.cashPrice < specs.payment.priceEnd &&
                villa.cashPrice > specs.payment.priceStart) {
              Unit unit = new Unit(
                  villa.image0, villa.id, villa.price, villa.bua,
                  villa.finish, villa.villaType);
              units.add(unit);
            }
          }
          else {
            if (villa.cashPrice > specs.payment.priceStart) {
              Unit unit = new Unit(
                  villa.image0, villa.id, villa.price, villa.bua,
                  villa.finish, villa.villaType);
              units.add(unit);
            }
          }
        }
        else
        {
          if (specs.payment.priceEnd != 0) {
            if (villa.price < specs.payment.priceEnd &&
                villa.price > specs.payment.priceStart)
            {
              Unit unit = new Unit(
                  villa.image0, villa.id, villa.price, villa.bua,
                  villa.finish, villa.villaType);
              units.add(unit);
            }
          }
          else {
            if (villa.price > specs.payment.priceStart) {
              Unit unit = new Unit(
                  villa.image0, villa.id, villa.price, villa.bua,
                  villa.finish, villa.villaType);
              units.add(unit);
            }
          }
        }
      }
    }
    if(specs.type == "Serviced Apartments") {
      for (int i = 0; i < snapshot.data!.docs.length; i++) {
        Map<String, dynamic>? data = snapshot.data!.docs[i].data() as Map<
            String,
            dynamic>?;
        ServicedApartments servicedApartments = new ServicedApartments.a();
        servicedApartments.fromMap(data!);
        if (specs.payment.paymentSearch == "Cash")
        {
          if (specs.payment.priceEnd != 0) {
            if (servicedApartments.cashPrice < specs.payment.priceEnd &&
                servicedApartments.cashPrice > specs.payment.priceStart) {
              Unit unit = new Unit(
                  servicedApartments.image0, servicedApartments.id, servicedApartments.price, servicedApartments.bua,
                  servicedApartments.finish, specs.type);
              units.add(unit);
            }
          }
          else {
            if (servicedApartments.cashPrice > specs.payment.priceStart) {
              Unit unit = new Unit(
                  servicedApartments.image0, servicedApartments.id, servicedApartments.price, servicedApartments.bua,
                  servicedApartments.finish, specs.type);
              units.add(unit);
            }
          }
        }
        else
        {
          if (specs.payment.priceEnd != 0) {
            if (servicedApartments.price < specs.payment.priceEnd &&
                servicedApartments.price > specs.payment.priceStart)
            {
              Unit unit = new Unit(
                  servicedApartments.image0, servicedApartments.id, servicedApartments.price, servicedApartments.bua,
                  servicedApartments.finish, specs.type);
              units.add(unit);
            }
          }
          else {
            if (servicedApartments.price > specs.payment.priceStart) {
              Unit unit = new Unit(
                  servicedApartments.image0, servicedApartments.id, servicedApartments.price, servicedApartments.bua,
                  servicedApartments.finish, specs.type);
              units.add(unit);
            }
          }
        }
      }

    }
    if(specs.type == "Chalets") {

      for (int i = 0; i < snapshot.data!.docs.length; i++) {
        Map<String, dynamic>? data = snapshot.data!.docs[i].data() as Map<
            String,
            dynamic>?;
        Chalet chalet = new Chalet.a();
        chalet.fromMap(data!);
        if (specs.payment.paymentSearch == "Cash")
        {
          if (specs.payment.priceEnd != 0) {
            if (chalet.cashPrice < specs.payment.priceEnd &&
                chalet.cashPrice > specs.payment.priceStart) {
              Unit unit = new Unit(
                  chalet.image0, chalet.id, chalet.price, chalet.bua,
                  chalet.finish, specs.type);
              units.add(unit);
            }
          }
          else {
            if (chalet.cashPrice > specs.payment.priceStart) {
              Unit unit = new Unit(
                  chalet.image0, chalet.id, chalet.price, chalet.bua,
                  chalet.finish, specs.type);
              units.add(unit);
            }
          }
        }
        else
        {
          if (specs.payment.priceEnd != 0) {
            if (chalet.price < specs.payment.priceEnd &&
                chalet.price > specs.payment.priceStart)
            {
              Unit unit = new Unit(
                  chalet.image0, chalet.id, chalet.price, chalet.bua,
                  chalet.finish, specs.type);
              units.add(unit);
            }
          }
          else {
            if (chalet.price > specs.payment.priceStart) {
              Unit unit = new Unit(
                  chalet.image0, chalet.id, chalet.price, chalet.bua,
                  chalet.finish, specs.type);
              units.add(unit);
            }
          }
        }
      }

    }
    if(specs.type == "Commercials") {
      for (int i = 0; i < snapshot.data!.docs.length; i++) {
        Map<String, dynamic>? data = snapshot.data!.docs[i].data() as Map<
            String,
            dynamic>?;
        Commercials commercials = new Commercials.a();
        commercials.fromMap(data!);
        if (specs.payment.paymentSearch == "Cash")
        {
          if (specs.payment.priceEnd != 0) {
            if (commercials.cashPrice < specs.payment.priceEnd &&
                commercials.cashPrice > specs.payment.priceStart) {
              Unit unit = new Unit(
                  commercials.image0, commercials.id, commercials.price, commercials.bua,
                  commercials.floor, commercials.subType);
              units.add(unit);
            }
          }
          else {
            if (commercials.cashPrice > specs.payment.priceStart) {
              Unit unit = new Unit(
                  commercials.image0, commercials.id, commercials.price, commercials.bua,
                  commercials.floor, commercials.subType);
              units.add(unit);
            }
          }
        }
        else
        {
          if (specs.payment.priceEnd != 0) {
            if (commercials.price < specs.payment.priceEnd &&
                commercials.price > specs.payment.priceStart)
            {
              Unit unit = new Unit(
                  commercials.image0, commercials.id, commercials.price, commercials.bua,
                  commercials.floor, commercials.subType);
              units.add(unit);
            }
          }
          else {
            if (commercials.price > specs.payment.priceStart) {
              Unit unit = new Unit(
                  commercials.image0, commercials.id, commercials.price, commercials.bua,
                  commercials.floor, commercials.subType);
              units.add(unit);
            }
          }
        }
      }

    }
    if(specs.type == "Administrative offices and clinics") {
      for (int i = 0; i < snapshot.data!.docs.length; i++) {
        Map<String, dynamic>? data = snapshot.data!.docs[i].data() as Map<
            String,
            dynamic>?;
        AdminClinics adminClinics = new AdminClinics.a();
        adminClinics.fromMap(data!);
        if (specs.payment.paymentSearch == "Cash")
        {
          if (specs.payment.priceEnd != 0) {
            if (adminClinics.cashPrice < specs.payment.priceEnd &&
                adminClinics.cashPrice > specs.payment.priceStart) {
              Unit unit = new Unit(
                  adminClinics.image0, adminClinics.id, adminClinics.price, adminClinics.bua,
                  adminClinics.finish, specs.type);
              units.add(unit);
            }
          }
          else {
            if (adminClinics.cashPrice > specs.payment.priceStart) {
              Unit unit = new Unit(
                  adminClinics.image0, adminClinics.id, adminClinics.price, adminClinics.bua,
                  adminClinics.finish, specs.type);
              units.add(unit);
            }
          }
        }
        else
        {
          if (specs.payment.priceEnd != 0) {
            if (adminClinics.price < specs.payment.priceEnd &&
                adminClinics.price > specs.payment.priceStart)
            {
              Unit unit = new Unit(
                  adminClinics.image0, adminClinics.id, adminClinics.price, adminClinics.bua,
                  adminClinics.finish, specs.type);
              units.add(unit);
            }
          }
          else {
            if (adminClinics.price > specs.payment.priceStart) {
              Unit unit = new Unit(
                  adminClinics.image0, adminClinics.id, adminClinics.price, adminClinics.bua,
                  adminClinics.finish, specs.type);
              units.add(unit);
            }
          }
        }
      }

    }

    return units;

  }

  List<Unit> Sorting(List<Unit> unilList, String Order) {

    switch(order)
    {
      case "1":
        unilList.sort((a, b) => a.price.compareTo(b.price));
      break;
      case "2":
        unilList.sort((b, a) => a.price.compareTo(b.price));
        break;
      case "3":
        break;
      case "4":
        break;

    }

    return unilList;
  }


}