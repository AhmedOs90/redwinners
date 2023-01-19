import 'package:redwinners/Model/Requests.dart';
import 'package:redwinners/Model/Units.dart';
import 'package:redwinners/UI/UnitList.dart';
import 'package:redwinners/UI/slideShow.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:ui' as ui;
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:redwinners/Model/values.dart';
import 'DeveloperView.dart';
import 'ErrorServerPage.dart';
import 'Loading.dart';
import 'UploadFiles.dart';
import 'home.dart';

late List<Widget> imageSliders;
late List<String> imageList;

class ProjectEdit extends StatefulWidget {
  @override
  String Path, Id, Origin;
  Requests Request;

  ProjectEdit(this.Path, this.Id, this.Request, this.Origin);

  _ProjectEditState createState() => _ProjectEditState(Path, Id, Request, Origin);
}

class _ProjectEditState extends State<ProjectEdit> {

  var progress = 0.0;
  String path, id, origin;
  Requests request;
  int counter = 0;
  final areaControl = TextEditingController();
  final projNameControl = TextEditingController();
  final DeveloperControl = TextEditingController();
  final descriptionController = TextEditingController();
  final facilControl = TextEditingController();
  final contractControl = TextEditingController();
  final consultantControl = TextEditingController();
  final loadControl = TextEditingController();
  final deliverControl = TextEditingController();
  final clubControl = TextEditingController();
  final garageControl = TextEditingController();
  final maintControl = TextEditingController();
  final cashControl = TextEditingController();
  final lowestPPMControl = TextEditingController();
  final longestControl = TextEditingController();
  final paymntPlan = TextEditingController();
  final offerControl = TextEditingController();
  final contactControl1 = TextEditingController();
  final phoneControl1 = TextEditingController();
  final contactControl2 = TextEditingController();
  final phoneControl2 = TextEditingController();
  final arabicFacilControl = TextEditingController();
  final arabicDescriptionController = TextEditingController();



  _ProjectEditState(this.path, this.id, this.request, this.origin);
  String area = "";
  String projName = "";
  String Developer = "";
  String description = "";
  String arabicDescription = "";
  String facil = "";
  String arabicFacil = "";
  String contract = "";
  String consultant = "";
  String load = "";
  String deliver = "";
  String club = "";
  String garage = "";
  String maint = "";
  String cash = "";
  String lowest = "";
  String longest = "";
  String paymnt = "";
  String offer = "";
  String contact = "";
  String phone = "";
  String contact2 = "";
  String phone2 = "";
  String Location = "";
  String subLocation = "Any";
  String finish = "";
  String Pass = "";

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
  }
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    descriptionController.dispose();
    areaControl.dispose();
    projNameControl.dispose();
    DeveloperControl.dispose();
    descriptionController.dispose();
    facilControl.dispose();
    contractControl.dispose();
    consultantControl.dispose();
    loadControl.dispose();
    deliverControl.dispose();
    clubControl.dispose();
    garageControl.dispose();
    maintControl.dispose();
    cashControl.dispose();
    lowestPPMControl.dispose();
    longestControl.dispose();
    paymntPlan.dispose();
    offerControl.dispose();
    contactControl1.dispose();
    phoneControl1.dispose();
    contactControl2.dispose();
    phoneControl2.dispose();
    arabicFacilControl.dispose();
    arabicDescriptionController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(path);

    return progress==0? FutureBuilder<DocumentSnapshot>(
      future: users.doc(id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return OpsError();
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return OpsError();
        }
        if (progress != 0)
          {
            return progressView();
          }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          Project project = new Project.a();
          project.fromMap(data);

          getTexts(project);


          imageList = project.images();
          imageList = HandleList(imageList);
          imageSliders = imageList

              .map((item) => Container(
            margin: EdgeInsets.only(left: 5),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item,
                        errorBuilder:  (context, exception,stackTrace) {
                          return Center(
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/ErrorImage.png"),),
                          );},
                        fit: BoxFit.cover,
                        width: 1000.0,
                        height: (MediaQuery.of(context).size.height >
                            600
                            ? MediaQuery.of(context).size.height * 0.45
                            : 300)),
                  ],
                )),
          ))
              .toList();


          return Scaffold(

            body: ListView(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Stack(alignment: Alignment.bottomCenter, children: [
                  InkWell(child: SliderWithIndicator(imageList),
                    onTap: (){SlideShow(context);},),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 4),
                          child: Text(project.projectName,
                              style:
                              TextStyle(color: Colors.white, fontSize: 25)),
                        ),
                        Divider(thickness: 1.5, color: Colors.grey),
                        InkWell(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0, left: 4, bottom: 4),
                                child: Text(project.developer,
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context) =>
                                  DeveloperView(project.developerId)));

                            }
                        ),
                      ],
                    ),
                  )
                ]), //Images And ProjectName
                Padding(
                  padding: const EdgeInsets.only(
                      left: 6.0, top: 8, right: 6, bottom: 4),
                  child: Text("English Description:",
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      textAlign: TextAlign.left),
                ), //Description head
                Container(
                  margin: EdgeInsets.only(left: 12, right: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
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
                      border: Border.all(
                          color: Colors.grey,
                          width: .5,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextField(
                      controller : descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,

                    ),
                  ),
                ),//Description body
                Padding(
                padding: const EdgeInsets.only(
                    left: 6.0, top: 8, right: 6, bottom: 4),
                child: Text("Arabic Description:",
                    style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    textAlign: TextAlign.left),
              ), //Description head
                Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
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
                    border: Border.all(
                        color: Colors.grey,
                        width: .5,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextField(
                    controller : arabicDescriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
              ),//Description body
                Padding(
                  padding: const EdgeInsets.only(
                      left: 6.0, top: 8, right: 6, bottom: 4),
                  child: Text("English Facilities:",
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      textAlign: TextAlign.left),
                ),//Facilities head
                Container(
                  margin: EdgeInsets.only(left: 12, right: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
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
                      border: Border.all(
                          color: Colors.grey,
                          width: .5,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: facilControl
                    ),
                  ),
                ),//Facilities body
                Padding(
                  padding: const EdgeInsets.only(
                      left: 6.0, top: 8, right: 6, bottom: 4),
                  child: Text("Arabic Facilities:",
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      textAlign: TextAlign.left),
                ),//Facilities head
                Container(
                  margin: EdgeInsets.only(left: 12, right: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
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
                      border: Border.all(
                          color: Colors.grey,
                          width: .5,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: arabicFacilControl,
                    ),
                  ),
                ),//Facilities body
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6.0,
                    top: 12,
                    right: 6,
                  ),
                  child: Text("General Details:",
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      textAlign: TextAlign.left),
                ),//General Detail
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.grey,
                    )),
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
                                child: Text("Project Name: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: projNameControl)
                              )),
            ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("Developer Name: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TextField(controller: DeveloperControl)
                            )),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("Project Area: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TextField(controller: areaControl,)
                            )),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("Location: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                children: [
                                  locationSpinner(),
                                  Flexible(
                                    child: InkWell(
                                      child: Text(
                                        project.locationMap == "0"
                                            ? ""
                                            : "Show \n on map",
                                        textAlign: TextAlign.center,
                                        style: project.locationMap == "0"
                                            ? TextStyle(color: Colors.grey)
                                            : TextStyle(
                                          color: Colors.green,
                                          decoration:
                                          TextDecoration.underline,
                                        ),
                                        softWrap: true,
                                      ),
                                      onTap: () => project.locationMap == "0"
                                          ? null
                                          : launch(project.locationMap),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("Sub Location: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                children: [
                                  subLocationSpinner(),
                                  Flexible(
                                    child: InkWell(
                                      child: Text(
                                        project.locationMap == "0"
                                            ? ""
                                            : "Show \n on map",
                                        textAlign: TextAlign.center,
                                        style: project.locationMap == "0"
                                            ? TextStyle(color: Colors.grey)
                                            : TextStyle(
                                          color: Colors.green,
                                          decoration:
                                          TextDecoration.underline,
                                        ),
                                        softWrap: true,
                                      ),
                                      onTap: () => project.locationMap == "0"
                                          ? null
                                          : launch(project.locationMap),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("Contractor: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: contractControl,)),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("Engenering consultant: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: consultantControl)),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("Finish: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: FinishSpinner(),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  "Load Percent: ",
                                  textAlign: TextAlign.right,
                                ))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: loadControl,)),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  "MasterPlan: ",
                                  textAlign: TextAlign.right,
                                ))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: InkWell(
                                child: Text(
                                    project.masterPlan == "0"
                                        ? "Not Available"
                                        : "Show Master Plan",
                                    style: project.masterPlan == "0"
                                        ? TextStyle(color: Colors.grey)
                                        : TextStyle(
                                        color: Colors.green,
                                        decoration:
                                        TextDecoration.underline)),
                                onTap: () => project.masterPlan == "0"
                                    ? null
                                    : launch(project.masterPlan),
                              )),
                        ),
                      ])
                    ],
                  ),
                ),//General Details Table
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, top: 12, right: 6),
                  child: Text("Financial Details:",
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      textAlign: TextAlign.left),
                ),//Financial Details
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.grey,
                    )),
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
                      0: FixedColumnWidth(95),
                      1: FlexColumnWidth(),
                    },
                    children: <TableRow>[
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("Garage Price: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: garageControl)),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("Club Price: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: clubControl)),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("Maintenance: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: maintControl
                             ,)),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("Cash Discount: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: cashControl)),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  "First Delivery: ",
                                  textAlign: TextAlign.right,
                                ))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: deliverControl)),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("lowestPPM: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: lowestPPMControl
                                  ,)),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("longest Years: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: longestControl)),
                        ),
                      ]),
                    ],
                  ),
                ),//Finanicial details body
                Padding(
                  padding: const EdgeInsets.only(
                      left: 6.0, top: 8, right: 6, bottom: 4),
                  child: Text("Payment Plan:",
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      textAlign: TextAlign.left),
                ),// payment plan
                Container(
                  margin: EdgeInsets.only(left: 12, right: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
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
                      border: Border.all(
                          color: Colors.grey,
                          width: .5,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextField(
                      controller: paymntPlan,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                ),// payment plan body
                Padding(
                  padding: const EdgeInsets.only(
                      left: 6.0, top: 8, right: 6, bottom: 4),
                  child: Text("Current Offer:",
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      textAlign: TextAlign.left),
                ),// current offer head
                Container(
                  margin: EdgeInsets.only(left: 12, right: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
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
                      border: Border.all(
                          color: Colors.grey,
                          width: .5,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      controller: offerControl
                    ),
                  ),
                ),// current offer body
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, top: 12, right: 6),
                  child: Text("Downloads",
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      textAlign: TextAlign.left),
                ),//Financial Details
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.grey,
                    )),
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
                      0: FixedColumnWidth(95),
                      1: FlexColumnWidth(),
                    },
                    children: <TableRow>[
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("Brochure: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: InkWell(
                                      child: Text(
                                        project.brochure == "0"
                                            ? "Not Available"
                                            : "download Brochure",
                                        textAlign: TextAlign.center,
                                        style: project.brochure == "0"
                                            ? TextStyle(color: Colors.grey)
                                            : TextStyle(
                                          color: Colors.green,
                                          decoration:
                                          TextDecoration.underline,
                                        ),
                                        softWrap: true,
                                      ),
                                      onTap: () => project.brochure == "0"
                                          ? null
                                          : launch(project.brochure),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("Inventory Sheet: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: InkWell(
                                      child: Text(
                                        project.redwinnersSheet == "0"
                                            ? "Not Available"
                                            : "download Inventory",
                                        textAlign: TextAlign.center,
                                        style: project.redwinnersSheet == "0"
                                            ? TextStyle(color: Colors.grey)
                                            : TextStyle(
                                          color: Colors.green,
                                          decoration:
                                          TextDecoration.underline,
                                        ),
                                        softWrap: true,
                                      ),
                                      onTap: () => project.redwinnersSheet == "0"
                                          ? null
                                          : launch(project.redwinnersSheet),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("contactPerson1: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: contactControl1
                                  ,)),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("phoneNumber1: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: phoneControl1)),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("contactPerson2: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: contactControl2
                                  )),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("phoneNumber2: ",
                                    textAlign: TextAlign.right))),
                        TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(controller: phoneControl2)),
                        ),
                      ]),

                    ],
                  ),
                ),//Finanicial details body
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text("Last Updated: "+ project.lastUpdate, style: TextStyle(fontSize: 10),),
                ),//contact
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.grey,
                    )),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        decoration: BoxDecoration(

                        ),
                        child: ElevatedButton(

                            onPressed:  () {
                              request.type = project.type;
                              origin == Prevalent.currentOnlineUser.userName? Navigator.push(context, MaterialPageRoute(builder:
                                  (context) =>UnitList(Prevalent.currentOnlineUser.userName+"Units"+project.id, request, "Staff"))): Navigator.push(context, MaterialPageRoute(builder:
                                  (context) =>UnitList(project.id, request, "Staff")));
                            },
                            style:  mainTheme,
                            child: Text( "Show redwinners")),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        decoration: BoxDecoration(

                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context) =>UploadFiles(project)));

                            },
                            style:  mainTheme,
                            child: Text("Upload Files")),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        decoration: BoxDecoration(

                        ),
                        child: ElevatedButton(

                            onPressed: () {
                              saveChanges(project);
                            },
                            style:  mainTheme,
                            child: Text("Save Changes")),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        decoration: BoxDecoration(

                        ),
                        child: ElevatedButton(

                          onPressed: () {

                            getdelte(project, "Enter Admin Password");

                          },
                          style:  mainTheme,
                          child: Text("Release into Database"),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        decoration: BoxDecoration(

                        ),
                        child: ElevatedButton(

                          onPressed: () {

                            GetDelPass(project, "Enter Admin Password");

                          },
                          style:  mainTheme,
                          child: Text("Sold Out"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        decoration: BoxDecoration(

                        ),
                        child: ElevatedButton(

                            onPressed: () {
                              UpdateInventory(project);
                            },
                            style:  mainTheme,
                            child: Text("Create Inventory ")),
                      ),
                    ),

                  ],
                ),

              ])
            ]),
          );
        }

        return Loading();
      },
    ):progressView();
  }
  locationSpinner() {
    return Container(
      width: 150,
      child: DropdownButton<String>(
        hint: Text("Select Location"),
        value: Location,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            subLocation = "Any";
            Location = newValue!;
          });
        },
        items: values.locationEnglish.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  subLocationSpinner() {

    if(Location == "")
      {
        return Container();
      }
    if (Location == "New Cairo")
    {return values.subLocationNewCairoEnglish.length > 1?  Container(
            width: 150,
            child: DropdownButton<String>(
              hint: Text("Select Location"),
              value: subLocation,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  subLocation = newValue!;
                });
              },
              items: values.subLocationNewCairoEnglish.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }
              ).toList(),

            ),
          ) : Container();}
    else if (Location == "October and Zayed")
    {return values.subLocationOctoberZayedEnglish.length > 1?  Container(
            width: 150,
            child: DropdownButton<String>(
              hint: Text("Select Location"),
              value: subLocation,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  subLocation = newValue!;
                });
              },
              items: values.subLocationOctoberZayedEnglish.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }
              ).toList(),

            ),
          )
      :  Container();}
    else if (Location == "El Shrouk")
    {return values.subLocationElShroukEnglish.length > 1?  Container(
            width: 150,
            child: DropdownButton<String>(
              hint: Text("Select Location"),
              value: subLocation,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  subLocation = newValue!;
                });
              },
              items: values.subLocationElShroukEnglish.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }
              ).toList(),

            ),
          )
      :  Container();}
    else if (Location == "New Capital")
    {return values.subLocationNewCapitalEnglish.length > 1?   Container(
            width: 150,
            child: DropdownButton<String>(
              hint: Text("Select Location"),
              value: subLocation,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  subLocation = newValue!;
                });
              },
              items: values.subLocationNewCapitalEnglish.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }
              ).toList(),

            ),
          ):  Container();}
    else if (Location == "North Coast")
    {return values.subLocationNorthCoastEnglish.length > 1?   Container(
            width: 150,
            child: DropdownButton<String>(
              hint: Text("Select Location"),
              value: subLocation,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  subLocation = newValue!;
                });
              },
              items: values.subLocationNorthCoastEnglish.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }
              ).toList(),

            ),
          )
      :  Container();}
    else if (Location == "El Sokhna")
    {return values.subLocationElSokhnaEnglish.length > 1?  Container(
            width:150,
            child: DropdownButton<String>(
              hint: Text("Select Location"),
              value: subLocation,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  subLocation = newValue!;
                });
              },
              items: values.subLocationElSokhnaEnglish.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }
              ).toList(),

            ),
          ):  Container();}
    else if (Location == "EL Mostakbl City")
    {return values.subLocationElMostakblEnglish.length > 1? Container(
            width:150,
            child: DropdownButton<String>(
              hint: Text("Select Location"),
              value: subLocation,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  subLocation = newValue!;
                });
              },
              items: values.subLocationElMostakblEnglish.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }
              ).toList(),

            ),
          ):  Container();}
    else {return Container();}
  //return Container();
  }
//  sublocationSpinner() {
//    return Container(
//      width: 150,
//      child: DropdownButton<String>(
//        hint: Text("Select Location"),
//        value: Location,
//        isExpanded: true,
//        onChanged: (String? newValue) {
//          setState(() {
//            subLocation = "Any";
//            Location = newValue!;
//          });
//        },
//        items: values.location.map<DropdownMenuItem<String>>((String value) {
//          return DropdownMenuItem<String>(
//            value: value,
//            child: Text(value),
//          );
//        }
//        ).toList(),
//
//      ),
//    );
//  }
  FinishSpinner() {
    return Container(
      width: double.infinity,

      child: DropdownButton<String>(
        value: finish,
        isExpanded: true,
        hint: Text("Select Type"),
        onChanged: (String? newValue) {
          setState(() {
            finish = newValue!;
          });
        },
        items: values.finishEnglish.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),
      ),
    );
  }
  List<String> HandleList(List<String> Items) {
    List<String> managedItems = [];
    for (int i = 0; i < Items.length; i++) {
      if (!(Items[i] == "0")) {
        managedItems.add(Items[i]);
      }
    }
    return managedItems;
  }

  void SlideShow(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder:
        (context) =>FullscreenSliderDemo(imageList)));
  }


  void getTexts(Project project) {
    counter++;
    if (counter > 1)
      {
        return;
      }
    area = project.areaInFeddan;
    projName = project.projectName;
    Developer = project.developer;
    description = project.description;
    arabicDescription = project.arabicDescription;
    facil = project.Facilities;
    arabicFacil = project.arabicFacilities;
    contract = project.contractor;
    consultant = project.engineeringConsultant;
    load = project.loadPercent;
    deliver = project.earliestDelivery;
    club = project.clubPrice;
    garage = project.garagePrice;
    maint = project.maintanace;
    cash = project.cashDiscount;
    lowest = project.lowestPPM;
    longest = project.longestYears;
    paymnt = project.paymentPlan;
    offer = project.currentOffer;
    contact = project.contactPerson1;
    phone = project.phoneNumber1;
    contact2 = project.contactPerson2;
    phone2 = project.phoneNumber2;
    Location = project.location;
    subLocation = project.subLocation;
    finish = project.finish;

    descriptionController.text = description;
    arabicDescriptionController.text = arabicDescription;
    areaControl.text = area;
    projNameControl.text = projName;
    DeveloperControl.text = Developer;
     facilControl.text = facil;
     arabicFacilControl.text = arabicFacil;
     contractControl.text = contract;
     consultantControl.text =consultant;
     loadControl.text = load;
     deliverControl.text = deliver;
         clubControl.text = club;
             garageControl.text = garage;
     maintControl.text = maint;
         cashControl.text = cash;
             lowestPPMControl.text = lowest;
                 longestControl.text = longest;
     paymntPlan.text = paymnt;
         offerControl.text = offer;
             contactControl1.text = contact;
                 phoneControl1.text =phone;
                     contactControl2.text = contact2;
     phoneControl2.text = phone2;

  }
  
  void  saveChanges(Project project) async {
    //Decide if From Myprojects or from All Projects
    setState(() {
      progress = 0.5;
    });
    var SourceUnitsQuery;
    CollectionReference sourceUnits;
    CollectionReference destination = FirebaseFirestore.instance.collection(
        Prevalent.currentOnlineUser.userName);
    CollectionReference destinationUnits = FirebaseFirestore.instance.collection(
        Prevalent.currentOnlineUser.userName+"Units"+ project.id);

    if(origin == Prevalent.currentOnlineUser.userName){
      //if myProjects -> saveChanges and keep Everything in Myprojects

      CollectionReference source = FirebaseFirestore.instance.collection(
          Prevalent.currentOnlineUser.userName);
      sourceUnits= FirebaseFirestore.instance.collection(
          Prevalent.currentOnlineUser.userName+"Units"+ project.id);
    }
    else {
      CollectionReference source = FirebaseFirestore.instance.collection(
          "All Projects");
      sourceUnits = FirebaseFirestore.instance.collection(
          project.type+ " units");
      SourceUnitsQuery = await sourceUnits.where("projectID", isEqualTo: project.id).get();

      for(var doc in SourceUnitsQuery.docs)
      {
        await destinationUnits.doc(doc.id).set(doc.data());
      }
        //if all Projects -> savechanges and then put Projects in Myprojects
        //Prompt if there is an update in My Projects then Remove AnyUpdates if Present
    }








    project.areaInFeddan =areaControl.text;
    project.projectName = projNameControl.text;
    project.developer = DeveloperControl.text;
    project.description = descriptionController.text;
    project.arabicDescription= arabicDescriptionController.text;
    project.Facilities = facilControl.text;
    project.arabicFacilities = arabicFacilControl.text;
    project.contractor = contractControl.text;
    project.engineeringConsultant = consultantControl.text;
    project.loadPercent = loadControl.text;
    project.earliestDelivery = deliverControl.text;
    project.clubPrice = clubControl.text;
    project.garagePrice = garageControl.text;
    project.maintanace = maintControl.text;
    project.cashDiscount = cashControl.text;
    project.lowestPPM = lowestPPMControl.text;
    project.longestYears = longestControl.text;
    project.paymentPlan = paymntPlan.text;
    project.currentOffer = offerControl.text;
    project.contactPerson1 = contactControl1.text;
    project.phoneNumber1 = phoneControl1.text;
    project.contactPerson2 = contactControl2.text;
    project.phoneNumber2 = phoneControl2.text;
    project.location = Location;
    project.subLocation = subLocation;
    project.finish = finish;




    var destinationUnitsQuery = await destinationUnits.get();
    for (var doc in destinationUnitsQuery.docs) {
      await doc.reference.update({

        'image0': project.photo1,
        'image1': project.photo2,
        'image2': project.photo3,
        'image3': project.photo4,
        'image4': project.photo5,
        'image5': project.photo6,
        'image6': project.photo7,
        'image7': project.photo8,
        'image8': project.photo9,
        'image9': project.photo10,
        'projectName': project.projectName,
        'developer': project.developer,
        'location': project.location,
        'inLocation': project.subLocation,
        'type': project.type,
        'currentOffer': project.currentOffer,
        'contactPerson1': project.contactPerson1,
        'phoneNumber1': project.phoneNumber1,
        'contactPerson2': project.contactPerson2,
        'phoneNumber2': project.phoneNumber2,
        'paymentPlan': project.paymentPlan,
      });
    }


    destination.doc(project.id).set(project.toMap()).then((value) =>
        showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: const Text('Project Updated'),
                actions: <Widget>[

                  TextButton(
                    onPressed: () =>
                    {

                      Navigator.pop(context),
                      setState(() {
                        progress = 0;
                      }),
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        ),);
  }

  Future<void> releaseIntoDatabase(Project project, bool condition) async {

    setState(() {
        progress = 0.1;
      });

      DateTime now = DateTime.now();
      project.lastUpdate = DateFormat('dd-MMM-yyyy').format(now);
    CollectionReference Projects = FirebaseFirestore.instance.collection(
        "All Projects");
    CollectionReference TypeLocation = FirebaseFirestore.instance.collection(
        project.type);
    CollectionReference TypeLocationUnits = FirebaseFirestore.instance.collection(
        project.type+ " units");
    CollectionReference Developer = FirebaseFirestore.instance.collection(
        project.developerId);
    CollectionReference Units = FirebaseFirestore.instance.collection(
        Prevalent.currentOnlineUser.userName + "Units" + project.id);
    CollectionReference MyProjects = FirebaseFirestore.instance.collection(
        Prevalent.currentOnlineUser.userName);
//    CollectionReference MainUnits = FirebaseFirestore.instance.collection(project.id);

    var querySnapshots = await Units.get();
   //Delete Databse;
    if(condition) {
     await TypeLocationUnits.where("projectID", isEqualTo: project.id).get()
         .then((value) async =>
     {
       for(var doc in value.docs)
         {
           await TypeLocationUnits.doc(doc.id).delete()
         }});
   }
    for (var doc in querySnapshots.docs) {
    //  await MainUnits.doc(doc.id).set(doc.data());
      await TypeLocationUnits.doc(doc.id).set(doc.data());
      doc.reference.delete();
      }

    setState(() {
    progress = 0.5;
});
      Projects.doc(project.id).set(project.toMap()).then((value) =>
          TypeLocation.doc(project.id).set(project.toMap()).then((value) =>
              Developer.doc(project.id).set(project.toMap()).then((value) =>
                MyProjects.doc(project.id).delete().then((value) =>
                      showDialog<String>(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(
                              title: const Text('Project in Database'),
                              actions: <Widget>[

                                TextButton(
                                  onPressed: () =>
                                  {
                                  setState(() {
                                  progress = 0.0;
                                  }),
                                    Navigator.pop(context),
                                    Navigator.pop(context),
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
          )))));

  }

  void GetPass(Project project, String message, bool condition) {
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text(message),
            actions: <Widget>[
              TextField(
                keyboardType: TextInputType.visiblePassword,
                onChanged: (newValue){
                  Pass = newValue;
                },
              ),
              TextButton(
                onPressed: () =>
                {
                  if(Pass == Prevalent.adminUltPass)
                    {
                      Navigator.pop(context),
                      setState(() {
                        progress = 0.05;
                      }),
                      releaseIntoDatabase(project, condition),

                    }
                  else
                    {
                      Navigator.pop(context),
                      GetPass(project,"Wrong Password", condition),
                    },

                },
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () =>
                {
                  Navigator.pop(context),
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }
  void GetDelPass(Project project, String message) {
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text(message),
            actions: <Widget>[
              TextField(
                keyboardType: TextInputType.visiblePassword,
                onChanged: (newValue){
                  Pass = newValue;
                },
              ),
              TextButton(
                onPressed: () =>
                {
                  if(Pass == Prevalent.adminUltPass)
                    {
                      Navigator.pop(context),
                      setState(() {
                        progress = 0.05;
                      }),
                      deletInventory(project),

                    }
                  else
                    {
                      Navigator.pop(context),
                      GetDelPass(project,"Wrong Password"),
                    },

                },
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () =>
                {
                  Navigator.pop(context),
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }

  progressView() {

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: LinearProgressIndicator(

            value: progress,

          ),
        ),
      ),
    );
//    return StreamBuilder<TaskSnapshot>(
//      stream: task.snapshotEvents,
//      builder: (context, snapshot){
//        if(snapshot.hasData) {
//        final snap = snapshot.data;
//        var progress = snap!.bytesTransferred / snap!.totalBytes;
//
//
//        return CircularProgressIndicator(
//          value: progress,
//        );
//        }
//        else
//          {
//            return Container();
//          }
//      },
//    );
  }

  //update attributes of units to the ones in project.
  void UpdateInventory(Project project) async {

    setState(() {
      progress = 0.5;
    });
    CollectionReference AllProjects = FirebaseFirestore.instance.collection(
        Prevalent.currentOnlineUser.userName);
    project.areaInFeddan =areaControl.text;
    project.projectName = projNameControl.text;
    project.developer = DeveloperControl.text;
    project.description = descriptionController.text;
    project.arabicDescription= arabicDescriptionController.text;
    project.Facilities = facilControl.text;
    project.arabicFacilities = arabicFacilControl.text;
    project.contractor = contractControl.text;
    project.engineeringConsultant = consultantControl.text;
    project.loadPercent = loadControl.text;
    project.earliestDelivery = deliverControl.text;
    project.clubPrice = clubControl.text;
    project.garagePrice = garageControl.text;
    project.maintanace = maintControl.text;
    project.cashDiscount = cashControl.text;
    project.lowestPPM = lowestPPMControl.text;
    project.longestYears = longestControl.text;
    project.paymentPlan = paymntPlan.text;
    project.currentOffer = offerControl.text;
    project.contactPerson1 = contactControl1.text;
    project.phoneNumber1 = phoneControl1.text;
    project.contactPerson2 = contactControl2.text;
    project.phoneNumber2 = phoneControl2.text;
    project.location = Location;
    project.subLocation = subLocation;
    project.finish = finish;


    CollectionReference AllUnits = FirebaseFirestore.instance.collection(
        Prevalent.currentOnlineUser.userName+"Units"+ project.id);
    var querySnapshots = await AllUnits.get();
    List<subUnit> subList = [];
    for (var doc in querySnapshots.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      subUnit unit1 = new subUnit.a();
      unit1.fromMap(data);
      subList.add(unit1);
      doc.reference.delete();
        // await doc.reference.update({
      //
      //   'image0': project.photo1,
      //   'image1': project.photo2,
      //   'image2': project.photo3,
      //   'image3': project.photo4,
      //   'image4': project.photo5,
      //   'image5': project.photo6,
      //   'image6': project.photo7,
      //   'image7': project.photo8,
      //   'image8': project.photo9,
      //   'image9': project.photo10,
      //   'projectName': project.projectName,
      //   'developer': project.developer,
      //   'location': project.location,
      //   'inLocation': project.subLocation,
      //   'type': project.type,
      //   'currentOffer': project.currentOffer,
      //   'contactPerson1': project.contactPerson1,
      //   'phoneNumber1': project.phoneNumber1,
      //   'contactPerson2': project.contactPerson2,
      //   'phoneNumber2': project.phoneNumber2,
      //   'paymentPlan': project.paymentPlan,
      // });
    }
    List comList = await project.createProject(subList);
    switch (project.type)
    {
      case "Commercials":
        for (Commercials unit in comList){
          AllUnits.doc(unit.id).set(unit.toMap());
        }
        break;
      case "Administrative offices and clinics":
        for (AdminClinics unit in comList){
          AllUnits.doc(unit.id).set(unit.toMap());
        }
        break;
      case "Chalets":
        for (Chalet unit in comList){
          AllUnits.doc(unit.id).set(unit.toMap());
        }
        break;
      case "Apartments and Duplexes":
        for (Apartments unit in comList){
          AllUnits.doc(unit.id).set(unit.toMap());
        }
        break;
      case "Villas":
        for (Villas unit in comList){
          AllUnits.doc(unit.id).set(unit.toMap());
        }
        break;
      case "Serviced Apartments":
        for (ServicedApartments unit in comList){
          AllUnits.doc(unit.id).set(unit.toMap());
        }
        break;
    }



    AllProjects.doc(project.id).set(project.toMap()).then((value) =>
        showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: const Text('Project Updated'),
                actions: <Widget>[

                  TextButton(
                    onPressed: () =>
                    {

                      Navigator.pop(context),
                      setState(() {
                        progress = 0;
                      }),
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        ),);
  }

  //Delete dublicate units between database and demo database
  void deletInventory(Project project) async {

    setState(() {
      progress = 0.5;


    });

    CollectionReference TypeLocationUnits = FirebaseFirestore.instance.collection(
        project.type+ " units");
    CollectionReference AllUnits = FirebaseFirestore.instance.collection(
        Prevalent.currentOnlineUser.userName+"Units"+ project.id);

    await TypeLocationUnits.where("projectID", isEqualTo: project.id).get()
        .then((value) async => {
    for(var doc in value.docs)
    {
        await TypeLocationUnits.doc(doc.id).delete()
  }}).then((value) =>
        showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: const Text('Project Updated'),
                actions: <Widget>[

                  TextButton(
                    onPressed: () =>
                    {

                      Navigator.pop(context),
                      setState(() {
                        progress = 0;
                      }),
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        ),);


  }

  getdelte(Project project, message) {
    bool del = false;
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text("Delete Current Database"),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                {
                  Navigator.pop(context),
                  del = true,
                  GetPass(project, message , del),

                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () =>
                {
                  Navigator.pop(context),
                  del = false,
                  GetPass(project, "EnterPassword", del),

                },
                child: const Text('No'),
              ),
            ],
          ),
    );
  }
}

class SliderWithIndicator extends StatefulWidget {
  late List<String> images;

  SliderWithIndicator(this.images);

  @override
  _SliderWithIndicatorState createState() => _SliderWithIndicatorState(images);
}

class _SliderWithIndicatorState extends State<SliderWithIndicator> {
  int _current = 0;
  List<String> images;
  _SliderWithIndicatorState(this.images);

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height > 600
          ? MediaQuery.of(context).size.height * 0.45
          : 300),
      child: Stack(alignment: Alignment.bottomCenter, children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              height: (MediaQuery.of(context).size.height > 600
                  ? MediaQuery.of(context).size.height * 0.45
                  : 500),
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black
                          .withBlue(_current == entry.key ? 0 : 255)
                          .withGreen(_current == entry.key ? 0 : 255)
                          .withRed(_current == entry.key ? 0 : 255))),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
