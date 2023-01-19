

import 'package:redwinners/Model/Requests.dart';
import 'package:redwinners/Model/Units.dart';
import 'package:redwinners/UI/DeveloperView.dart';
import 'package:redwinners/UI/ProjectView.dart';
import 'package:redwinners/UI/scheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'AdminPanel.dart';
import 'EditUser.dart';
import 'ErrorServerPage.dart';
import 'Loading.dart';
import 'SpecificRequest.dart';
import 'browse.dart';

bool language = true;
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
const String launches = "Upcoming launches";
const String offers = "";
class _HomeState extends State<Home> {
  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  AlertDialog _buildExitDialog(BuildContext context) {

    return AlertDialog(
      title:  Text(AppLocalizations.of(context)!.exit),
      content: Text(AppLocalizations.of(context)!.doYouWantExit),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(AppLocalizations.of(context)!.no),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(AppLocalizations.of(context)!.yes),
        ),
      ],
    );
  }

  List<bool> _selection = [true, false];
  int selectedIndex = 0;
  int selectedIndex1 = 0;
  final Stream<QuerySnapshot> _projectsStream = FirebaseFirestore.instance.collection("launches").snapshots();
  @override
  Widget build(BuildContext context) {

      return  WillPopScope(
              onWillPop: () async {
                return _onWillPop(context);
              },
              child: Scaffold(
//
                body: UpgradeAlert(
                  upgrader: Upgrader(countryCode: "EG"),
                  child: Column(
                    children: [
                      appHead(selectedIndex == 0? AppLocalizations.of(context)!.offers:
                      AppLocalizations.of(context)!.launches ,Icons.local_offer, true, context),

                      OfferLaunchesView(_selection),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),

                          child: Container(
                            height: 45,
                            child: ToggleButtons(
                              children: [
                                Container(child: Center(child: Text(AppLocalizations.of(context)!.offers),),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .4),
                                Container(child: Center(child: Text(AppLocalizations.of(context)!.launches)),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .4),
                              ],

                              isSelected: _selection,
                              borderRadius: BorderRadius.circular(20),
                              fillColor: Colors.redAccent.shade700,
                              selectedColor: Colors.white,
                              splashColor: Colors.white,
                              onPressed: (int index) {
                                setState(() {
                                  for (int buttonIndex = 0; buttonIndex <
                                      _selection.length; buttonIndex++) {
                                    if (buttonIndex == index) {
                                      _selection[buttonIndex] = true;
                                    } else {
                                      _selection[buttonIndex] = false;
                                    }
                                  }
                                  selectedIndex = index;
                                });
                              },),
                          ),
                        ),
                      ),
                    ],
                  ),

                ),
                bottomNavigationBar: BottomNavigationBar(
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.local_offer),
                      label: AppLocalizations.of(context)!.offers,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.folder_open),
                      label: AppLocalizations.of(context)!.browse,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_tree),
                      label: AppLocalizations.of(context)!.callScheme,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.manage_search),
                      label: AppLocalizations.of(context)!.request,
                    ),
                  ],
                  currentIndex: selectedIndex1,
                  iconSize: 20,
                  unselectedFontSize: 12,

                  selectedFontSize: 12,
                  selectedItemColor: Colors.amber[800],
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  onTap: _onItemTapped,
                  type: BottomNavigationBarType.fixed,
                ),
              ),
            );

  }

  @override
  void initState() {
    Prevalent.checkInProtocol(context);


  }

  _Tdirection(bool language) {
    if(language) {
      return ui.TextDirection.rtl;
    }
    else {
        return ui.TextDirection.ltr;
      }
  }



  Widget AdminContainer() {
    if(Prevalent.admin)
      {
        return Container( margin: EdgeInsets.only(bottom: 15, left: 20, right: 20),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:
                    (context) =>AdminPanel()));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 70),
                primary: Colors.redAccent.shade700,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.manageUsers)),
        );

      }
    else
      {return Container();}

  }

  void _onItemTapped(int value) {
    if(value == 1)
      {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
            (context) => Browse()), (route) => false);
      }
    if(value == 2)
    {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
          (context) => QuestionsListView()), (route) => false);
    }
    if(value == 3)
    {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
          (context) => SpecificRequest()), (route) => false);
    }

  }

  Widget offerCard(QueryDocumentSnapshot<Object?> doc, BuildContext context) {
    Map<String, dynamic>? data = doc.data() as Map<String,dynamic>?;
    Offer offer = new Offer.a();
    offer.fromMap(data!);
    return Container(
      child: InkWell(
        child: Card(
          child:    Column( mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: Alignment.bottomCenter,
                  children: [
                    FadeInImage(
                        height: (MediaQuery.of(context).size.height > 600
                            ? MediaQuery.of(context).size.height * 0.35
                            : 250),
                        width:  MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        image: NetworkImage(offer.image),
                        imageErrorBuilder: (context, exception,stackTrace) {
                          return Image(
                            height: MediaQuery.of(context).size.height*.35,
                            width:  MediaQuery.of(context).size.width,
                            image: AssetImage("assets/ErrorImage.png"),);
                        },
                        placeholder: AssetImage("assets/Eclipse-1s-200px.gif")),

                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 4, right:4),
                        child: Row( crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(offer.projectName+ " ",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(decoration: BoxDecoration(),
                                  child: Text(offer.offerHead,
                                      style: TextStyle(color: Colors.white, backgroundColor: Colors.red.shade900)),

                                ),
                            ),

                          ],
                        ),
                      ),
                      Divider(thickness: 1.5, color: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 4.0, left: 4, bottom: 4, right: 4),
                        child: Text(offer.developer,
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                )
              ]),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder(
                      top: BorderSide(color: Colors.grey.shade200),
                      bottom: BorderSide(color: Colors.grey.shade200),
                      horizontalInside:
                      BorderSide(color: Colors.grey.shade200)),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(110),
                    1: FlexColumnWidth(),
                  },
                  children: <TableRow>[
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(AppLocalizations.of(context)!.location+": ",
                                  textAlign: TextAlign.start))),
                      TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Text(offer.location ),
                              ],
                            )),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(AppLocalizations.of(context)!.offerEndsAt + ": ",
                                textAlign: TextAlign.start),
                          )),
                      TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child:Text(
                                DateFormat("dd MMM yyyy").format(offer.endDate.toDate()).toString(),
                                style: TextStyle(
                                  color: Colors.red.shade900,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.double,
                                )),
                      ),
                      )
                    ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(offer.text, textDirection: offer.Arabic?ui.TextDirection.rtl:ui.TextDirection.ltr,),
              ),
            ],
          ), //Images And ProjectName,
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder:
              (context) => ProjectView("All Projects", offer.projectId,new Requests.emp("", ''))));
        },
      ),
    );
  }
  Widget LaunchCard(QueryDocumentSnapshot<Object?> doc, BuildContext context) {

    Map<String, dynamic>? data = doc.data() as Map<String,dynamic>?;
    Launch launch = new Launch.a();
    launch.fromMap(data!);
    var remaining = launch.launchDate.toDate().difference(DateTime.now()).inDays;
    return Container(
      child: InkWell(
        child: Card(
          child:    Column( mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: Alignment.bottomCenter,
                  children: [
                    FadeInImage(
                        height: (MediaQuery.of(context).size.height > 600
                            ? MediaQuery.of(context).size.height * 0.35
                            : 250),
                        width:  MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        image: NetworkImage(launch.image),
                        imageErrorBuilder: (context, exception,stackTrace) {
                          return Image(height: 120,
                            width: 120,
                            image: AssetImage("assets/ErrorImage.png"),);
                        },
                        placeholder: AssetImage("assets/Eclipse-1s-200px.gif")),
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 4, right: 4),
                            child: Row(mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Expanded(
                                  child: Text(launch.projectName+ " ",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 25)),
                                ),
                                DateFormat("d MMM yyyy").format(launch.launchDate.toDate()).toString() == DateFormat("d MMM yyyy").format(DateTime.utc(2020))?
                                Container(decoration: BoxDecoration(color: Colors.red.shade900),
                                    child: Text(AppLocalizations.of(context)!.soon + " " + getlaunch(launch.launchType), style: TextStyle(color: Colors.white, ),)):
                                Container(decoration: BoxDecoration(color: Colors.red.shade900),
                                  child: Text(AppLocalizations.of(context)!.comingin + " " + remaining.toString() + " " + getday(remaining) +" "+ getlaunch(launch.launchType) ,
                                    style: TextStyle(color: Colors.white),),
                                )
                              ],
                            ),
                          ),
                          Divider(thickness: 1.5, color: Colors.grey),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4.0, left: 4, bottom: 4, right: 4),
                            child: Text(launch.developer,
                                style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                    )
                  ]),
              Container(
            margin: EdgeInsets.only(left: 12, right: 12),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder(
                  top: BorderSide(color: Colors.grey.shade200),
                  bottom: BorderSide(color: Colors.grey.shade200),
                  horizontalInside:
                  BorderSide(color: Colors.grey.shade200)),
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(90),
                1: FlexColumnWidth(),
              },
              children: <TableRow>[
                TableRow(children: [
                  TableCell(
                      child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(AppLocalizations.of(context)!.location+": ",
                              textAlign: TextAlign.start))),
                  TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            Text(launch.location ),
                          ],
                        )),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                      child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(AppLocalizations.of(context)!.eoi + ": ",
                                textAlign: TextAlign.start),
                          )),
                  TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child:Text(launch.EOI)),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                      child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(AppLocalizations.of(context)!.launchDate+": ",
                              textAlign: TextAlign.start))),
                  TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: DateFormat("d MMM yyyy").format(launch.launchDate.toDate()).toString() == DateFormat("d MMM yyyy").format(DateTime.utc(2020))?
                        Text(AppLocalizations.of(context)!.soon):Text(DateFormat("d MMM yyyy").format(launch.launchDate.toDate()).toString())),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                      child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(AppLocalizations.of(context)!.types+ ": ",
                              textAlign: TextAlign.start))),
                  TableCell(
                    child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(launch.types)),
                  ),
                ]),

              ],
            ),
          ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                  child: Text(launch.text,  textDirection: launch.Arabic?ui.TextDirection.rtl:ui.TextDirection.ltr,),
              ),
            ],
          ), //Images And ProjectName,
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder:
              (context) => DeveloperView(launch.developerId)));
        },
      ),
    );
  }

  OfferLaunchesView(List<bool> selection) {
    if (selectedIndex ==0 )
    {
      final Stream<QuerySnapshot> _projectsStream = FirebaseFirestore.instance.collection("offers").snapshots();

      return StreamBuilder<QuerySnapshot>(
          stream: _projectsStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
             return OpsError();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Center(child: Loading());
            }

            return Expanded(
              child: ListView.builder(

                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return offerCard(
                        snapshot.data!.docs[index], context);
                  }),

            );
          });
    }

    else if(selectedIndex == 1)
      {
        final Stream<QuerySnapshot> _projectsStream = FirebaseFirestore.instance.collection("launches").snapshots();

        return StreamBuilder<QuerySnapshot>(
            stream: _projectsStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if (snapshot.hasError) {
            return OpsError();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Expanded(child: Center(child: Loading()));
          }

          return Expanded(
            child: ListView.builder(

                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return LaunchCard(
                      snapshot.data!.docs[index], context);
                }),
          );
        }
        );
      }

  }

  String getlaunch(String launchType) {
    if(launchType.contains("release"))
      {
        return " (" + AppLocalizations.of(context)!.newRelease+ ")";
      }
    else
    {
      return " (" +AppLocalizations.of(context)!.launch + ") ";
    }
  }

  String getday(int remaining) {
    if (remaining > 10) {
      return AppLocalizations.of(context)!.day;
    }
    else{
      return AppLocalizations.of(context)!.days;
    }
    
  }


}




