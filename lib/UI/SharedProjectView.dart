import 'package:redwinners/Model/Requests.dart';
import 'package:redwinners/Model/Units.dart';
import 'package:redwinners/UI/UnitList.dart';
import 'package:redwinners/UI/slideShow.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:ui' as ui;
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DeveloperView.dart';
import 'ErrorServerPage.dart';
import 'Loading.dart';
import 'home.dart';
import 'package:flutter/services.dart';

late List<Widget> imageSliders;
late List<String> imageList;

class SharedProjectView extends StatelessWidget {
  String Path, id;
  Requests request;

  SharedProjectView(this.Path, this.id, this.request);
  final oCcy = new NumberFormat("#,###", "en_US");
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(Path);

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return OpsError();
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return OpsError();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          Project project = new Project.a();
          project.fromMap(data);

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
                        height: (MediaQuery.of(context).size.height > 600
                            ? MediaQuery.of(context).size.height * 0.65
                            : 800)),
                  ],
                )),
          ))
              .toList();

          return Scaffold(

            body: Stack(alignment: Alignment.topCenter,

              children: [
                ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Stack(alignment: Alignment.bottomCenter,
                              children: [
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
                              ]),
                          // Container(
                          //   margin: EdgeInsets.only(left: 5, top: 5),
                          //
                          //       color: Colors.black.withOpacity(.5),
                          //       child:  Padding(
                          //         padding: const EdgeInsets.only(left: 15,top: 10, right: 10, bottom: 10),
                          //         child: Icon(Icons.arrow_back_ios, color: Colors.white,),
                          //       ))



                        ],
                      ), //Images And ProjectName
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 6.0, top: 8, right: 6, bottom: 4),
                        child: Text("Description:",
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
                          child: ReadMoreText(
                            project.arabic?
                            (project.arabicDescription == "0"?project.description: project.arabicDescription)
                                :(project.description == "0"?project.arabicDescription :project.description),
                            textDirection: project.arabic?
                            (project.arabicDescription == "0"?ui.TextDirection.ltr:ui.TextDirection.rtl)
                                :(project.description == "0"?ui.TextDirection.rtl:ui.TextDirection.ltr),
                            trimLines: 3,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            style: Alltheme.textTheme.bodyText2,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                          ),
                        ),
                      ),//Description body
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 6.0, top: 8, right: 6, bottom: 4),
                        child: Text("Facilities:",
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
                          child: ReadMoreText(
                            project.arabic?project.arabicFacilities:project.Facilities,
                            textDirection: project.arabic?ui.TextDirection.rtl:ui.TextDirection.ltr,
                            trimLines: 3,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            style: Alltheme.textTheme.bodyText2,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
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
                                      child: Text("Location: ",
                                          textAlign: TextAlign.right))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Row(
                                      children: [
                                        Flexible(child: Text(project.location + " - " + project.subLocation)),
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
                                      child: Text("Area: ",
                                          textAlign: TextAlign.right))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(project.areaInFeddan)),
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
                                    child: Text(project.engineeringConsultant)),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text("Finish: ",
                                          textAlign: TextAlign.right))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(project.finish)),
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
                                    child: Text(project.garagePrice == "0"?"Not Existing":project.garagePrice)),
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
                                    child: Text(project.clubPrice == "0"?"Not Existing":project.clubPrice)),
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
                                    child: Text(project.maintanace)),
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
                                    child: Text(project.cashDiscount)),
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
                                    child: Text(int.parse(project.earliestDelivery) <= 0?"Immediately": project.earliestDelivery+ " years")),
                              ),
                            ]),
                          ],
                        ),
                      ),//Finanicial details body
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: project.type == "Villas" || project.type == "Chalets" || project.type == "Serviced Apartments"?Text("Prices Starts from " + project.lowestPPM + " L.E. and instalments are up to "
                            + project.longestYears + " years"):Text("Prices Start from " + project.lowestPPM + " L.E. per meter and instalments are up to "
                            + project.longestYears + " years"),
                      ),//ppm
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
                          child: ReadMoreText(
                            project.paymentPlan,
                            textDirection: ui.TextDirection.ltr,
                            trimLines: 3,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            style: Alltheme.textTheme.bodyText2,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                          ),
                        ),
                      ),// payment plan body
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

                    ]),
                appHeadWithBack(project.projectName, Icons.business, false, context),
              ],
            ),
          );
        }

        return Loading();
      },
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
          ? MediaQuery.of(context).size.height * 0.65
          : 800),
      child: Stack(alignment: Alignment.bottomCenter, children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              height: (MediaQuery.of(context).size.height > 600
                  ? MediaQuery.of(context).size.height * 0.65
                  : 800),
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
