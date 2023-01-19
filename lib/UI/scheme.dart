import 'package:redwinners/Model/Requests.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:redwinners/Model/values.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'Projectlist.dart';
import 'SpecificRequest.dart';
import 'browse.dart';
import 'home.dart';
import 'stylesAndThemes.dart';

class QuestionsListView extends StatefulWidget {
  @override
  _QuestionsListViewState createState() => _QuestionsListViewState();
}

class _QuestionsListViewState extends State<QuestionsListView> {
  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }


  @override
  void initState() {
    Prevalent.checkInProtocol(context);
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    var loc = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.exit),
      content: Text(AppLocalizations.of(context)!.doYouWantExit),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(loc!.no),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(loc!.yes),
        ),
      ],
    );
  }
  int priceStart = 0;
  int priceEnd = 0;
  String question = "What are you looking for?";
  List<String> Choices = [];
  List<String> toBeShown = type;


  static List<String> location = values.location();
  static List<String> type = values.type();
  static List<String> roomsNo = values.roomsNo();
  static List<String> roomsChaletNo = values.roomsChaletNo();
  static List<String> deliveredIn = values.deliveredIn();
  static List<String> apartmentsPrice = values.apartmentsPrice();
  static List<String> villaPrice = values.villaPrice();
  static List<String> villaBUA = values.villaBUA();
  static List<String> pricePerMeterCom = values.pricePerMeterCom();
  static List<String> floorCommercial = values.floorCommercial();
  static List<String> floorApartment = values.floorApartment();
  static List<String> pricePerMeterAdmin = values.pricePerMeterAdmin();
  static List<String> areaAdmin = values.areaAdmin();
  static List<String> areaCommercial = values.areaCommercial();
  static List<String> yesNo = values.yesNo();
  static List<String> serviceArea = values.serviceArea();
  static List<String> villaType = values.typeVilla();

  static const apartment = "Apartments and Duplexes";
  static const Villas = "Villas";
  static const ServApar = "Serviced Apartments";
  static const com = "Commercials";
  static const admin = "Administrative offices and clinics";
  static const Chalet = "Chalets";
  String delivery ="All";
  @override
  Widget build(BuildContext context) {

    getIntialValues();
    var loc = AppLocalizations.of(context);
    int _selectedIndex = 2;
    if(question == "What are you looking for?" || question == "عن ماذا تبحث؟"){
      question = loc!.whatAreYouLookingFor;
      toBeShown = type;
    }

    return WillPopScope(
      onWillPop: () async {
        if (Choices.isEmpty)
          {
            return _onWillPop(context);
          }
        else {
          Choices.removeLast();
          if (Choices.isEmpty)
            {
              setState(() {
                toBeShown = type;
                question = loc!.whatAreYouLookingFor;
              });
              return false;
            }
          else
                  {
                    String last = Choices.last;
                    Choices.removeLast();
                  _scheme(last);
                  return false;
                  }
              }
        },
      child: Scaffold(

        body: Column(
          children: [
            Choices.isEmpty?appHead(loc!.callScheme,Icons.account_tree, true, context):appHeadWithBack(loc!.callScheme,Icons.account_tree, true, context),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(margin: EdgeInsets.all(20),
                      child: Text(question, style: Alltheme.textTheme.bodyText1)),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: ListView.builder(scrollDirection: Axis.vertical,
                          itemCount: toBeShown.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                title: Text(
                                    toBeShown[index], textAlign: TextAlign.center),
                                onTap: () => _scheme(toBeShown[index]),

                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: loc!.offers,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome),
              label: loc!.browse,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_tree),
              label: loc.callScheme,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_search),
              label: loc.request,
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

  _scheme(String choice) {
    var loc = AppLocalizations.of(context);
    Choices.add(choice);

    if (Choices.length == 1) {
      // go to location
      setState(() {
        toBeShown = location;
        question = loc!.whereAreYouLooking;
      });
    }

    else if (Choices.length == 2) {
//resgion 1
      switch (values.translatetype(Choices[0])) {
        case apartment:
        // room no
          setState(() {
            toBeShown = roomsNo;
            question = loc!.howManyRooms;
          });
          break;

        case ServApar:
          setState(() {
            toBeShown = deliveredIn;
            question = loc!.whenDoYouWantToReceiveYourUnit;
          });
          // go to project list view
          break;

        case Villas:
          setState(() {
            toBeShown = villaType;
            question =
            loc!.areYouLookingForTTorS;
          });

          break;

        case Chalet:
        //Room No
          setState(() {
            toBeShown = roomsChaletNo;
            question = loc!.howManyRooms;
          });
          break;

        case com:
        // price per meter comercial
          setState(() {
            toBeShown = areaCommercial;
            question = loc!.whatAverageArea;
          });
          break;

        case admin:
        // price per meter admin
          setState(() {
            toBeShown = areaAdmin;
            question = loc!.whatAverageArea;

          });
          break;
      }
    }
    else if (Choices.length == 3) {
      switch (values.translatetype(Choices[0])) {
        case apartment:
        // go to delivered in
          setState(() {
            toBeShown = deliveredIn;
            question = loc!.whenDoYouWantToReceiveYourUnit;
          });
          break;

        case ServApar:
          setState(() {
            //budget
            toBeShown = serviceArea;
            question = loc!.whatAverageArea;
          });
          break;
        case Villas:
        // go to de;ivered in
          setState(() {
            toBeShown = villaBUA;
            question = loc!.whatAverageArea;
          });

          break;

        case Chalet:
        // go to apartment prices
          setState(() {
            toBeShown = deliveredIn;
            question = loc!.whenDoYouWantToReceiveYourUnit;
          });

          break;
        case com:
        //floor comercial
          setState(() {
            toBeShown = yesNo;
            question = loc!.doWantOutdoorArea;
          });
          break;


        case admin:
        //area admin
          setState(() {
            toBeShown = deliveredIn;
            question = loc!.whenDoYouWantToReceiveYourUnit;
          });
          break;
      }
    }
    else if (Choices.length == 4) {
      switch (values.translatetype(Choices[0])) {
        case Villas:
          setState(() {
            toBeShown = villaPrice;
            question = loc!.whatYourBudget;
          });
          //go to project view
          break;

        case Chalet:
          setState(() {
            toBeShown = floorApartment;
            question = loc!.whichFloor;
          });
          //go to project view
          break;
        case ServApar:
          setState(() {
            //budget
            toBeShown = apartmentsPrice;
            question = loc!.whatYourBudget;
          });
          break;


        case apartment:
        // apartments price
          setState(() {
            toBeShown = apartmentsPrice;
            question = loc!.whatYourBudget;
          });
          break;

        case com:
        //floor comercial
          setState(() {
            toBeShown = floorCommercial;
            question = loc!.whichFloor;
          });
          break;
        case admin:
        //floor comercial
          setState(() {
            toBeShown = pricePerMeterAdmin;
            question = loc!.whatAveragePriceMeter;
          });
          break;
          //delivered in
          break;
      }
    }
    else if (Choices.length == 5) {
      switch (values.translatetype(Choices[0])) {
        case apartment:
          goToProjectList(Choices);
          //go to project list
          break;

        case com:
          setState(() {
            toBeShown = pricePerMeterCom;
            question = loc!.whatAveragePriceMeter;
          });
          break;

        case Villas:
          setState(() {
            toBeShown = deliveredIn;
            question = loc!.whenDoYouWantToReceiveYourUnit;
          });//go to project list
          break;

        case admin:
          goToProjectList(Choices);
          //go to project list
          break;
        case ServApar:
          goToProjectList(Choices);
          //go to project list
          break;
        case Chalet:
          setState(() {
            toBeShown = apartmentsPrice;
            question = loc!.whatYourBudget;
          });
      }
    }
    else if (Choices.length == 6) {
      if (values.translatetype(Choices[0]) == com) {
          setState(() {
            toBeShown = deliveredIn;
            question = loc!.whenDoYouWantToReceiveYourUnit;
          });
      }
      else {goToProjectList(Choices);}
    }
    else if (Choices.length == 7)
    {goToProjectList(Choices);}
  }

  void goToProjectList(List<String> choices) {
    //"Any Budget", "500K - 2 Millions", "2 Millions - 4 Millions", "Above 4 Millions"

    if (values.translatetype(choices[0]) == apartment) {
      Payment payment = getPayment(Choices);
      delivery = getDelivery(values.translatedelivery(Choices[3]));
      Choices[3] = delivery;
      Requests request = new Requests.ap(
          values.translatetype(choices[0]),
          values.translateLocation(choices[1]),
          "All",
          choices[3],
          "All",
          "All",
          "All",
          values.translateroomsNo(choices[2]),
          "All",
          "All",
          payment);
      Navigator.push(context, MaterialPageRoute(builder:
          (context) =>
          ProjectList(request.type + " units",
              request.type, request, "Scheme"))).then((val)=>val?_getRequests():null);
    }
    if (values.translatetype(choices[0]) == ServApar) {
      delivery = getDelivery(values.translatedelivery(Choices[2]));
      Choices[2] = delivery;
      Payment payment = getPayment(Choices);
      Requests request = new Requests.SA(
          values.translatetype(choices[0]),
          values.translateLocation(choices[1]),
          "All",
          choices[2],
          "All",
          values.translateserviceArea(choices[3]),
          payment);
      Navigator.push(context, MaterialPageRoute(builder:
          (context) =>
          ProjectList(request.type + " units",
              request.type, request,"Scheme"))).then((val)=>val?_getRequests():null);
    }
    if (values.translatetype(choices[0])  == Villas) {

      delivery = getDelivery(values.translatedelivery(Choices[5]));
      Choices[5] = delivery;
      Payment payment = getPayment(Choices);
      Requests request = new Requests.vi(
          values.translatetype(choices[0]),
          values.translateLocation(choices[1]),
          "All",
          choices[5],
          "All",
          values.translatevillaBUA(choices[3]),
          "All",
          "All",
          values.translatevillaType(choices[2]),
          payment);
      Navigator.push(context, MaterialPageRoute(builder:
          (context) =>
          ProjectList(request.type + " units",
              request.type, request, "Scheme"))).then((val)=>val?_getRequests():null);
    }
    if (values.translatetype(choices[0])  == Chalet) {
      delivery = getDelivery(values.translatedelivery(Choices[3]));
      Choices[3] = delivery;
      Payment payment = getPayment(Choices);
      Requests request = new Requests.ch(
          values.translatetype( choices[0]),
          values.translateLocation(choices[1]),
          "All",
          choices[3],
          "All",
          "All",
          values.translatefloorApartment(choices[4]),
          values.translateroomsChaletNo(choices[2]),
          payment);
      Navigator.push(context, MaterialPageRoute(builder:
          (context) =>
          ProjectList(request.type + " units",
              request.type, request, "Scheme"))).then((val)=>val?_getRequests():null);
    }
    if (values.translatetype(choices[0]) == com) {
      delivery = getDelivery(values.translatedelivery(Choices[6]));
      Choices[6] = delivery;
      Payment payment = getPayment(Choices);
      Requests request = new Requests.com(
          values.translatetype(choices[0]),
          values.translateLocation(choices[1]),
          "All",
          choices[6],
          "All",
          values.translateareaCommercial(choices[2]),
          values.translatefloorCommercial(choices[4]),
          values.translatpricePerMeterCom(choices[5]),
          values.translateyesNo(choices[3]),
          "All",
          payment);
      Navigator.push(context, MaterialPageRoute(builder:
          (context) =>
          ProjectList(request.type + " units",
              request.type, request,"Scheme"))).then((val)=>val?_getRequests():null);
    }
    if (values.translatetype(choices[0])  == admin) {
      switch (values.translatedelivery(Choices[3]))
      {
        case "All":
          delivery = "All";
          break;
        case "1/1/2022":
          delivery = "1/1/2022";
          break;
        case "1/1/2023":
          delivery = "1/1/2023";
          break;
        case "1/1/2024":
          delivery = "1/1/2024";
          break;
        case "1/1/2025":
          delivery = "1/1/2025";
          break;
        case "1/1/2026":
          delivery = "1/1/2026";
          break;

        case "Immediate Delivery":
          delivery = "1/1/2022";
          break;
        case "1 year":
          delivery = "1/1/2023";
          break;
        case "2 years":
          delivery = "1/1/2024";
          break;
        case "3 years":
          delivery = "1/1/2025";
          break;
        case "4 years":
          delivery = "1/1/2026";
          break;
      }
      Choices[3] = delivery;
      Payment payment = getPayment(Choices);
      Requests request = new Requests.admin(
          values.translatetype(choices[0]),
          values.translateLocation(choices[1]),
          "All",
          choices[3],
          "All",
          values.translateareaAdmin(choices[2]),
          values.translatepricePerMeterAdmin(choices[4]),
          "All",
          payment);
      Navigator.push(context, MaterialPageRoute(builder:
          (context) =>
          ProjectList(request.type + " units",
              request.type, request, "Scheme"))).then((val)=>val?_getRequests():null);
    }
  }

  Payment getPayment(List<String> choices) {
    if (Choices[0] == apartment) {
      if (Choices[4] == "All") {
        priceStart = 0;
        priceEnd = 0;
      }
      else if (Choices[4] == "500K - 2 Millions") {
        priceStart = 500000;
        priceEnd = 2000000;
      }
      else if (Choices[4] == "2 Millions - 4 Millions") {
        priceStart = 2000000;
        priceEnd = 4000000;
      }
      else if (Choices[4] == "Above 4 Millions") {
        priceStart = 4000000;
        priceEnd = 0;
      }
      Payment payment = new Payment("Installments", priceStart, priceEnd, 0);
      return payment;
    }
    else if (Choices[0] == Villas) {
      if (Choices[4] == "All") {
        priceStart = 0;
        priceEnd = 0;
      }
      else if (Choices[4] == "2 Millions - 5 Millions") {
        priceStart = 2000000;
        priceEnd = 5000000;
      }
      else if (Choices[4] == "5 Millions - 8 Millions") {
        priceStart = 5000000;
        priceEnd = 8000000;
      }
      else if (Choices[4] == "8 Millions - 11 Millions") {
        priceStart = 8000000;
        priceEnd = 11000000;
      }
      else if (Choices[4] == "11 Millions - 15 Millions") {
        priceStart = 11000000;
        priceEnd = 15000000;
      }
      else if (Choices[4] == "Above 15 Millions") {
        priceStart = 15000000;
        priceEnd = 0;
      }
      Payment payment = new Payment(
          "Installments", priceStart, priceEnd, 0);
      return payment;
    }

    else if (Choices[0] == Chalet) {
      if (Choices[5] == "All") {
        priceStart = 0;
        priceEnd = 0;
      }
      else if (Choices[5] == "500K - 2 Millions") {
        priceStart = 500000;
        priceEnd = 2000000;
      }
      else if (Choices[5] == "2 Millions - 4 Millions") {
        priceStart = 2000000;
        priceEnd = 4000000;
      }
      else if (Choices[5] == "Above 4 Millions") {
        priceStart = 4000000;
        priceEnd = 0;
      }
      Payment payment = new Payment("Installments", priceStart, priceEnd, 0);
      return payment;
    }

    else if (Choices[0] == ServApar) {
      if (Choices[4] == "All") {
        priceStart = 0;
        priceEnd = 0;
      }
      else if (Choices[4] == "500K - 2 Millions") {
        priceStart = 500000;
        priceEnd = 2000000;
      }
      else if (Choices[4] == "2 Millions - 4 Millions") {
        priceStart = 2000000;
        priceEnd = 4000000;
      }
      else if (Choices[4] == "Above 4 Millions") {
        priceStart = 4000000;
        priceEnd = 0;
      }
      Payment payment = new Payment("Installments", priceStart, priceEnd, 0);
      return payment;
    }

    else {
      priceStart = 0;
      priceEnd = 0;
      Payment payment = new Payment(
          "Installments", priceStart, priceEnd, 0);
      return payment;
    }
  }

  void _onItemTapped(int value) {
    if (value == 0) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
          (context) => Home()), (route) => false);
    }
    if (value == 1) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
          (context) => Browse()), (route) => false);
    }
    if (value == 3) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
          (context) => SpecificRequest()), (route) => false);
    }
  }

  _getRequests() {
    Choices.removeLast();
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
  getIntialValues(){
     location = values.location();
     type = values.type();
     roomsNo = values.roomsNo();
     roomsChaletNo = values.roomsChaletNo();
     deliveredIn = values.deliveredIn();
     apartmentsPrice = values.apartmentsPrice();
     villaPrice = values.villaPrice();
     villaBUA = values.villaBUA();
     pricePerMeterCom = values.pricePerMeterCom();
     floorCommercial = values.floorCommercial();
     floorApartment = values.floorApartment();
     pricePerMeterAdmin = values.pricePerMeterAdmin();
     areaAdmin = values.areaAdmin();
     areaCommercial = values.areaCommercial();
     yesNo = values.yesNo();
     serviceArea = values.serviceArea();
     villaType = values.typeVilla();
  }
}