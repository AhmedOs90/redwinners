import 'package:redwinners/Model/Requests.dart';
import 'package:redwinners/UI/Projectlist.dart';
import 'package:redwinners/UI/UnitList.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:redwinners/Model/values.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class UnitFilter extends StatefulWidget {
  Requests Request;
  String Path;
  UnitFilter(this.Path, this.Request);

  @override
  _UnitFilterState createState() => _UnitFilterState(Path, Request);
}

class _UnitFilterState extends State<UnitFilter> {
  String path;
  Requests requests;
  _UnitFilterState(this.path, this.requests);
  var Years = 0;
  var Ppm = "All";
  var comPPM = "All";
  var adminPPM = "All";
  var area = "All";
  var rooms = "All";
  var floor = "All";
  var deliveryText = "All";
  var delivery = "All";
  var Finish = "All";
  var bua = "All";
  var VillaType = "All";
  var ApartmentType = "All";
  var villarooms = "All";
  var LandArea = "All";
  var challetarea = "All";
  var challetRooms = "All";
  var areaComercial = "All";
  var ServiceArea = "All";
  var outDoorsArea = "All";
  var floorComercial = "All";
  var AreaAdmin = "All";
  late var PaymentSerach = "Installments";
  var priceStart = 0;
  var priceEnd = 0;
  var comType = "All";
  var adminType = "All";
    int counter = 0;
  final priceStartController = TextEditingController();
  final priceEndController = TextEditingController();

  List<bool> _selection = [true, false];
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    priceStartController.dispose();
    priceEndController.dispose();
    super.dispose();
  }
  static List<String> subTypeCommercial = values.subTypeCommercial();
  static List<String> subTypeAdmin = values.subTypeAdmin();
  static List<String> ppm = values.ppm();
  static List<String> roomsNo = values.roomsNo();
  static List<String> roomsVillaNo = values.roomsVillaNo();
  static List<String> roomsChaletNo = values.roomsChaletNo();
  static List<String> deliveredIn = values.deliveredIn();
  static List<String> finish = values.finish();
  static List<String> villaBUA = values.villaBUA();
  static List<String> pricePerMeterCom = values.pricePerMeterCom();
  static List<String> floorCommercial = values.floorCommercial();
  static List<String> floorApartment = values.floorApartment();
  static List<String> apartmentType = values.apartmentType();
  static List<String> pricePerMeterAdmin = values.pricePerMeterAdmin();
  static List<String> areaAdmin = values.areaAdmin();
  static List<String> areaCommercial = values.areaCommercial();
  static List<String> yesNo = values.yesNo();
  static List<String> areaApartment = values.areaApartment();
  static List<String> areaChalet = values.areaChalet();
  static List<String> landArea = values.landArea();
  static List<String> serviceArea = values.serviceArea();
  static List<String> villaType = values.typeVilla();

  @override
  Widget build(BuildContext context) {
    getIntialValues();
    if(counter == 0) {
      Years = requests.payment.longestYears;

      switch (requests.delivery)
      {
        case "All":
          deliveryText = "All";
          break;
        case "1/1/2022":
          deliveryText = "Immediate Delivery";
          break;
        case "1/1/2023":
          deliveryText = "1 year";
          break;
        case "1/1/2024":
          deliveryText = "2 years";
          break;
        case "1/1/2025":
          deliveryText = "3 years";
          break;
        case "1/1/2026":
          deliveryText = "4 years";
          break;
      }
      deliveryText= values.arabictranslatedelivery(deliveryText);
      Finish = values.arabictranslatefinish(requests.finish);
      if(requests.payment.paymentSearch == "Cash") {
        PaymentSerach = "Cash";
       _selection = [false,true];

      }
      priceStart = requests.payment.priceStart;
      priceEnd = requests.payment.priceEnd;
      priceStartController.text = priceStart == 0? "":priceStart.toString();
      priceEndController.text = priceEnd == 0? "":priceEnd.toString();
      switch (requests.type) {
        case "Apartments and Duplexes":
          Ppm = values.arabictranslateppm(requests.apPPm);
          print("area: "+requests.apArea);
          area = values.arabictranslateareaApartment(requests.apArea);
          print("area: "+area);
          ApartmentType = values.arabictranslateapartmentType(requests.aptype);
          rooms = values.arabictranslateroomsNo(requests.apRooms);
          floor = values.arabictranslatefloorApartment(requests.apFloor);
          break;

        case "Serviced Apartments":
          ServiceArea = values.arabictranslateserviceArea(requests.sAArea);
          break;

        case "Villas":
          bua = values.arabictranslatevillaBUA(requests.viArea);
          VillaType = values.arabictranslatevillaType(requests.viType);
          villarooms = values.arabictranslateroomsVillaNo(requests.viRooms);
          LandArea = values.arabictranslatelandArea(requests.viLandArea);
          break;

        case "Chalets":
          floor = values.arabictranslatefloorApartment(requests.chFloor);
          challetarea = values.arabictranslateareaChalet(requests.chArea);
          challetRooms = values.arabictranslateroomsChaletNo(requests.chRooms);
          break;

        case "Commercials":
          comPPM = values.arabictranslatpricePerMeterCom(requests.comPPM);
          areaComercial = values.arabictranslateareaCommercial(requests.comArea);
          outDoorsArea =values.arabictranslateyesNo(requests.comOutdoorsArea);
          floorComercial = values.arabictranslatefloorCommercial(requests.comFloor);
          comType = values.arabictranslatesubTypeCommercial(requests.comType);
          break;

        case "Administrative offices and clinics":
          adminPPM = values.arabictranslatepricePerMeterAdmin(requests.adminPPM);
          AreaAdmin =values.arabictranslateareaAdmin(requests.adminArea);
          adminType = values.arabictranslatesubTypeAdmin(requests.adminType);
      }
    counter++;
    }

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Icon(Icons.arrow_back_ios,size: 20,),
          ),
          onTap: (){
            Navigator.of(context).maybePop();
          },
        ),
        backgroundColor: Colors.redAccent.shade700,
        title: Text("Filter"),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(12),
        child: ListView(
            children: [ Column(
                children: [
                  Center(
                    child:
                    ToggleButtons(
                      children: [
                        Container(child: Center(child: Text(AppLocalizations.of(context)!.installments)),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .35),
                        Container(child: Center(child: Text(AppLocalizations.of(context)!.cash)),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .35),
                      ],
                      isSelected: _selection,
                      borderRadius: BorderRadius.circular(50),
                      fillColor: Colors.redAccent.shade700,
                      selectedColor: Colors.white,
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
                        });
                      },),


                  ),
                  PaymentView(_selection),
                  SpinnersOfUnitTypes(requests.type),
                  Container(
                      margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          showResults();
                        },
                        style: mainTheme,
                        child: Text("Show Results"),)),
                ]),
            ]
        ),
      ),
    );
  }

  PaymentView(List<bool> selection) {
    if (selection[0] == true) {
      PaymentSerach = "Installments";
      return InstallmentsPayment();
    }
    else if (selection[1] == true) {
      PaymentSerach = "Cash";
      return InstallmentsPayment();
    }
    else {
      return Text("error");
    }
  }
  Cash() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade700,
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 5.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 6),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.totalCashPrice,
              style: TextStyle(fontWeight: FontWeight.bold),),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.from),
                Expanded(child: TextField()),
                Text(AppLocalizations.of(context)!.to),
                Expanded(child: TextField()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SpinnersOfUnitTypes(String type) {
    switch (type) {
      case "Apartments and Duplexes" :
        return ApartmentsSpinner();
      case "شقق ودوبلكسات" :
        return ApartmentsSpinner();
      case "Serviced Apartments":
        return ServicedApartmentsSpinner();
      case "شقق فندقية":
        return ServicedApartmentsSpinner();
      case "Villas":
        return VillaSpinner();
      case "فيلات":
        return VillaSpinner();
      case "Chalets":
        return ChaletSpinner();
      case "شاليهات":
        return ChaletSpinner();
      case "Commercials":
        return CommercialSpinner();
      case "محلات تجارية":
        return CommercialSpinner();
      case "Administrative offices and clinics":
        return AdminSpinner();
      case "مكاتب ادارية وعيادات":
        return AdminSpinner();
    }
  }

  InstallmentsPayment() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade700,
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 5.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 6),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(PaymentSerach == "Cash"?AppLocalizations.of(context)!.totalCashPrice: AppLocalizations.of(context)!.totalPrice, style: TextStyle(fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text(AppLocalizations.of(context)!.from),
                  Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: priceStartController,
                      )),
                  Text(AppLocalizations.of(context)!.to),
                  Expanded(child: TextField(
                    keyboardType: TextInputType.number,
                      controller: priceEndController,
                  )),
                ],
              ),
            ),
//            PaymentSerach=="Cash"?Container():Padding(
//              padding: const EdgeInsets.only(top: 8.0),
//              child: Text("Years of Installments",),
//            ),
//            PaymentSerach=="Cash"?Container():Padding(
//              padding: const EdgeInsets.only(left: 12.0),
//              child: yearsOfInstallmentsSpinner(),
//            ),
          ],
        ),
      ),
    );
  }
  void showResults() {
    priceStart = priceStartController.text.isEmpty? 0:int.parse(priceStartController.text);
    priceEnd = priceEndController.text.isEmpty? 0:int.parse(priceEndController.text);
    switch (requests.type) {
      case "Apartments and Duplexes":
        Payment payment = Payment(PaymentSerach, priceStart, priceEnd, Years);
        Requests request = Requests.ap(
            requests.type,
            requests.location,
            requests.subLocation,
            delivery,
            values.translateppm(Ppm),
            values.translatefinish(Finish),
            values.translateareaApartment(area),
            values.translateroomsNo(rooms),
            values.translateapartmentType(ApartmentType),
            values.translatefloorApartment(floor),
            payment);
        print(payment.paymentSearch);
        print(payment.priceStart.toString());
        print(payment.priceEnd.toString());
        print(payment.longestYears.toString());
        print(requests.type);
        print(requests.location);
        print(requests.subLocation);
        print("delivery: " + delivery);
        print(values.translateppm(Ppm));
        print(values.translatefinish(Finish));
        print(values.translateareaApartment(area));
        print(values.translateroomsNo(rooms));
        print(values.translateapartmentType(ApartmentType));
        print(values.translatefloorApartment(floor));
        Prevalent.request = request;
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder:
            (context) =>UnitList(path, request, "")));
        break;
      case "Serviced Apartments":
        Payment payment = Payment(PaymentSerach, priceStart, priceEnd, Years);
        Requests request = Requests.SA(
            values.translatetype(requests.type),
            values.translateLocation(requests.location),
            values.translatesubLocation(requests.subLocation, values.translateLocation(requests.location)),
            delivery,
            values.translatefinish(Finish),
            values.translateserviceArea(ServiceArea),
            payment);
        Prevalent.request = request;
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder:
            (context) =>UnitList(path, request, "")));
        break;

      case "Villas":
        Payment payment = Payment(PaymentSerach, priceStart, priceEnd, Years);
        Requests request = Requests.vi(
            values.translatetype(requests.type),
            values.translateLocation(requests.location),
            values.translatesubLocation(requests.subLocation, values.translateLocation(requests.location)),
            values.translatedelivery(delivery),
            values.translatefinish(Finish),
            values.translatevillaBUA(bua),
            values.translatelandArea(LandArea),
            values.translateroomsVillaNo(villarooms),
            values.translatevillaType(VillaType), payment);
        Prevalent.request = request;
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder:
            (context) =>UnitList(path, request, "")));
        break;

      case "Chalets":

        Payment payment = Payment(
            PaymentSerach, priceStart, priceEnd, Years);
        Requests request = Requests.ch(
            values.translatetype(requests.type),
            values.translateLocation(requests.location),
            values.translatesubLocation(requests.subLocation, values.translateLocation(requests.location)),
            values.translatedelivery(delivery),
            values.translatefinish(Finish),
            values.translateareaChalet(challetarea),
            values.translatefloorApartment(floor),
            values.translateroomsChaletNo(challetRooms),
            payment);
        Prevalent.request = request;
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder:
            (context) =>UnitList(path, request, "")));
        break;

      case "Commercials":
        Payment payment = Payment(PaymentSerach, priceStart, priceEnd, Years);
        Requests request = Requests.com(
            values.translatetype(requests.type),
            values.translateLocation(requests.location),
            values.translatesubLocation(requests.subLocation, values.translateLocation(requests.location)),
            values.translatedelivery(delivery),
            values.translatefinish(Finish),
            values.translateareaCommercial(areaComercial),
            values.translatefloorCommercial(floorComercial),
            values.translatpricePerMeterCom(comPPM),
            values.translateyesNo(outDoorsArea),
            values.translatesubTypeCommercial(comType),payment);
        Prevalent.request = request;
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder:
            (context) =>UnitList(path, request,"")));
        break;

      case "Administrative offices and clinics":
        Payment payment = Payment(PaymentSerach, priceStart, priceEnd, Years);
        Requests request = Requests.admin(
            values.translatetype(requests.type),
            values.translateLocation(requests.location),
            values.translatesubLocation(requests.subLocation, values.translateLocation(requests.location)),
            values.translatedelivery(delivery),
            values.translatefinish(Finish),
            values.translateareaAdmin(AreaAdmin),
            values.translatepricePerMeterAdmin(adminPPM),
            values.translatesubTypeAdmin(adminType), payment);
        Prevalent.request = request;
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder:
            (context) =>UnitList(path, request,"")));
        break;
    }

  }


  //region Spinners
  ApartmentsSpinner() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade700,
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 5.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 12),
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.builtUpArea),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: AreaApartmentSpinner(),
            ),
            Text(AppLocalizations.of(context)!.priceMeter),

            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: PriecPerMeterApartmentSpinner(),
            ),
            Text(AppLocalizations.of(context)!.unitType),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: ApartmentTypeSpinner(),
            ),

            Text(AppLocalizations.of(context)!.roomsCount),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: RoomNumberApartmentSpinner(),
            ),
            Text(AppLocalizations.of(context)!.floor),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: FloorApartmentSpinner(),
            ),
            Text(AppLocalizations.of(context)!.deliver),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: DeliverySpinner(),
            ),
            Text(AppLocalizations.of(context)!.finish),
            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: FinishSpinner()
            ),
          ],
        ),
      ),
    );
  }

  ServicedApartmentsSpinner() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade700,
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 5.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 12),
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.builtUpArea),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: SAAreaSpinner(),
            ),
            Text(AppLocalizations.of(context)!.deliver),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: DeliverySpinner(),
            ),
            Text(AppLocalizations.of(context)!.finish),
            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: FinishSpinner()
            ),
          ],
        ),
      ),
    );
  }

  VillaSpinner() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade700,
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 5.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 12),
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.builtUpArea),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: VillaBUASpinner(),
            ),
            Text(AppLocalizations.of(context)!.land),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: LandAreaVillaSpinner(),
            ),
            Text(AppLocalizations.of(context)!.villaType),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: VillaTypeSpinner(),),
            Text(AppLocalizations.of(context)!.roomsCount),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: RoomsVillaSpinner(),),
            Text(AppLocalizations.of(context)!.deliver),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: DeliverySpinner(),),
            Text(AppLocalizations.of(context)!.finish),
            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: FinishSpinner()),
          ],
        ),
      ),
    );
  }

  ChaletSpinner() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade700,
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 5.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 12),
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.builtUpArea),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: AreaChaletSpinner(),),
            Text(AppLocalizations.of(context)!.roomsCount),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: RoomNumberChaletSpinner(),),
            Text(AppLocalizations.of(context)!.floor),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: FloorChaletSpinner(),),
            Text(AppLocalizations.of(context)!.deliver),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: DeliverySpinner(),),
            Text(AppLocalizations.of(context)!.finish),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: FinishSpinner(),)
          ],
        ),
      ),
    );
  }

  CommercialSpinner() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade700,
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 5.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 12),
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.builtUpArea),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: AreaCommercialSpinner(),),
            Text(AppLocalizations.of(context)!.unitType),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: CommercialTypeSpinner(),),
            Text(AppLocalizations.of(context)!.priceMeter),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: PriecPerMeterComSpinner(),),
            Text(AppLocalizations.of(context)!.outdoorArea),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: OutDoorsAreaSpinner(),),
            Text(AppLocalizations.of(context)!.floor),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: FloorCommercialSpinner(),),
            Text(AppLocalizations.of(context)!.deliver),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: DeliverySpinner(),),
            Text(AppLocalizations.of(context)!.finish),
            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: FinishSpinner()),
          ],
        ),
      ),
    );
  }

  AdminSpinner() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade700,
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 5.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 12),
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.builtUpArea),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: AreaAdminSpinner(),),
            Text(AppLocalizations.of(context)!.unitType),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: AdminTypeSpinner(),),
            Text(AppLocalizations.of(context)!.priceMeter),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: PriecPerMeterAdminSpinner(),),

            Text(AppLocalizations.of(context)!.deliver),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: DeliverySpinner(),),
            Text(AppLocalizations.of(context)!.finish),
            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: FinishSpinner()),
          ],
        ),
      ),
    );
  }





  AreaApartmentSpinner() {
    print("area3 : "+area);
    return Container(
      width: double.infinity,

      child: DropdownButton<String>(
        value: area,
        isExpanded: true,
        hint: Text("Select area range"),
        onChanged: (String? newValue) {
          setState(() {
            area = newValue!;
          });
        },
        items: areaApartment.map<DropdownMenuItem<String>>((
            String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  PriecPerMeterApartmentSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Price of Meter"),
        value: Ppm,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            Ppm = newValue!;
          });
        },
        items: ppm.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }

  @override
  void initState() {
    Prevalent.checkInProtocol(context);
  }

  ApartmentTypeSpinner() {

    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Any"),
        value: ApartmentType,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            ApartmentType = newValue!;

          });
        },
        items: apartmentType.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  RoomNumberApartmentSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Select "),
        value: rooms,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            rooms = newValue!;
          });
        },
        items: roomsNo.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  FloorApartmentSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Any"),
        value: floor,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            floor = newValue!;
          });
        },
        items: floorApartment.map<DropdownMenuItem<String>>((
            String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  DeliverySpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        value: deliveryText,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            delivery = values.translatedelivery(newValue!);
            delivery = getDelivery(delivery);
            print("Delivery :" +delivery);

            deliveryText = newValue!;
          });
        },
        items: deliveredIn.map<DropdownMenuItem<String>>((
            String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  FinishSpinner() {
    return Container(
      width: double.infinity,

      child: DropdownButton<String>(
        value: Finish,
        isExpanded: true,
        hint: Text("Select Type"),
        onChanged: (String? newValue) {
          setState(() {
            Finish = newValue!;
          });
        },
        items: finish.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }

  SAAreaSpinner() {
    return Container(
      width: double.infinity,

      child: DropdownButton<String>(
        value: ServiceArea,
        isExpanded: true,
        hint: Text("Select Type"),
        onChanged: (String? newValue) {
          setState(() {
            ServiceArea = newValue!;
          });
        },
        items: serviceArea.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }

  VillaBUASpinner() {
    return Container(
      width: double.infinity,

      child: DropdownButton<String>(
        value: bua,
        isExpanded: true,
        hint: Text("Select Type"),
        onChanged: (String? newValue) {
          setState(() {
            bua = newValue!;
          });
        },
        items: villaBUA.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  RoomsVillaSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Select Location"),
        value: villarooms,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            villarooms = newValue!;
          });
        },
        items: roomsVillaNo.map<DropdownMenuItem<String>>((
            String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  VillaTypeSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Any Years"),
        value: VillaType,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            VillaType = newValue!;
          });
        },
        items: villaType.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  LandAreaVillaSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Price of Meter"),
        value: LandArea,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            LandArea = newValue!;
          });
        },
        items: landArea.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }

  AreaChaletSpinner() {
    return Container(
      width: double.infinity,

      child: DropdownButton<String>(
        value: challetarea,
        isExpanded: true,
        hint: Text("Select Type"),
        onChanged: (String? newValue) {
          setState(() {
            challetarea = newValue!;
          });
        },
        items: areaChalet.map<DropdownMenuItem<String>>((
            String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  RoomNumberChaletSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Select Location"),
        value: challetRooms,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            challetRooms = newValue!;
          });
        },
        items: roomsChaletNo.map<DropdownMenuItem<String>>((
            String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  FloorChaletSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Any Years"),
        value: floor,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            floor = newValue!;
          });
        },
        items: floorApartment.map<DropdownMenuItem<String>>((
            String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }

  AreaCommercialSpinner() {
    return Container(
      width: double.infinity,

      child: DropdownButton<String>(
        value: areaComercial,
        isExpanded: true,
        hint: Text("Select Type"),
        onChanged: (String? newValue) {
          setState(() {
            areaComercial = newValue!;
          });
        },
        items: areaCommercial.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  CommercialTypeSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Select Type"),
        value: comType,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            comType = newValue!;
          });
        },
        items: subTypeCommercial.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  PriecPerMeterComSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Price of Meter"),
        value: comPPM,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            comPPM = newValue!;
          });
        },
        items: pricePerMeterCom.map<DropdownMenuItem<String>>((
            String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  OutDoorsAreaSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Select Location"),
        value: outDoorsArea,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            outDoorsArea = newValue!;
          });
        },
        items: yesNo.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  FloorCommercialSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Any Years"),
        value: floorComercial,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            floorComercial = newValue!;
          });
        },
        items: floorCommercial.map<DropdownMenuItem<String>>((
            String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }

  AreaAdminSpinner() {
    return Container(
      width: double.infinity,

      child: DropdownButton<String>(
        value: AreaAdmin,
        isExpanded: true,
        hint: Text("Select Type"),
        onChanged: (String? newValue) {
          setState(() {
            AreaAdmin = newValue!;
          });
        },
        items: areaAdmin.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  AdminTypeSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Select Type"),
        value: adminType,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            adminType = newValue!;
          });
        },
        items: subTypeAdmin.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
  PriecPerMeterAdminSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Price of Meter"),
        value: adminPPM,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            adminPPM = newValue!;
          });
        },
        items: pricePerMeterAdmin.map<DropdownMenuItem<String>>((
            String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }
//endregion

  String getDelivery(String? newValue) {
    DateTime now = DateTime.now();
    String xy = now.toString().substring(5, 7);
    int x = int.parse(xy);
    if (x > 9)
      x = 1;
    else
      x = 0;
    String year = DateFormat("yyyy").parse(now.toString()).toString().substring(0,4);

    int Year = int.parse(year);
    Year = Year + x;
    switch (newValue)
    {
      case "Immediate Delivery":
        return "1/1/" + Year.toString();
      case "1 year":
        return "1/1/" + (++Year).toString();
      case "2 years":
        return "1/1/" + (Year+2).toString();
      case "3 years":
        return "1/1/" + (Year+3).toString();
      case "4 years":
        return "1/1/" + (Year+4).toString();
      default: {
        return "All";
      }
    }


  }

  getIntialValues(){
    int y = 0;
    ApartmentType == "All"||ApartmentType =="الكل"?ApartmentType = AppLocalizations.of(context)!.any:y = 0;
    deliveryText == "All"||deliveryText =="الكل"?deliveryText = AppLocalizations.of(context)!.any:y = 0;
    Ppm == "All"||Ppm =="الكل"?Ppm = AppLocalizations.of(context)!.any:y = 0;
    comPPM == "All"||comPPM =="الكل"?comPPM = AppLocalizations.of(context)!.any:y = 0;
    adminPPM == "All"||adminPPM =="الكل"?adminPPM = AppLocalizations.of(context)!.any:y = 0;
    area == "All"||area =="الكل"?area = AppLocalizations.of(context)!.any:y = 0;
    rooms == "All"||rooms =="الكل"?rooms = AppLocalizations.of(context)!.any:y = 0;
    floor == "All"||floor =="الكل"?floor = AppLocalizations.of(context)!.any:y = 0;
    Finish == "All"||Finish =="الكل"?Finish = AppLocalizations.of(context)!.any:y = 0;
    bua == "All"||bua =="الكل"?bua = AppLocalizations.of(context)!.any:y = 0;
    VillaType == "All"||VillaType =="الكل"?VillaType = AppLocalizations.of(context)!.any:y = 0;
    ApartmentType == "All"||ApartmentType =="الكل"?ApartmentType = AppLocalizations.of(context)!.any:y = 0;
    villarooms == "All"||villarooms =="الكل"?villarooms = AppLocalizations.of(context)!.any:y = 0;
    LandArea == "All"||LandArea =="الكل"?LandArea = AppLocalizations.of(context)!.any:y = 0;
    challetarea == "All"||challetarea =="الكل"?challetarea = AppLocalizations.of(context)!.any:y = 0;
    challetRooms == "All"||challetRooms =="الكل"?challetRooms = AppLocalizations.of(context)!.any:y = 0;
    areaComercial == "All"||areaComercial =="الكل"?areaComercial = AppLocalizations.of(context)!.any:y = 0;
    ServiceArea == "All"||ServiceArea =="الكل"?ServiceArea = AppLocalizations.of(context)!.any:y = 0;
    outDoorsArea == "All"||outDoorsArea =="الكل"?outDoorsArea = AppLocalizations.of(context)!.any:y = 0;
    floorComercial == "All"||floorComercial =="الكل"?floorComercial = AppLocalizations.of(context)!.any:y = 0;
    AreaAdmin == "All"||AreaAdmin =="الكل"?AreaAdmin = AppLocalizations.of(context)!.any:y = 0;
    PaymentSerach == "Installments"||PaymentSerach =="تقسيط"?PaymentSerach = AppLocalizations.of(context)!.installments:y = 0;
    comType == "All"||comType =="الكل"?comType = AppLocalizations.of(context)!.any:y = 0;
    adminType == "All"||adminType =="الكل"?adminType = AppLocalizations.of(context)!.any:y = 0;
     subTypeCommercial = values.subTypeCommercial();
     subTypeAdmin = values.subTypeAdmin();
     ppm = values.ppm();
     roomsNo = values.roomsNo();
     roomsVillaNo = values.roomsVillaNo();
     roomsChaletNo = values.roomsChaletNo();
     deliveredIn = values.deliveredIn();
     finish = values.finish();
     villaBUA = values.villaBUA();
     pricePerMeterCom = values.pricePerMeterCom();
     floorCommercial = values.floorCommercial();
     floorApartment = values.floorApartment();
     apartmentType = values.apartmentType();
     pricePerMeterAdmin = values.pricePerMeterAdmin();
     areaAdmin = values.areaAdmin();
     areaCommercial = values.areaCommercial();
     yesNo = values.yesNo();
     areaApartment = values.areaApartment();
     areaChalet = values.areaChalet();
     landArea = values.landArea();
     serviceArea = values.serviceArea();
     villaType = values.typeVilla();

  }
}
