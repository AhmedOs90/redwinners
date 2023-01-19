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
import 'SpecificRequest.dart';
import 'home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:redwinners/Model/values.dart';

class ProjectNewList extends StatefulWidget {
  late String PathUnits;
  late String PathProjects;
  late Requests Specs;
  late String ProjectName;
  late String Origin;

  ProjectNewList(this.PathUnits, this.PathProjects, this.Specs, this.ProjectName, this.Origin);

  @override
  State<ProjectNewList> createState() => _ProjectNewListState(this.PathUnits, this.PathProjects, this.Specs, this.ProjectName, this.Origin);
}

class _ProjectNewListState extends State<ProjectNewList> {
  late String pathUnits;
  

  _ProjectNewListState(this.pathUnits, this.pathProjects, this.specs, this.projectName,this.origin);
  late String pathProjects;
  late Requests specs;
  final myController = TextEditingController();
  late String nameSearch;
  late String projectName;
  late String origin;
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
  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);
    late Query query;
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


  Widget ProjectCarda(QueryDocumentSnapshot<Object?> doc, String pathProjects, BuildContext context) {
    late Project project;
    bool condition = true;
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    project = Project.a();
    project.fromMap(data);

    // if (projName.length >= nameSearch.length) {
    //
    //   for (int i = 0; i < nameSearch.length; i++) {
    //     if (nameSearch[i] != projName[i]) {
    //       condition = false;
    //     }
    //   }
    // }
    // else {condition = false;}

    var loc = AppLocalizations.of(context);
    if(condition)
      return InkWell(
          child: Container(
            //height: MediaQuery.of(context).size.shortestSide <600? 120:200,
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
                            values.arabictranslatetype(project.type),
                            textAlign: TextAlign.start,
                            style:MediaQuery.of(context).size.shortestSide <600? Alltheme.textTheme.bodyText1:tabTheme.textTheme.bodyText1,
                          ),
                          Text(project.developer, textAlign: TextAlign.start, style:MediaQuery.of(context).size.shortestSide <600?
                          TextStyle(fontSize: 14):TextStyle(fontSize: 19),),
                          Divider(thickness: 1.5, color: Colors.grey.shade500),
                          origin == "Staff"? Text("Type: " + project.type,
                            textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                            TextStyle(fontSize: 14):TextStyle(fontSize: 19),):Text(loc!.area+ project.areaInFeddan,
                            textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                            TextStyle(fontSize: 14):TextStyle(fontSize: 19),),
                          Text(values.arabictranslateLocation(project.location), textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                          TextStyle(fontSize: 14):TextStyle(fontSize: 19),),
                          project.type == "Villas" || project.type == "Chalets" || project.type == "Serviced Apartments"?
                          Text(loc!.startFrom+project.lowestPPM + loc!.lE,
                            textAlign: TextAlign.start,style:MediaQuery.of(context).size.shortestSide <600?
                            TextStyle(fontSize: 14):TextStyle(fontSize: 19),):Text(loc!.startFrom+project.lowestPPM +   loc!.perMeter,
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
              if (origin == "Staff") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProjectEdit(
                                pathProjects, project.id, specs, pathProjects)));
              }
              else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProjectView(pathProjects, project.id, specs)));
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
                      snapshot.data!.docs[index], "All Projects", context);
                }, );
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

  Query<Object?> filterQuery(Query<Object?> query, Requests requests)
  {
    query = query.where("projectName", isEqualTo: projectName);
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
}
