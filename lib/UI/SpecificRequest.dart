
import 'package:redwinners/Model/Requests.dart';
import 'package:redwinners/UI/Projectlist.dart';
import 'package:redwinners/UI/UnitList.dart';
import 'package:redwinners/UI/scheme.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:redwinners/Model/values.dart';
import 'package:intl/intl.dart';

import 'browse.dart';
import 'home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SpecificRequest extends StatefulWidget {
  @override
  _SpecificRequestState createState() => _SpecificRequestState();
}

class _SpecificRequestState extends State<SpecificRequest> {
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
      title: const Text('Exit Red Winners'),
      content: const Text('Do you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('Yes'),
        ),
      ],
    );
  }

  var Type = 'Apartments and Duplexes';
  var Location = null;
  var Years = "All";
  var deliveryText  = "All";
  var PPM = "All";
  var comPPM  = "All";
  var adminPPM  = "All";
  var area  = "All";
  var rooms  = "All";
  var floor  = "All";
  var delivery  = "All";
  var Finish = "All";
  var bua  = "All";
  var VillaType = "All";
  var ApartmentType = "All";
  var apartmentTypeReturned = "All";
  var villarooms  = "All";
  var LandArea = "All";
  var challetarea = "All";
  var challetRooms  = "All";
  var areaComercial = "All";
  var ServiceArea = "All";
  var outDoorsArea = "All";
  var floorComercial = "All";
  var AreaAdmin = "All";
  var PaymentSerach = "Installments";
  var priceStart = 0;
  var priceEnd = 0;
  var subLocation = "All";
  var comType = "All";
  var adminType =  "All";
  var longestYears = 0;
  final priceStartController = TextEditingController();
  final priceEndController = TextEditingController();
  static List<String> location = values.location();
  static List<String> subLocationNewCapital = values.subLocationNewCapital();
  static List<String> subLocationNewCairo = values.subLocationNewCairo();
  static List<String> subLocationOctoberZayed = values.subLocationOctoberZayed();
  static List<String> subLocationNorthCoast = values.subLocationNorthCoast();
  static List<String> subLocationElSokhna = values.subLocationElSokhna();
  static List<String> subLocationElShrouk = values.subLocationElShrouk();
  static List<String> subLocationElMostakbl = values.subLocationElMostakbl();
  static List<String> type = values.type();
  static List<String> subTypeCommercial = values.subTypeCommercial();
  static List<String> subTypeAdmin = values.subTypeAdmin();
  static List<String> years = values.years();
  static List<String> ppm = values.ppm();
  static List<String> roomsNo = values.roomsNo();
  static List<String> roomsVillaNo = values.roomsVillaNo();
  static List<String> roomsChaletNo = values.roomsChaletNo();
  static List<String> deliveredIn = values.deliveredIn();
  static List<String> finish = values.finish();
  static List<String> apartmentsPrice = values.apartmentsPrice();
  static List<String> villaPrice = values.villaPrice();
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


  List<bool> _selection = [true, false];
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    priceStartController.dispose();
    priceEndController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      Prevalent.local = Prevalent.local;
    });
    int y = 0;
    getIntialValues();
    int _selectedIndex = 3;
    return WillPopScope(
        onWillPop: () async {
          return _onWillPop(context);
        },
      child: Scaffold(

//      appBar: AppBar(
//        title: Text("Specific Request"),
//      ),
        body: Column(

          children: [
            appHead(AppLocalizations.of(context)!.request,Icons.manage_search, true, context),
            Expanded(
                child: Container(margin: EdgeInsets.all(8),
                  child: ListView(

                        children: [
                          Column(
                            children: [
                              typeSpinner(),
                              locationSpinner(),
                              subLocationSpinner(),
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
                              SpinnersOfUnitTypes(Type),
                              Container(
                                  margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showResults();
                                    },
                                    style: mainTheme,
                                    child: Text(AppLocalizations.of(context)!.showResult),)),
                            ]),
                        ]
                    ),
                ),

              ),


          ],
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
          currentIndex: _selectedIndex,
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
            PaymentSerach=="Cash"?Container():Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(AppLocalizations.of(context)!.yearsOfInstallments),
            ),
            PaymentSerach=="Cash"?Container():Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: yearsOfInstallmentsSpinner(),
            ),
          ],
        ),
      ),
    );
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


  typeSpinner() {

    return Container(
      width: double.infinity,

      child: DropdownButton<String>(
        value: Type,
        isExpanded: true,
        hint: Text("Select Type"),
        onChanged: (String? newValue) {
          setState(() {
            Type = newValue!;
          });
        },
        items: type.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }

  locationSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text(AppLocalizations.of(context)!.selectLocation),
        value: Location,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            subLocation = "All";
            Location = newValue!;
          });
        },
        items: location.map<DropdownMenuItem<String>>((String value) {
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
    String coommon = values.translateLocation(Location);
    print(coommon);
      if (coommon == "New Cairo")
        {
          return subLocationNewCairo.length > 1?  Column( mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text("Sub Location"),
            ),
             Padding(
               padding: const EdgeInsets.only(left: 8.0),
               child: Container(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    hint: Text("Select Location"),
                    value: subLocation,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        subLocation = newValue!;
                      });
                    },
                    items: subLocationNewCairo.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }
                    ).toList(),

                  ),
                ),
             ),

          ],
        ):  Container();}
      else if (coommon == "October and Zayed")
        {
          return subLocationOctoberZayed.length > 1?  Column( mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Sub Location"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                width: double.infinity,
                child: DropdownButton<String>(
                  hint: Text("Select Location"),
                  value: subLocation,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      subLocation = newValue!;
                    });
                  },
                  items: subLocationOctoberZayed.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }
                  ).toList(),

                ),
              ),
            ),

          ],
        ):  Container();}
      else if (coommon == "El Shrouk")
        {
          return subLocationElShrouk.length > 1?  Column( mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Sub Location"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                width: double.infinity,
                child: DropdownButton<String>(
                  hint: Text("Select Location"),
                  value: subLocation,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      subLocation = newValue!;
                    });
                  },
                  items: subLocationElShrouk.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }
                  ).toList(),

                ),
              ),
            ),

          ],
        ):  Container();}
      else if (coommon == "New Capital")
        {
          return subLocationNewCapital.length > 1?  Column( mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Sub Location"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                width: double.infinity,
                child: DropdownButton<String>(
                  hint: Text("Select Location"),
                  value: subLocation,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      subLocation = newValue!;
                    });
                  },
                  items: subLocationNewCapital.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }
                  ).toList(),

                ),
              ),
            ),

          ],
        ):  Container();}
      else if (coommon == "North Coast")
        {
          return subLocationNorthCoast.length > 1?  Column( mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Sub Location"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                width: double.infinity,
                child: DropdownButton<String>(
                  hint: Text("Select Location"),
                  value: subLocation,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      subLocation = newValue!;
                    });
                  },
                  items: subLocationNorthCoast.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }
                  ).toList(),

                ),
              ),
            ),

          ],
        ):  Container();}
      else if (coommon == "El Sokhna")
        {
          return subLocationElSokhna.length > 1?  Column( mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Sub Location"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                width: double.infinity,
                child: DropdownButton<String>(
                  hint: Text("Select Location"),
                  value: subLocation,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      subLocation = newValue!;
                    });
                  },
                  items: subLocationElSokhna.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }
                  ).toList(),

                ),
              ),
            ),

          ],
        ):  Container();}
      else if (coommon == "EL Mostakbl City")
        {
          return subLocationElMostakbl.length > 1?  Column( mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Sub Location"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                width: double.infinity,
                child: DropdownButton<String>(
                  hint: Text("Select Location"),
                  value: subLocation,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      subLocation = newValue!;
                    });
                  },
                  items: subLocationElMostakbl.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }
                  ).toList(),

                ),
              ),
            ),

          ],
        ):  Container();}
      else {return Container();}
    }

  yearsOfInstallmentsSpinner() {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        hint: Text("Any Years"),
        value: Years,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            switch(newValue)
            {
              case "Any Years":
                longestYears = 0;
                break;
                case "more than 12 years":
                longestYears = 12;
                break;
                case "more than 9 years":
                longestYears = 9;
                break;
                case "more than 7 years":
                longestYears = 7;
                break;
                case "more than 5 years":
                longestYears = 5;
                break;
                case "more than 3 years":
                longestYears = 3;
                break;
            }



            Years = newValue!;
          });
        },
        items: years.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList(),

      ),
    );
  }


  AreaApartmentSpinner() {
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
        value: PPM,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            PPM = newValue!;
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
            print(delivery);

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

  void showResults() {
    priceStartController.text.isEmpty?priceStart = 0:priceStart= int.parse(priceStartController.text);
    priceEndController.text.isEmpty?priceEnd = 0:priceEnd = int.parse(priceEndController.text);

    if (Type != null )
      {
        if(priceEnd != 0){
        if(priceEnd < priceStart)
          {
            showDialog<String>(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text("Invalid Arguments"),
                      content: Text("The start price should be lower than end price"),
                      actions: <Widget>[

                        TextButton(
                          onPressed: () =>
                          {
                            Navigator.pop(context),


                          },
                          child: const Text('Ok'),
                        ),
                      ],
                    ));
            return;
          }
        }
          String Typ = values.translatetype(Type);
        switch (Typ) {
            case "Apartments and Duplexes":
              Payment payment = Payment(
                  PaymentSerach, priceStart, priceEnd, longestYears);
              Requests request = Requests.ap(
                  values.translatetype(Type),
                  values.translateLocation(Location),
                  values.translatesubLocation(subLocation, values.translateLocation(Location)),
                  delivery,
                  values.translateppm(PPM),
                  values.translatefinish(Finish),
                  values.translateareaApartment(area),
                  values.translateroomsNo(rooms),
                  values.translateapartmentType(ApartmentType),
                  values.translatefloorApartment(floor),
                  payment);

              Navigator.push(context, MaterialPageRoute(builder:
                  (context) =>
                  ProjectList(
                      values.translatetype(Type) + " units",values.translatetype(Type),
                      request, "Specific")));
              break;
            case "Serviced Apartments":
              Payment payment = Payment(
                  PaymentSerach, priceStart, priceEnd, longestYears);
              Requests request = Requests.SA(
                  values.translatetype(Type),
                  values.translateLocation(Location),
                  values.translatesubLocation(subLocation, values.translateLocation(Location)),
                  delivery,
                  values.translatefinish(Finish),
                  values.translateserviceArea(ServiceArea),
                  payment);

              Navigator.push(context, MaterialPageRoute(builder:
                  (context) =>
                  ProjectList(
                      values.translatetype(Type) + " units",values.translatetype(Type),
                      request,"Specific")));
              break;

            case "Villas":
              Payment payment = Payment(
                  PaymentSerach, priceStart, priceEnd, longestYears);
              Requests request = Requests.vi(
                  values.translatetype(Type),
                  values.translateLocation(Location),
                  values.translatesubLocation(subLocation, values.translateLocation(Location)),
                  delivery,
                  values.translatefinish(Finish),
                  values.translatevillaBUA(bua),
                  values.translatelandArea(LandArea),
                  values.translateroomsVillaNo(villarooms),
                  values.translatevillaType(VillaType),
                  payment);

              Navigator.push(context, MaterialPageRoute(builder:
                  (context) =>
                  ProjectList(
                      values.translatetype(Type) + " units", values.translatetype(Type),
                      request, "Specific")));
              break;

            case "Chalets":
              Payment payment = Payment(
                  PaymentSerach, priceStart, priceEnd, longestYears);
              Requests request = Requests.ch(
                  values.translatetype(Type),
                  values.translateLocation(Location),
                  values.translatesubLocation(subLocation, values.translateLocation(Location)),
                  delivery,
                  values.translatefinish(Finish),
                  values.translateareaChalet(challetarea),
                  values.translatefloorApartment(floor),
                  values.translateroomsChaletNo(challetRooms),
                  payment);

              Navigator.push(context, MaterialPageRoute(builder:
                  (context) =>
                  ProjectList(
                      values.translatetype(Type) + " units", values.translatetype(Type),
                      request,"Specific")));
              break;

            case "Commercials":
              Payment payment = Payment(
                  PaymentSerach, priceStart, priceEnd, longestYears);
              Requests request = Requests.com(
                  values.translatetype(Type),
                  values.translateLocation(Location),
                  values.translatesubLocation(subLocation, values.translateLocation(Location)),
                  delivery,
                  values.translatefinish(Finish),
                  values.translateareaCommercial(areaComercial),
                  values.translatefloorCommercial(floorComercial),
                  values.translatpricePerMeterCom(comPPM),
                  values.translateyesNo(outDoorsArea),
                  values.translatesubTypeCommercial(comType),
                  payment);
              Navigator.push(context, MaterialPageRoute(builder:
                  (context) =>
                  ProjectList(
                      values.translatetype(Type) + " units", values.translatetype(Type),
                      request,"Specific")));
              break;

            case "Administrative offices and clinics":
              Payment payment = Payment(
                  PaymentSerach, priceStart, priceEnd, longestYears);
              Requests request = Requests.admin(
                  values.translatetype(Type),
                  values.translateLocation(Location),
                  values.translatesubLocation(subLocation, values.translateLocation(Location)),
                  delivery,
                  values.translatefinish(Finish),
                  values.translateareaAdmin(AreaAdmin),
                  values.translatepricePerMeterAdmin(adminPPM),
                  values.translatesubTypeAdmin(adminType),
                  payment);
              print(request.type);
              print(request.adminType);
              print(request.location);
              print(request.subLocation);
              print(request.finish);
              print(request.adminArea);
              print(request.delivery);
              print(request.adminPPM);
              Navigator.push(context, MaterialPageRoute(builder:
                  (context) =>
                  ProjectList(
                      values.translatetype(Type) + " units", values.translatetype(Type),
                      request,"Specific")));
              break;
          }


      }
    else {
      showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) =>
              AlertDialog(
                title: const Text("Specify Type and Location"),
                content: Text("You need to choose a type and location."),
                actions: <Widget>[

                  TextButton(
                    onPressed: () =>
                    {
                      Navigator.pop(context)

                    },
                    child: const Text('Ok'),
                  ),
                ],
              ));
    }
  }


  void _onItemTapped(int value) {
    if(value == 0)
    {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
          (context) => Home()), (route) => false);
    }
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

  }

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

// //region translators
//   String translateLocation(value) {
//     String ret = "All";
//     for (int i = 0; i < location.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == location[i])
//         ret = values.locationEnglish[i];
//     }
//     return ret;
//   }
//   String translatesubLocation(String value, String locat){
//     String sublo = "All";
//
//
//     switch(locat)
//     {
//       case "New Cairo":
//         sublo = translatesubLocationNewCairo(value);
//         break;
//       case "October and Zayed":
//         sublo = translatesubLocationOctoberZayed(value);
//         break;
//       case "New Capital":
//         sublo = translatesubLocationNewCapital(value);
//         break;
//       case "North Coast":
//         sublo = translatesubLocationNorthCoast(value);
//         break;
//       case "El Sokhna":
//         sublo = translatesubLocationElSokhna(value);
//         break;
//       default:
//         sublo = "All";
//         break;
//
//     }
//     return sublo;
//
//   }
//   String translatetype(String value) {
//     String ret = "All";
//     for (int i = 0; i < type.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == type[i])
//         ret = values.typeEnglish[i];
//     }
//     return ret;
//   }
//   String translatesubTypeCommercial(String value) {
//     String ret = "All";
//     for (int i = 0; i < subTypeCommercial.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == subTypeCommercial[i])
//         ret = values.subTypeCommercialEnglish[i];
//     }
//     return ret;
//   }
//   String translatesubTypeAdmin(String value) {
//     String ret = "All";
//     for (int i = 0; i < subTypeAdmin.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == subTypeAdmin[i])
//         ret = values.subTypeAdminEnglish[i];
//     }
//     return ret;
//   }
//   String translateyears(String value) {
//     String ret = "All";
//     for (int i = 0; i < years.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == years[i])
//         ret = values.yearsEnglish[i];
//     }
//     return ret;
//   }
//   String translateppm(String value) {
//     String ret = "All";
//     for (int i = 0; i < ppm.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == ppm[i])
//         ret = values.ppmEnglish[i];
//     }
//     return ret;
//   }
//   String translateroomsNo(String value) {
//     String ret = "All";
//     for (int i = 0; i < roomsNo.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == roomsNo[i])
//         ret = values.roomsNoEnglish[i];
//     }
//     return ret;
//   }
//   String translateroomsVillaNo(String value) {
//     String ret = "All";
//     for (int i = 0; i < roomsVillaNo.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == roomsVillaNo[i])
//         ret = values.roomsVillaNoEnglish[i];
//     }
//     return ret;
//   }
//   String translateroomsChaletNo(String value) {
//     String ret = "All";
//     for (int i = 0; i < roomsChaletNo.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == roomsChaletNo[i])
//         ret = values.roomsChaletNoEnglish[i];
//     }
//     return ret;
//   }
//   String translatedelivery(String value) {
//     String ret = "All";
//     for (int i = 0; i < deliveredIn.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == deliveredIn[i])
//         ret = values.deliveredInEnglish[i];
//     }
//     return ret;
//   }
//   String translatefinish(String value) {
//     String ret = "All";
//     for (int i = 0; i < finish.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == finish[i])
//         ret = values.finishEnglish[i];
//     }
//     return ret;
//   }
//   String translateapartmentsPrice(String value) {
//     String ret = "All";
//     for (int i = 0; i < apartmentsPrice.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == apartmentsPrice[i])
//         ret = values.apartmentsPriceEnglish[i];
//     }
//     return ret;
//   }
//   String translatevillaPrice(String value) {
//     String ret = "All";
//     for (int i = 0; i < villaPrice.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == villaPrice[i])
//         ret = values.villaPriceEnglish[i];
//     }
//     return ret;
//   }
//   String translatevillaBUA(String value) {
//     String ret = "All";
//     for (int i = 0; i < villaBUA.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == villaBUA[i])
//         ret = values.villaBUAEnglish[i];
//     }
//     return ret;
//   }
//   String translatpricePerMeterCom(String value) {
//     String ret = "All";
//     for (int i = 0; i < pricePerMeterCom.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == pricePerMeterCom[i])
//         ret = values.pricePerMeterComEnglish[i];
//     }
//     return ret;
//   }
//   String translatefloorCommercial(String value) {
//     String ret = "All";
//     for (int i = 0; i < floorCommercial.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == floorCommercial[i])
//         ret = values.floorCommercialEnglish[i];
//     }
//     return ret;
//   }
//   String translatefloorApartment(String value) {
//     String ret = "All";
//     for (int i = 0; i < floorApartment.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == floorApartment[i])
//         ret = values.floorApartmentEnglish[i];
//     }
//     return ret;
//   }
//   String translateapartmentType(String value) {
//     String ret = "All";
//     for (int i = 0; i < apartmentType.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == apartmentType[i])
//         ret = values.apartmentTypeEnglish[i];
//     }
//     return ret;
//   }
//   String translatepricePerMeterAdmin(String value) {
//     String ret = "All";
//     for (int i = 0; i < pricePerMeterAdmin.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == pricePerMeterAdmin[i])
//         ret = values.pricePerMeterAdminEnglish[i];
//     }
//     return ret;
//   }
//   String translateareaAdmin(String value) {
//     String ret = "All";
//     for (int i = 0; i < areaAdmin.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == areaAdmin[i])
//         ret = values.areaAdminEnglish[i];
//     }
//     return ret;
//   }
//   String translateareaCommercial(String value) {
//     String ret = "All";
//     for (int i = 0; i < areaCommercial.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == areaCommercial[i])
//         ret = values.areaCommercialEnglish[i];
//     }
//     return ret;
//   }
//   String translateyesNo(String value) {
//     String ret = "All";
//     for (int i = 0; i < yesNo.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == yesNo[i])
//         ret = values.yesNoEnglish[i];
//     }
//     return ret;
//   }
//   String translateareaApartment(String value) {
//     String ret = "All";
//     for (int i = 0; i < areaApartment.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == areaApartment[i])
//         ret = values.areaApartmentEnglish[i];
//     }
//     return ret;
//   }
//   String translateareaChalet(String value) {
//     String ret = "All";
//     for (int i = 0; i < areaChalet.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == areaChalet[i])
//         ret = values.areaChaletEnglish[i];
//     }
//     return ret;
//   }
//   String translatelandArea(String value) {
//     String ret = "All";
//     for (int i = 0; i < landArea.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == landArea[i])
//         ret = values.landAreaEnglish[i];
//     }
//     return ret;
//   }
//   String translateserviceArea(String value) {
//     String ret = "All";
//     for (int i = 0; i < serviceArea.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == serviceArea[i])
//         ret = values.serviceAreaEnglish[i];
//     }
//     return ret;
//   }
//   String translatevillaType(String value) {
//     String ret = "All";
//     for (int i = 0; i < villaType.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == villaType[i])
//         ret = values.typeVillaEnglish[i];
//     }
//     return ret;
//   }
//
//   String translatesubLocationNewCapital(String value) {
//     String ret = "All";
//     for (int i = 0; i < subLocationNewCapital.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == subLocationNewCapital[i])
//         ret = values.subLocationNewCapitalEnglish[i];
//     }
//     return ret;
//   }
//   String translatesubLocationNewCairo(String value) {
//     String ret = "All";
//     for (int i = 0; i < subLocationNewCairo.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == subLocationNewCairo[i])
//         ret = values.subLocationNewCairoEnglish[i];
//     }
//     return ret;
//   }
//   String translatesubLocationOctoberZayed(String value) {
//     String ret = "All";
//     for (int i = 0; i < subLocationOctoberZayed.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == subLocationOctoberZayed[i])
//         ret = values.subLocationOctoberZayedEnglish[i];
//     }
//     return ret;
//   }
//   String translatesubLocationNorthCoast(String value) {
//     String ret = "All";
//     for (int i = 0; i < subLocationNorthCoast.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == subLocationNorthCoast[i])
//         ret = values.subLocationNorthCoastEnglish[i];
//     }
//     return ret;
//   }
//   String translatesubLocationElSokhna(String value) {
//     String ret = "All";
//     for (int i = 0; i < subLocationElSokhna.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == subLocationElSokhna[i])
//         ret = values.subLocationElSokhnaEnglish[i];
//     }
//     return ret;
//   }
//   String translatesubLocationElShrouk(String value) {
//     String ret = "All";
//     for (int i = 0; i < subLocationElShrouk.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == subLocationElShrouk[i])
//         ret = values.subLocationElShroukEnglish[i];
//     }
//     return ret;
//   }
//   String translatesubLocationElMostakbl(String value) {
//     String ret = "All";
//     for (int i = 0; i < subLocationElMostakbl.length; i++){
//       // print("intake " + apartmentType);
//       // print("intake " + apartmentType);
//       if(value == subLocationElMostakbl[i])
//         ret = values.subLocationElMostakblEnglish[i];
//     }
//     return ret;
//   }
// //endregion



  getIntialValues(){
    int y = 0;
    ApartmentType == "All"||ApartmentType =="الكل"?ApartmentType = AppLocalizations.of(context)!.any:y = 0;
     Type == 'Apartments and Duplexes'||Type =="شقق ودوبلكسات"?Type = AppLocalizations.of(context)!.apartments:y = 0;
     Years == "All"||Years =="الكل"?Years = AppLocalizations.of(context)!.any:y = 0;
     deliveryText == "All"||deliveryText =="الكل"?deliveryText = AppLocalizations.of(context)!.any:y = 0;
     PPM == "All"||PPM =="الكل"?PPM = AppLocalizations.of(context)!.any:y = 0;
     comPPM == "All"||comPPM =="الكل"?comPPM = AppLocalizations.of(context)!.any:y = 0;
     adminPPM == "All"||adminPPM =="الكل"?adminPPM = AppLocalizations.of(context)!.any:y = 0;
     area == "All"||area =="الكل"?area = AppLocalizations.of(context)!.any:y = 0;
     rooms == "All"||rooms =="الكل"?rooms = AppLocalizations.of(context)!.any:y = 0;
     floor == "All"||floor =="الكل"?floor = AppLocalizations.of(context)!.any:y = 0;
     delivery = "All";
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
     subLocation == "All"||subLocation =="الكل"?subLocation = AppLocalizations.of(context)!.any:y = 0;
     comType == "All"||comType =="الكل"?comType = AppLocalizations.of(context)!.any:y = 0;
     adminType == "All"||adminType =="الكل"?adminType = AppLocalizations.of(context)!.any:y = 0;
     location = values.location();
     subLocationNewCapital = values.subLocationNewCapital();
     subLocationNewCairo = values.subLocationNewCairo();
     subLocationOctoberZayed = values.subLocationOctoberZayed();
     subLocationNorthCoast = values.subLocationNorthCoast();
     subLocationElSokhna = values.subLocationElSokhna();
     subLocationElShrouk = values.subLocationElShrouk();
     subLocationElMostakbl = values.subLocationElMostakbl();
     type = values.type();
     subTypeCommercial = values.subTypeCommercial();
     subTypeAdmin = values.subTypeAdmin();
     years = values.years();
     ppm = values.ppm();
     roomsNo = values.roomsNo();
     roomsVillaNo = values.roomsVillaNo();
     roomsChaletNo = values.roomsChaletNo();
     deliveredIn = values.deliveredIn();
     finish = values.finish();
     apartmentsPrice = values.apartmentsPrice();
     villaPrice = values.villaPrice();
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
