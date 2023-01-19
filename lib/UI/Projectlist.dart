import 'package:redwinners/Model/Units.dart';
import 'package:redwinners/Model/Requests.dart';
import 'package:redwinners/UI/ProjectView.dart';
import 'package:redwinners/UI/scheme.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'ErrorServerPage.dart';
import 'Loading.dart';
import 'ProjectEdit.dart';
import 'ProjectNewList.dart';
import 'SpecificRequest.dart';
import 'home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:redwinners/Model/values.dart';

class ProjectList extends StatefulWidget {
  late String PathUnits;
  late String PathProjects;
  late Requests Specs;
  late String Origin;

  ProjectList(this.PathUnits, this.PathProjects, this.Specs, this.Origin);

  @override
  _ProjectListState createState() => _ProjectListState(PathUnits,PathProjects,Specs,Origin);
}

class _ProjectListState extends State<ProjectList> {
  late String pathUnits, pathProjects;
  late Requests specs;
  String nameSearch = "";
  late String origin;
  late Query query;
  int longestYears = 0;
  int counter = 0;
  List<String> Projectids= [];
  List<Apartments> appUnits= [];
  List<Villas> villaUnits= [];
  List<Chalet> chaletUnits= [];
  List<ServicedApartments> servUnits= [];
  List<Commercials> comUnits= [];
  List<AdminClinics> adminUnits= [];
  List<String> projectNames = [];
  List<String> repeatedNames = [];
  _ProjectListState(this.pathUnits,this.pathProjects, this.specs, this.origin);
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(reSearch);
  }
  final oCcy = new NumberFormat("#,###", "en_US");
  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);
    query = FirebaseFirestore.instance.collection(pathProjects);

    query = filterQuery(query, specs);

    final Stream<QuerySnapshot> _projectsStream = query.snapshots();


    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //appHeadWithBack("Projects", Icons.business_outlined, false, context),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 5,
                    )
                  ]),
              margin: EdgeInsets.only(bottom:0),
              child: Padding(
                padding: const EdgeInsets.only(top: 38, left: 8, right: 8, bottom: 6),
                child: Row(
                  children: [
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      onTap: (){
                        Navigator.of(context).maybePop();
                      },
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))
                          ,color: Colors.grey.shade300,),

                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 8),
                          child:TextField(
                            controller: myController,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: loc!.searchProjects),
                          ),
                          // Row(mainAxisSize: MainAxisSize.max,
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Expanded(child: Icon(Icons.arrow_back_ios)),
                          //     Expanded(
                          //       child: TextField(
                          //                       controller: myController,
                          //                       decoration: new InputDecoration(
                          //                       border: InputBorder.none,
                          //                           hintText: "Search Projects..."),
                          //                     ),
                          //     ),
                          //   ],
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ),

            Expanded(
              child:  ListofProjects(_projectsStream),)



          ],
        ),
      ),
    );


  }

  //in Case of deep search
  Widget ProjectCard(String ids, String path, BuildContext context) {
    var loc = AppLocalizations.of(context);
    bool condition = true;
    late ProjectCarding project;
    return FutureBuilder<DocumentSnapshot>(
      future:   FirebaseFirestore.instance.collection(path).doc(ids).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          print("ErrorStore: " +snapshot.error.toString());
          return OpsError();
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          print("ErrorStore: " +snapshot.error.toString());
          return OpsError();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          project = ProjectCarding.a();
          project.fromMap(data);

          String test = project.projectName.toLowerCase();
          if (test.length >= nameSearch.length) {
            for (int i = 0; i < nameSearch.length; i++) {
              if (nameSearch[i] != test[i]) {
                condition = false;
              }
            }

          }
          else {condition = false;}
          if(condition) {
            return InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.shortestSide <600? 120:200,
                  // height: 120,
                  child:
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FadeInImage(
                            height: MediaQuery.of(context).size.shortestSide <600? 120:200,
                            width: MediaQuery.of(context).size.shortestSide <600? 120:200,
                            fit: BoxFit.cover,
                            image: NetworkImage(project.photo1),
                            imageErrorBuilder: (context, exception,stackTrace) {
                              return Image(height: 120,
                                width: 120,
                                image: AssetImage("assets/ErrorImage.png"),);
                            },
                            placeholder: AssetImage("assets/Eclipse-1s-200px.gif")),


                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  project.projectName,
                                  textAlign: TextAlign.start,
                                  style:MediaQuery.of(context).size.shortestSide <600? Alltheme.textTheme.bodyText1:tabTheme.textTheme.bodyText1,
                                ),
                                Text(project.developer,
                                  textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                                  TextStyle(fontSize: 14):TextStyle(fontSize: 19),),

                                Divider(thickness: 1.5,
                                    color: Colors.grey.shade500),
                                Text(values.arabictranslateLocation(project.location),
                                  textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                                  TextStyle(fontSize: 14):TextStyle(fontSize: 19),),
                                origin == "Staff"? Text("Type: " + project.type,
                                  textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                                  TextStyle(fontSize: 14):TextStyle(fontSize: 19),):Text(loc!.area + ": " + project.areaInFeddan,
                                  textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                                  TextStyle(fontSize: 14):TextStyle(fontSize: 19),),

                                project.type == "Villas" || project.type == "Chalets" || project.type == "Serviced Apartments"?
                                Text(loc!.startFrom+project.lowestPPM + loc!.lE,
                                  textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                                  TextStyle(fontSize: 14):TextStyle(fontSize: 19),):Text(loc!.startFrom +project.lowestPPM +  loc!.perMeter,
                                  textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                                  TextStyle(fontSize: 14):TextStyle(fontSize: 19),),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {


                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProjectView(path, project.id, specs)));

                });
          }
          else
          {

            return Container(
              child: Center(
              ),
            );


          }
        }

        return Container(
          child: Center(
          ),
        );
      },
    );


  }

  //in case of just browsing
  Widget ProjectCarda(QueryDocumentSnapshot<Object?> doc, String pathProjects, BuildContext context) {
    var loc = AppLocalizations.of(context);
    late Project project;
    bool condition = false;
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    project = Project.a();
    project.fromMap(data);
    if(projectNames.length >5){
      projectNames.removeAt(0);
    }
    if(!projectNames.contains(project.projectName)) {
      projectNames.add(project.projectName);
      String projName = project.projectName.toLowerCase();
      if (projName.contains(nameSearch)) {
        condition = true;
      }
    }
    else{
      repeatedNames.add(project.projectName);
    }
    // String test = project.projectName.toLowerCase();
    // if (test.length >= nameSearch.length) {
    //   for (int i = 0; i < nameSearch.length; i++) {
    //     if (nameSearch[i] != test[i]) {
    //       condition = false;
    //     }
    //   }
    // }
    // else {condition = false;}
    if(condition)
      return InkWell(
          child: Container(
            //    height: MediaQuery.of(context).size.shortestSide <600? 120:200,
            width: MediaQuery.of(context).size.shortestSide <600? 120:200,
            // height: 120,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInImage(fadeInDuration: Duration(milliseconds: 300),
                      height: MediaQuery.of(context).size.shortestSide <600? 120:200,
                      width: MediaQuery.of(context).size.shortestSide <600? 120:200,
                      fit: BoxFit.cover,
                      image: NetworkImage(project.photo1),
                      imageErrorBuilder: (context, exception,stackTrace) {
                        return Image(height: 120,
                          width: 120,
                          image: AssetImage("assets/ErrorImage.png"),);
                      },
                      placeholder: AssetImage("assets/Eclipse-1s-200px.gif")
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            project.projectName,
                            textAlign: TextAlign.start,
                            style:MediaQuery.of(context).size.shortestSide <600? Alltheme.textTheme.bodyText1:tabTheme.textTheme.bodyText1,
                          ),
                          Text(origin == "Dev"?project.type:project.developer, textAlign: TextAlign.start, style:MediaQuery.of(context).size.shortestSide <600?
                          TextStyle(fontSize: 14):TextStyle(fontSize: 19),),
                          Divider(thickness: 1.5, color: Colors.grey.shade500),
                          origin == "Staff"? Text("Type: " + project.type,
                            textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                            TextStyle(fontSize: 14):TextStyle(fontSize: 19),):Text(loc!.area+": " + project.areaInFeddan,
                            textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                            TextStyle(fontSize: 14):TextStyle(fontSize: 19),),
                          Text(project.location, textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                          TextStyle(fontSize: 14):TextStyle(fontSize: 19),),
                          project.type == "Villas" || project.type == "Chalets" || project.type == "Serviced Apartments"?
                          Text(loc!.startFrom+project.lowestPPM + loc!.lE,
                            textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                            TextStyle(fontSize: 14):TextStyle(fontSize: 19),):Text(loc!.startFrom + project.lowestPPM +   loc!.perMeter,
                            textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                            TextStyle(fontSize: 14):TextStyle(fontSize: 19),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          onTap: () {
            if(repeatedNames.contains(project.projectName))
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>

                          ProjectNewList(
                              "All Projects", "All Projects", Requests.emp(project.type, project.location), project.projectName, origin)));
            }
            else if(origin == "Staff")
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProjectEdit(pathProjects, project.id, specs, pathProjects)));
            }
            else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProjectView(pathProjects, project.id, Requests.emp(project.type, project.location))));
            }
          });
    else
    {
      return Container(
        child: Center(
        ),
      );
    }
  }

  ListofProjects(Stream<QuerySnapshot> _projectsStream) {
    if(origin == "Browse" || origin=="Staff" || origin=="Dev")
    {

      return StreamBuilder<QuerySnapshot>(
          stream: _projectsStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var loc = AppLocalizations.of(context);
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
//                Center(child: Text("Loading"));
            }
            if (snapshot.data!.docs.length > 0) {

              return ListView.builder(
                  padding: EdgeInsets.all(0),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.docs.length,
                  //itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProjectCarda(
                        snapshot.data!.docs[index], pathProjects, context);
                  });
            }
            else{
              return Center(
                child: Container(
                  child: Text(loc!.noResultsFound),
                ),
              );
            }
          }

      );
    }
    else{
      return StreamBuilder<QuerySnapshot>(
          stream: _projectsStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var loc = AppLocalizations.of(context);
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
              //Center(child: Text("Loading"));
            }

            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              Map<String, dynamic>? data = snapshot.data!.docs[i].data() as Map<String,dynamic>?;
              if (specs.payment.paymentSearch == "Cash") {
                if (specs.payment.priceEnd != 0) {
                  if (data!["cashPrice"] < specs.payment.priceEnd &&
                      data["cashPrice"] > specs.payment.priceStart) {
                    Projectids.add(data["projectID"]);
                  }
                }
                else {
                  if (data!["cashPrice"] > specs.payment.priceStart) {
                    Projectids.add(data["projectID"]);
                  }
                }
              }
              else {
                if (specs.payment.priceEnd != 0) {
                  if (data!["price"] < specs.payment.priceEnd &&
                      data["price"] > specs.payment.priceStart &&
                      longestYears <= int.parse(data["instalmentYears"])) {
                    Projectids.add(data["projectID"]);
                  }
                }
                else {
                  if (data!["price"] > specs.payment.priceStart &&
                      longestYears <= int.parse(data["instalmentYears"])) {
                    Projectids.add(data["projectID"]);
                  }
                }
              }
            }
            Projectids = Projectids.toSet().toList();
            if(Projectids.length > 0)
            {
              return ListView.builder(

                  scrollDirection: Axis.vertical,
                  itemCount: Projectids.length,
                  //itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProjectCard(
                        Projectids[index],pathProjects, context);
                  });
            }
            else
            {
              return Center(
                child: Container(
                  child: Text(loc!.noResultsFound),
                ),
              );
            }
          }
      );
    }
  }

  Query<Object?> filterQuery(Query<Object?> query, Requests requests)
  {


    if(origin=="Staff")
    {
      return query;
    }
    if(origin=="Browse")
    {
      //query = query.where("location", isEqualTo: requests.location);
      return query;
    }
    if(origin=="Dev")
    {

      return query;
    }
    switch (requests.type) {
      case "":
        return query;
      case "Apartments and Duplexes":
      //region Apartments
        query = FirebaseFirestore.instance.collection(pathUnits);
        longestYears = requests.payment.longestYears;
        if(requests.location != "")
        {
          query = query.where("location", isEqualTo: requests.location);
        }
        if (requests.subLocation != "") {
          if(requests.subLocation != "All") {
            query = query.where("inLocation", isEqualTo: requests.subLocation);
          }
        }
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
        return query;
    //endregion
      case "Villas":
      //region Villas
        query = FirebaseFirestore.instance.collection(pathUnits);
        longestYears = requests.payment.longestYears;
        if(requests.location != "")
        {
          query = query.where("location", isEqualTo: requests.location);
        }
        if (requests.subLocation != "") {
          if(requests.subLocation != "All") {
            query = query.where("inLocation", isEqualTo: requests.subLocation);
          }
        }
        if (requests.viArea != "All") {
          query = query.where("areaRange", isEqualTo: requests.viArea);
        }
//        if (requests.payment.priceEnd != 0) {
//          query =
//              query.where(requests.payment.paymentSearch == "Cash"? "cashPrice" : "price", isLessThan: requests.payment.priceEnd + 1);
//        }
//        if (requests.payment.priceStart != 0) {
//          query =
//              query.where(
//                  requests.payment.paymentSearch == "Cash"? "cashPrice" : "price", isGreaterThan: requests.payment.priceStart - 1);
//        }
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
        return query;
    //endregion
      case "Serviced Apartments":
      //region Serviced Apartment
        query = FirebaseFirestore.instance.collection(pathUnits);
        longestYears = requests.payment.longestYears;
        if(requests.location != "")
        {
          query = query.where("location", isEqualTo: requests.location);
        }
        if (requests.subLocation != "") {
          if(requests.subLocation != "All") {
            query = query.where("inLocation", isEqualTo: requests.subLocation);
          }
        }
        if (requests.sAArea != "All")
        {
          query = query.where("areaRange", isEqualTo: requests.sAArea);
        }
//        if (requests.payment.priceEnd != 0) {
//          query =
//              query.where(requests.payment.paymentSearch == "Cash"? "cashPrice" : "price", isLessThan: requests.payment.priceEnd + 1);
//        }
//        if (requests.payment.priceStart != 0) {
//          query =
//              query.where(
//                  requests.payment.paymentSearch == "Cash"? "cashPrice" : "price", isGreaterThan: requests.payment.priceStart - 1);
//        }

        if (requests.delivery != "All") {
          query = query.where("delivery", isEqualTo: requests.delivery);
        }
        if (requests.finish != "All") {
          query = query.where("finish",whereIn: requests.finish== "Fully Finished"?["Fully Finished","Fully Finished with facilities" ]:[requests.finish]);
        }
        return query;
    //endregion
      case "Chalets":
      //region Chalet

        query = FirebaseFirestore.instance.collection(pathUnits);
        longestYears = requests.payment.longestYears;
        if(requests.location != "")
        {
          query = query.where("location", isEqualTo: requests.location);
        }
        if (requests.subLocation != "") {
          if(requests.subLocation != "All") {
            query = query.where("inLocation", isEqualTo: requests.subLocation);
          }
        }
        if (requests.chArea != "All") {
          query = query.where("areaRange", isEqualTo: requests.chArea);
        }
//        if (requests.payment.priceEnd != 0) {
//          query =
//              query.where(requests.payment.paymentSearch == "Cash"? "cashPrice" : "price", isLessThan: requests.payment.priceEnd + 1);
//        }
//        if (requests.payment.priceStart != 0) {
//          query =
//              query.where(
//                  requests.payment.paymentSearch == "Cash"? "cashPrice" : "price", isGreaterThan: requests.payment.priceStart - 1);
//        }
//

        if (requests.chFloor != "All") {
          query = query.where("floor", isEqualTo: requests.chFloor);
        }
        if (requests.chRooms != "All") {
          query = query.where("rooms", isEqualTo: requests.chRooms);
        }
        if (requests.delivery != "All") {
          query = query.where("delivery", isEqualTo: requests.delivery);
        }
        if (requests.finish != "All") {
          query = query.where("finish",whereIn: requests.finish== "Fully Finished"?["Fully Finished","Fully Finished with facilities" ]:[requests.finish]);
        }
        return query;
    //endregion
      case "Commercials":
      //region Commercial
        query = FirebaseFirestore.instance.collection(pathUnits);
        longestYears = requests.payment.longestYears;
        if(requests.location != "")
        {
          query = query.where("location", isEqualTo: requests.location);
        }
        if (requests.subLocation != "") {
          if(requests.subLocation != "All") {
            query = query.where("inLocation", isEqualTo: requests.subLocation);
          }
        }
        if (requests.comArea != "All")
        {
          query = query.where("areaRange", isEqualTo: requests.comArea);
        }
        if (requests.comType != "All")
        {
          query = query.where("subType", isEqualTo: requests.comType);
        }
        if (requests.comFloor != "All"){
          query = query.where("floor", isEqualTo: requests.comFloor);
        }
        if (requests.comPPM != "All"){
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
//        if (requests.payment.priceEnd != 0) {
//          query =
//              query.where(requests.payment.paymentSearch == "Cash"? "cashPrice" : "price", isLessThan: requests.payment.priceEnd + 1);
//        }
//        if (requests.payment.priceStart != 0) {
//          query =
//              query.where(
//                  requests.payment.paymentSearch == "Cash"? "cashPrice" : "price", isGreaterThan: requests.payment.priceStart - 1);
//        }

        if (requests.delivery != "All") {
          query = query.where("delivery", isEqualTo: requests.delivery);
        }
        if (requests.finish != "All") {
          query = query.where("finish",whereIn: requests.finish== "Fully Finished"?["Fully Finished","Fully Finished with facilities" ]:[requests.finish]);
        }
        return query;
    //endregion
      case "Administrative offices and clinics":
      // region Admin
        query = FirebaseFirestore.instance.collection(pathUnits);
        longestYears = requests.payment.longestYears;
        if(requests.location != "")
        {
          query = query.where("location", isEqualTo: requests.location);
        }
        if (requests.subLocation != "") {
          if(requests.subLocation != "All") {

            query = query.where("inLocation", isEqualTo: requests.subLocation);
          }
        }
        if (requests.adminArea != "All")
        {
          query = query.where("areaRange", isEqualTo: requests.adminArea);
        }
        if (requests.adminType != "All") {
          if (requests.adminType == "Office")
          {  query = query.where("typeOffice", isEqualTo: true);}
          if (requests.adminType == "Clinic")
          {  query = query.where("typeClinics", isEqualTo: true);
          }
        }
        if (requests.adminPPM != "All"){
          query = query.where("ppmRange", isEqualTo: requests.adminPPM);
        }

//          if (requests.payment.priceEnd != 0) {
//            query =
//                query.where(requests.payment.paymentSearch == "Cash"? "cashPrice" : "price", isLessThan: requests.payment.priceEnd + 1);
//          }
//          if (requests.payment.priceStart != 0) {
//            query =
//                query.where(
//                    requests.payment.paymentSearch == "Cash"? "cashPrice" : "price", isGreaterThan: requests.payment.priceStart - 1);
//          }

        if (requests.delivery != "All") {
          query = query.where("delivery", isEqualTo: requests.delivery);
        }
        if (requests.finish != "All") {
          query = query.where("finish",whereIn: requests.finish== "Fully Finished"?["Fully Finished","Fully Finished with facilities" ]:[requests.finish]);
        }

        return query;
    //endregion
    }
    return query;
  }

  reSearch() async {
    String test = nameSearch;
    await Future.delayed(const Duration(milliseconds: 2500), (){});
    if (nameSearch != test)
    {
      return;
    }
    if (myController.text.toLowerCase() == "")
    {
      if (nameSearch != "")
      {
        setState(() {
          nameSearch = myController.text.toLowerCase();
        });
      }
      else
        return;
    }
    if (nameSearch == myController.text.toLowerCase())
    {return;}
    setState(() {
      nameSearch = myController.text.toLowerCase();
    });
  }

  // List<String> appFilterPrice(List<Apartments> unitsList, Requests specs) {
  //   List<String> newList = [];
  //
  //   if (specs.payment.paymentSearch == "Cash")
  //   {
  //     if (specs.payment.priceEnd != 0) {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].cashPrice < specs.payment.priceEnd &&
  //             unitsList[i].cashPrice > specs.payment.priceStart) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //     else {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].cashPrice > specs.payment.priceStart) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //   }
  //   else
  //   {
  //     if (specs.payment.priceEnd != 0) {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].price < specs.payment.priceEnd &&
  //             unitsList[i].price > specs.payment.priceStart && longestYears <= int.parse(unitsList[i].instalmentYears)) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //     else {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].price > specs.payment.priceStart && longestYears <= int.parse(unitsList[i].instalmentYears)) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //   }
  //   return newList;
  //
  //
  // }
  // List<String> vilFilterPrice(List<Villas> unitsList, Requests specs) {
  //   List<String> newList = [];
  //
  //   if (specs.payment.paymentSearch == "Cash")
  //   {
  //     if (specs.payment.priceEnd != 0) {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].cashPrice < specs.payment.priceEnd &&
  //             unitsList[i].cashPrice > specs.payment.priceStart) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //     else {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].cashPrice > specs.payment.priceStart) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //   }
  //   else
  //   {
  //     if (specs.payment.priceEnd != 0) {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].price < specs.payment.priceEnd &&
  //             unitsList[i].price > specs.payment.priceStart && longestYears <= int.parse(unitsList[i].instalmentYears)) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //     else {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].price > specs.payment.priceStart && longestYears <= int.parse(unitsList[i].instalmentYears)) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //   }
  //   return newList;
  //
  //
  // }
  // List<String> serFilterPrice(List<ServicedApartments> unitsList, Requests specs){
  //   List<String> newList = [];
  //
  //   if (specs.payment.paymentSearch == "Cash")
  //   {
  //     if (specs.payment.priceEnd != 0) {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].cashPrice < specs.payment.priceEnd &&
  //             unitsList[i].cashPrice > specs.payment.priceStart) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //     else {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].cashPrice > specs.payment.priceStart) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //   }
  //   else
  //   {
  //     if (specs.payment.priceEnd != 0) {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].price < specs.payment.priceEnd &&
  //             unitsList[i].price > specs.payment.priceStart && longestYears <= int.parse(unitsList[i].instalmentYears)) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //     else {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].price > specs.payment.priceStart && longestYears <= int.parse(unitsList[i].instalmentYears)) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //   }
  //   return newList;
  //
  //
  // }
  // List<String> chaFilterPrice(List<Chalet> unitsList, Requests specs){
  //   List<String> newList = [];
  //
  //   if (specs.payment.paymentSearch == "Cash")
  //   {
  //     if (specs.payment.priceEnd != 0) {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].cashPrice < specs.payment.priceEnd &&
  //             unitsList[i].cashPrice > specs.payment.priceStart) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //     else {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].cashPrice > specs.payment.priceStart) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //   }
  //   else
  //   {
  //     if (specs.payment.priceEnd != 0) {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //
  //         if (unitsList[i].price < specs.payment.priceEnd &&
  //             unitsList[i].price > specs.payment.priceStart && longestYears <= int.parse(unitsList[i].instalmentYears)) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //     else {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //
  //         if (unitsList[i].price > specs.payment.priceStart && longestYears <= int.parse(unitsList[i].instalmentYears)) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //   }
  //   return newList;
  //
  //
  // }
  // List<String> comFilterPrice(List<Commercials> unitsList, Requests specs){
  //   List<String> newList = [];
  //
  //   if (specs.payment.paymentSearch == "Cash")
  //   {
  //     if (specs.payment.priceEnd != 0) {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].cashPrice < specs.payment.priceEnd &&
  //             unitsList[i].cashPrice > specs.payment.priceStart) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //     else {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].cashPrice > specs.payment.priceStart) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //   }
  //   else
  //   {
  //     if (specs.payment.priceEnd != 0) {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //
  //         if (unitsList[i].price < specs.payment.priceEnd &&
  //             unitsList[i].price > specs.payment.priceStart&& longestYears <= int.parse(unitsList[i].instalmentYears)) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //     else {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].price > specs.payment.priceStart&& longestYears <= int.parse(unitsList[i].instalmentYears)) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //   }
  //   return newList;
  //
  //
  // }
  // List<String> admFilterPrice(List<AdminClinics> unitsList, Requests specs){
  //   List<String> newList = [];
  //
  //   if (specs.payment.paymentSearch == "Cash")
  //   {
  //     if (specs.payment.priceEnd != 0) {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].cashPrice < specs.payment.priceEnd &&
  //             unitsList[i].cashPrice > specs.payment.priceStart) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //     else {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].cashPrice > specs.payment.priceStart) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //   }
  //   else
  //   {
  //     if (specs.payment.priceEnd != 0) {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].price < specs.payment.priceEnd &&
  //             unitsList[i].price > specs.payment.priceStart && longestYears <= int.parse(unitsList[i].instalmentYears)) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //     else {
  //       for (int i = 0; i < unitsList.length; i ++) {
  //         if (unitsList[i].price > specs.payment.priceStart && longestYears <= int.parse(unitsList[i].instalmentYears)) {
  //           newList.add(unitsList[i].projectID);
  //         }
  //       }
  //     }
  //   }
  //   return newList;
  //
  //
  // }
}
// for (int i = 0; i < snapshot.data!.docs.length; i++) {
//   Map<String, dynamic>? data = snapshot.data!.docs[i].data() as Map<String,dynamic>?;
//   SearchUnit searchUnit = new SearchUnit.a();
//   searchUnit.fromMap(data!);
//   if (specs.payment.paymentSearch == "Cash") {
//     if (specs.payment.priceEnd != 0) {
//       if (searchUnit.cashPrice < specs.payment.priceEnd &&
//           searchUnit.cashPrice > specs.payment.priceStart) {
//         Projectids.add(searchUnit.projectID);
//       }
//     }
//     else {
//       if (searchUnit.cashPrice > specs.payment.priceStart) {
//         Projectids.add(searchUnit.projectID);
//       }
//     }
//   }
//   else {
//     if (specs.payment.priceEnd != 0) {
//       if (searchUnit.price < specs.payment.priceEnd &&
//           searchUnit.price > specs.payment.priceStart &&
//           longestYears <= int.parse(searchUnit.instalmentYears)) {
//         Projectids.add(searchUnit.projectID);
//       }
//     }
//     else {
//       if (searchUnit.price > specs.payment.priceStart &&
//           longestYears <= int.parse(searchUnit.instalmentYears)) {
//         Projectids.add(searchUnit.projectID);
//       }
//     }
//   }
// }