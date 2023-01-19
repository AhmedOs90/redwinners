import 'package:redwinners/Model/Requests.dart';
import 'package:redwinners/Model/Units.dart';
import 'package:redwinners/UI/UnitList.dart';
import 'package:redwinners/UI/slideShow.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:redwinners/Model/values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:ui' as ui;
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'DeveloperView.dart';
import 'ErrorServerPage.dart';
import 'Loading.dart';
import 'home.dart';

late List<Widget> imageSliders;
late List<String> imageList;

class ProjectView extends StatelessWidget {

  String Path, id;
  Requests request;

  ProjectView(this.Path, this.id, this.request);
  final oCcy = new NumberFormat("#,###", "en_US");
  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);
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
                                height: (MediaQuery.of(context).size.height >
                                        600
                                    ? MediaQuery.of(context).size.height * 0.45
                                    : 300)),
                          ],
                        )),
                  ))
              .toList();

          return Scaffold(

            body: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appHeadWithBack(project.projectName, Icons.business, false, context),
                
                Expanded(
                  child: ListView(
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
                        child: Text(loc!.description,
                            style:
                                TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                            ),
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
                            trimCollapsedText: loc!.showMore,
                            trimExpandedText: loc!.showLess,
                          ),
                        ),
                      ),//Description body
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 6.0, top: 8, right: 6, bottom: 4),
                        child: Text(loc!.facilities,
                            style:
                                TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                           ),
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
                            trimCollapsedText: loc!.showMore,
                            trimExpandedText: loc!.showLess,
                          ),
                        ),
                      ),//Facilities body
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 6.0,
                          top: 12,
                          right: 6,
                        ),
                        child: Text(loc!.generalDetails,
                            style:
                                TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                            ),
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
                                      child: Text(loc!.location,
                                          textAlign: TextAlign.right))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Row(
                                      children: [
                                        Flexible(child: Text(values.arabictranslateLocation(project.location) + " - " +
                                            values.arabictranslatesubLocation(project.subLocation, project.location))),
                                        Flexible(
                                          child: InkWell(
                                            child: Text(
                                              project.locationMap == "0"
                                                  ? ""
                                                  : loc!.show+ "\n" +loc!.onMap,
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
                                      child: Text(loc!.area,
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
                                      child: Text(loc!.contractor,
                                          textAlign: TextAlign.right))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(project.contractor)),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(loc!.engineerCons,
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
                                      child: Text(loc!.finish,
                                          textAlign: TextAlign.right))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(values.arabictranslatefinish(project.finish))),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        loc!.loadPercent,
                                        textAlign: TextAlign.right,
                                      ))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(project.loadPercent)),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        loc!.masterPlan,
                                        textAlign: TextAlign.right,
                                      ))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: InkWell(
                                      child: Text(
                                          project.masterPlan == "0"
                                              ? loc!.notAvailable
                                              : loc!.showMasterPlan,
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
                        child: Text(loc!.financialDetails,
                            style:
                                TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                            ),
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
                                      child: Text(loc!.garagePrice,
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
                                      child: Text(loc!.clubPrice,
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
                                      child: Text(loc!.maintenance,
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
                                      child: Text(loc!.cashDiscount,
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
                                        loc!.firstDelivery,
                                        textAlign: TextAlign.right,
                                      ))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(int.parse(project.earliestDelivery) <= 0?loc!.immediat: project.earliestDelivery+ loc.years)),
                              ),
                            ]),
                          ],
                        ),
                      ),//Finanicial details body
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: project.type == "Villas" || project.type == "Chalets" || project.type == "Serviced Apartments"?
                        Text(loc!.pricesStartFrom + project.lowestPPM
                        +loc!.andInst
                           + project.longestYears + loc!.years):
                        Text(loc!.pricesStartFrom + project.lowestPPM +
                            loc!.perMeterAndInst
                            + project.longestYears + loc.years),
                      ),//ppm
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 6.0, top: 8, right: 6, bottom: 4),
                        child: Text(loc!.paymentPlan,
                            style:
                            TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                            ),
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
                            trimCollapsedText: loc!.showMore,
                            trimExpandedText: loc!.showLess,
                          ),
                        ),
                      ),// payment plan body
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 6.0, top: 8, right: 6, bottom: 4),
                        child: Text(loc.currentOffer,
                            style:
                            TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                            ),
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
                          child: ReadMoreText(
                            project.currentOffer,
                            textDirection: ui.TextDirection.ltr,
                            trimLines: 3,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            style: Alltheme.textTheme.bodyText2,
                            trimCollapsedText: loc!.showMore,
                            trimExpandedText: loc!.showLess,
                          ),
                        ),
                      ),// current offer body
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0, top: 12, right: 6),
                        child: Text(loc!.download,
                            style:
                            TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                            ),
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
                                      child: Text(loc!.brochure,
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
                                                  ? loc!.notAvailable
                                                  : loc!.downloadBrochure,
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
                                      child: Text(loc!.inventoryShit,
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
                                                  ? loc!.notAvailable
                                                  : loc!.downloadInventory,
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

                          ],
                        ),
                      ),//Finanicial details body
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: project.contactPerson2 =="0"&&project.phoneNumber2 !="0"?
                        Text(loc!.forMoreDetails + project.contactPerson1 + " "+ loc!.on
                            + " " +reversePhone(project.phoneNumber1) +
                            loc!.or +reversePhone(project.phoneNumber2) + ".")
                            :Text(loc!.forMoreDetails + project.contactPerson1 +
                            loc!.on +reversePhone(project.phoneNumber1) +"."),
                      ),//contact
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: project.contactPerson2 =="0"?Container():Text(loc.or + project.contactPerson2+" on " + project.phoneNumber2 + "."),
                      ),//contact
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(loc.lastUpdate+ reverseLast(project.lastUpdate), style: TextStyle(fontSize: 10),),
                      ),//contact
                      Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Divider(
                            thickness: 1.5,
                            color: Colors.grey,
                          )),
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20, bottom: 2),
                                decoration: BoxDecoration(
                                ),
                                child: ElevatedButton(

                                    onPressed: () {
                                      request.type = project.type;
                                      Navigator.push(context, MaterialPageRoute(builder:
                                          (context) =>UnitList(project.id, request
                                          , "User")));
                                    },
                                    style:  mainTheme,
                                    child: Text(loc!.showredwinners)),

                              ),
                            ),
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20, bottom: 2),
                                decoration: BoxDecoration(
                                ),
                                child: ElevatedButton(

                                    onPressed: () async {
                                      String Code = Prevalent.getRandomString(15);
                                      await FirebaseFirestore.instance.collection("sharing").doc(Code).set({
                                        "code":Code,
                                        "expire":DateTime.now().add(Duration(hours: 6))
                                      });
                                      await Clipboard.setData(ClipboardData(text: "https://www.red_winners.net"+"?projID="+project.id+"&code="+Code)).then((value) =>
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text(loc!.linkCopied),
                                          )));
                                    },
                                    style:  mainTheme,
                                    child: Text(loc!.shareProject)),

                              ),
                            ),
                          ],
                        ),
                        project.redwinnersSheet == "0"?Padding(
                          padding: const EdgeInsets.only(left: 25.0, right: 12,bottom: 20),
                          child: Text(loc.avaInThis,style: TextStyle(fontSize: 12)),
                        ):Container()

                  ]),
                ),
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

  String reversePhone(String phoneNumber1) {
    List<String> arr;
    if(Prevalent.local == "en")
      return phoneNumber1;
    else {
        arr = phoneNumber1.split(" ");

        return arr.join();
    }
  }

  String reverseLast(String lastUpdate) {
    List<String> arr;
    if(Prevalent.local == "en")
      return lastUpdate;
    else {
      if(lastUpdate.contains("Jan")) {
        lastUpdate.replaceAll("Jan", "يناير");
      }
      else if(lastUpdate.contains("Feb")) {
        lastUpdate = lastUpdate.replaceAll("Feb", "فبراير");
      } else if(lastUpdate.contains("Mar")) {
        lastUpdate = lastUpdate.replaceAll("Mar", "مارس");
      } else if(lastUpdate.contains("Apr")) {
        lastUpdate = lastUpdate.replaceAll("Apr", "ابريل");
      } else if(lastUpdate.contains("May")) {
        lastUpdate = lastUpdate.replaceAll("May", "مايو");
      } else if(lastUpdate.contains("Jun")) {
        lastUpdate = lastUpdate.replaceAll("Jun", "يونيو");
      } else if(lastUpdate.contains("Jul")) {
        lastUpdate = lastUpdate.replaceAll("Jul", "يوليو");
      } else if(lastUpdate.contains("Aug")) {
        lastUpdate = lastUpdate.replaceAll("Aug", "اغسطس");
      } else if(lastUpdate.contains("Sep")) {
        lastUpdate = lastUpdate.replaceAll("Sep", "سبتمبر");
      } else if(lastUpdate.contains("Oct")) {
        lastUpdate = lastUpdate.replaceAll("Oct", "اكتوبر");
      } else if(lastUpdate.contains("Nov")) {
        lastUpdate =         lastUpdate.replaceAll("Nov", "نوفمبر");
      } else if(lastUpdate.contains("Dec")) {
        lastUpdate = lastUpdate.replaceAll("Dec", "ديسمبر");
      }
      return lastUpdate;
    }
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
