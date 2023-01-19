import 'package:redwinners/Model/Units.dart';
import 'package:redwinners/UI/slideShow.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'dart:ui' as ui;
import 'package:url_launcher/url_launcher.dart';

import '../engines/prevelant.dart';
import 'ErrorServerPage.dart';
import 'Loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:redwinners/Model/values.dart';

late List<Widget> imageSliders;
late List<String> imageList;

class UnitView extends StatelessWidget {
  String Path, id, type;


  UnitView(this.Path, this.id, this.type);

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);
    final oCcy = new NumberFormat("#,###", "en_US");
    var variableGarden; var variableRooms;
    var projectName = ""; var price; var cashDiscount; var cashPrice; var area;
    var RoomNumber = ""; var Finish = ""; var apType = ""; var Floor = ""; var Delivery = "";
    var Garden = ""; bool Roof = false; var Maint = ""; var load = ""; var PaymentPlan = "";
    var CurrentOffer = ""; var ContactPerson = ""; var number ="";
    CollectionReference Unit = FirebaseFirestore.instance.collection(Path);

    return FutureBuilder<DocumentSnapshot>(
      future: Unit.doc(id).get(),
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
          switch (type) {
            case "Apartments and Duplexes":
              Apartments unit = new Apartments.a();
              unit.fromMap(data);
              imageList = unit.images();
              imageList = HandleList(imageList);
              price = unit.price;
              projectName = unit.projectName; cashDiscount = unit.cashDiscount; cashPrice = unit.cashPrice;
              area = unit.bua; RoomNumber = unit.rooms; Finish = unit.finish; Floor = unit.floor; Delivery = getDelivery(unit.delivery, context);
              Garden = unit.garden.toString();Roof = unit.roofBool; Maint = unit.maintenance; load = unit.loadPercent;
              PaymentPlan = unit.paymentPlan; CurrentOffer = unit.currentOffer; ContactPerson = unit.contactPerson1;
              number = unit.phoneNumber1;
              apType = unit.apartmentType;
              variableGarden = "Garden Area";
              variableRooms = "Rooms";
              break;
            case "Villas":
              Villas unit = new Villas.a();
              unit.fromMap(data);
              imageList = unit.images();
              imageList = HandleList(imageList);
              projectName = unit.projectName; cashDiscount = unit.cashDiscount; cashPrice = unit.cashPrice;
              area = unit.bua; RoomNumber = unit.rooms; Finish = unit.finish; apType = unit.villaType; Delivery = getDelivery(unit.delivery, context);
              Garden = unit.landArea.toString();Roof = true; Maint = unit.maintenance; load = "Not Existing";
              PaymentPlan = unit.paymentPlan; CurrentOffer = unit.currentOffer; ContactPerson = unit.contactPerson1;
              number = unit.phoneNumber1;price = unit.price;
              variableGarden = "Land Area";
              variableRooms = "Rooms";
              break;
            case "Serviced Apartments":
              ServicedApartments unit = new ServicedApartments.a();
              unit.fromMap(data);
              imageList = unit.images();
              imageList = HandleList(imageList);
              projectName = unit.projectName; cashDiscount = unit.cashDiscount; cashPrice = unit.cashPrice;
              area = unit.bua; Finish = unit.finish;  Delivery = getDelivery(unit.delivery, context);
               Maint = unit.maintenance; load = unit.loadPercent;
              PaymentPlan = unit.paymentPlan; CurrentOffer = unit.currentOffer; ContactPerson = unit.contactPerson1;
              number = unit.phoneNumber1;price = unit.price;
              variableRooms="";
              variableGarden="";
              //rooms, floor, garden, roof
              break;
            case "Chalets":
              Chalet unit = new Chalet.a();
              unit.fromMap(data);
              imageList = unit.images();
              imageList = HandleList(imageList);
              price = unit.price;
              projectName = unit.projectName; cashDiscount = unit.cashDiscount; cashPrice = unit.cashPrice;
              area = unit.bua; RoomNumber = unit.rooms; Finish = unit.finish; Floor = unit.floor; Delivery = getDelivery(unit.delivery, context);
              Garden = unit.garden.toString();Roof = unit.roofBool; Maint = unit.maintenance; load = unit.loadPercent;
              PaymentPlan = unit.paymentPlan; CurrentOffer = unit.currentOffer; ContactPerson = unit.contactPerson1;
              number = unit.phoneNumber1;
              variableGarden = "Garden Area";
              variableRooms = "Rooms";
              break;
            case "Commercials":
              Commercials unit= new Commercials.a();
              unit.fromMap(data);
              imageList = unit.images();
              imageList = HandleList(imageList);
              projectName = unit.projectName; cashDiscount = unit.cashDiscount; cashPrice = unit.cashPrice;
              area = unit.bua; RoomNumber = double.parse(unit.outdoorArea).round().toString(); Finish = unit.finish; Floor = unit.floor; Delivery = getDelivery(unit.delivery, context);
              Garden = unit.ppm.toString(); Maint = unit.maintenance; load = unit.loadPercent;
              PaymentPlan = unit.paymentPlan; CurrentOffer = unit.currentOffer; ContactPerson = unit.contactPerson1;
              number = unit.phoneNumber1;price = unit.price;
              apType = unit.subType;
              variableGarden = "Meter Price";
              variableRooms = "OutDoors Area";
              //roof
              break;
            case "Administrative offices and clinics":
              AdminClinics unit = new AdminClinics.a();
              unit.fromMap(data);
              imageList = unit.images();
              imageList = HandleList(imageList);
              projectName = unit.projectName; cashDiscount = unit.cashDiscount; cashPrice = unit.cashPrice;
              area = unit.bua; Finish = unit.finish; Floor = unit.floor; Delivery = getDelivery(unit.delivery, context);
              Garden = unit.ppm ; Maint = unit.maintenance; load = unit.loadPercent;
              PaymentPlan = unit.paymentPlan; CurrentOffer = unit.currentOffer; ContactPerson = unit.contactPerson1;
              number = unit.phoneNumber1;price = unit.price;
              variableGarden = "Meter Price";
              variableRooms = "";
              //rooms, roof;
              break;
          }



          imageSliders = imageList.map((item) => Container(
                    margin: EdgeInsets.only(left: 5),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                          children: <Widget>[
                            Image.network(item,
                                fit: BoxFit.cover,
                                errorBuilder: (context, exception,stackTrace) {
                                  return Center(
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/ErrorImage.png"),),
                                  );},

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
                appHeadWithBack(projectName, Icons.business, false, context),
                Expanded(
                  child: ListView(
                      padding: EdgeInsets.all(0),
                      children: [
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
                                child: Text(loc!.unitId + id,
                                    style:
                                        TextStyle(color: Colors.white, fontSize: 25)),
                              ),
                              Divider(thickness: 1.5, color: Colors.grey),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0, left: 4, bottom: 4),
                                child: Text(projectName,
                                    style: TextStyle(color: Colors.white)),
                              )
                            ],
                          ),
                        )
                      ]), //Images And ProjectName

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
                      ), //General Detail
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
                                      child: Text(loc.price,
                                          textAlign: TextAlign.right))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(oCcy.format(price)),
                              ),
                              )
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(loc.cashDiscount,
                                          textAlign: TextAlign.right))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(cashDiscount)),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(loc.cashPrice,
                                          textAlign: TextAlign.right))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(oCcy.format(cashPrice))),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(loc.area,
                                          textAlign: TextAlign.right))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(area.toString() + loc!.m2)),
                              ),
                            ]),


                              TableRowRoom(variableRooms,RoomNumber,loc.roomsCount),

                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(loc.finish,
                                          textAlign: TextAlign.right))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(values.arabictranslatefinish(Finish))),
                              ),
                            ]),
                            type == "Apartments and Duplexes"||type == "Commercials"||type == "Villas"? TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(loc.types,
                                          textAlign: TextAlign.right))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(values.arabictranslateapartmentType(apType) )),
                              ),
                            ]):TableRow(
                  children: [
                                TableCell(child: Container(),),
                                  TableCell(child: Container(),),
                  ]),
                            TableRowFloore(Floor,loc.floor),

                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        loc.deliver,
                                        textAlign: TextAlign.right,
                                      ))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(Delivery)),
                              ),
                            ])
                          ],
                        ),
                      ), //General Details Table
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0, top: 12, right: 6),
                        child: Text(loc!.financialDetails,
                            style:
                                TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                      ), //Financial Details
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
                            TableRowGarden(variableGarden,Garden,loc.garden),

                            TableRowRoof(Roof, loc.roof),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(loc.maintenance,
                                          textAlign: TextAlign.right))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(Maint)),
                              ),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(loc.loadPercent,
                                          textAlign: TextAlign.right))),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(load)),
                              ),
                            ]),
                          ],
                        ),
                      ), //Finanicial details body
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 6.0, top: 8, right: 6, bottom: 4),
                        child: Text(loc.paymentPlan,
                            style:
                                TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                      ), // payment plan
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
                            PaymentPlan,
                            textDirection: ui.TextDirection.ltr,
                            trimLines: 3,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            style: Alltheme.textTheme.bodyText2,
                            trimCollapsedText: loc.showMore,
                            trimExpandedText: loc.showLess,
                          ),
                        ),
                      ), // payment plan body
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 6.0, top: 8, right: 6, bottom: 4),
                        child: Text(loc.currentOffer,
                            style:
                                TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                      ), // current offer head
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
                            CurrentOffer,
                            textDirection: ui.TextDirection.ltr,
                            trimLines: 3,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            style: Alltheme.textTheme.bodyText2,
                            trimCollapsedText: loc.showMore,
                            trimExpandedText: loc.showLess,
                          ),
                        ),
                      ), // current offer body
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                            loc.forMoreDetails + ContactPerson + loc.on + reversePhone(number)),
                      ), //contact
                      Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Divider(
                            thickness: 1.5,
                            color: Colors.grey,
                          )),

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

  void SlideShow(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder:
        (context) =>FullscreenSliderDemo(imageList)));
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

   TableRowRoom(String vari, String RoomNu, loc) {
     if(type != "Serviced Apartments" && type != "Administrative offices and clinics" )
     {
      return TableRow(children: [
        TableCell(
            child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(loc,
                    textAlign: TextAlign.right))),
        TableCell(
          child: Padding(
              padding: const EdgeInsets.all(3.0),
              child:
              Text(RoomNu)),
        ),
      ]);
    }
    else
      {
        return TableRow(
            children: [
              TableCell(child: Container(),),
              TableCell(child: Container(),),
            ]);
      }
   }

  TableRowRoof(bool roof,roofe) {
    if(type != "Serviced Apartments" && type != "Administrative offices and clinics" && type != "Commercials") {
      return TableRow(children: [
        TableCell(
            child: Padding(
                padding: const EdgeInsets.all(3.0),
                child:
                Text(roofe, textAlign: TextAlign.right))),
        TableCell(
          child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(roof == true
                  ? "Present"
                  : "absent")),
        ),
      ]);
    }
    else{
      return TableRow(
          children: [
            TableCell(child: Container(),),
            TableCell(child: Container(),),
          ]);
    }
  }

  TableRowFloore(String floor, loc) {
    if(type != "Serviced Apartments" && type != "Villas") {
      return TableRow(children: [
        TableCell(
            child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  loc,
                  textAlign: TextAlign.right,
                ))),
        TableCell(
          child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: type==values.typeEnglish[0]?Text(values.arabictranslatefloorApartment(floor)):
                      type==values.typeEnglish[3]?Text(values.arabictranslatefloorApartment(floor)):
                      type==values.typeEnglish[4]?Text(values.arabictranslatefloorCommercial(floor)):
                      Text(floor)),
        ),
      ]);
    }
else {
      return TableRow(
          children: [
        TableCell(child: Container(),),
            TableCell(child: Container(),),
      ]);
    }
  }

  TableRowGarden(String variableGarden, String garden, loc) {
    final oCcy = new NumberFormat("#,###", "en_US");
    if(type != "Serviced Apartments") {
      return TableRow(children: [
        TableCell(
            child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(loc,
                    textAlign: TextAlign.right))),
        TableCell(
          child: Padding(
              padding: const EdgeInsets.all(3.0),
              child:
              Text(garden + " meter")),
        ),
      ]);
    }
    else {      return TableRow(
        children: [
          TableCell(child: Container(),),
          TableCell(child: Container(),),
        ]);}
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
  String getDelivery(String delivery, context) {
    var loc = AppLocalizations.of(context);
    String Deliv = "Immediately";
    if(int.parse(delivery) <= 0)
      {Deliv = "Immediately";}
    else
      {
        Deliv = delivery + loc!.years;
      }
return Deliv;
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
