import 'package:redwinners/Model/Requests.dart';
import 'package:redwinners/UI/scheme.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:redwinners/Model/values.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'DevelopersList.dart';
import 'Projectlist.dart';
import 'SpecificRequest.dart';
import 'home.dart';

class Browse extends StatefulWidget {
  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }
  AlertDialog _buildExitDialog(BuildContext context) {
    var loc = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(loc!.exit),
      content: Text(loc!.doYouWantExit),
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

  String selected = "";
  int counter = 0;
  String type = "";
  String location = "";
  var question = "What are you looking for?";
  List<String> toBeShown = values.type();

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);
    int _selectedIndex = 1;
    return WillPopScope(
      onWillPop: () async {
          return _onWillPop(context);
      },
      child: Scaffold(
        body: Column(
            children:[
              appHead(AppLocalizations.of(context)!.browse,Icons.folder_open, true, context),
              Expanded(
                child: Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 15, left: 20, right: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context) =>ProjectList("All Projects", "All Projects", new Requests.empty(), "Browse")));
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 70),
                            primary: Colors.redAccent.shade700,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Text(AppLocalizations.of(context)!.browseByProject))),
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) =>DevelopersList()));
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 70),
                          primary: Colors.redAccent.shade700,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(AppLocalizations.of(context)!.browseByDeveloper)),
                  ),
                ],
              ),
    )
              )
            ]

        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: loc!.offers,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder_open),
              label: loc!.browse,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_tree),
              label: loc!.callScheme,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_search),
              label: loc!.request,
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

  @override
  void initState() {
    Prevalent.checkInProtocol(context);
    super.initState();
  }

  // browseProjects() {
  //   if (counter == 0)
  //     {projectRefresh();}
  //   if (selected == "Projects")
  //   {
  //     return Column(
  //       mainAxisSize: MainAxisSize.max,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //             margin: EdgeInsets.all(20),
  //             child: Text(question, style: Alltheme.textTheme.bodyText2)),
  //         Expanded(
  //           child: Container(
  //             width: double.infinity,
  //             child: ListView.builder(scrollDirection: Axis.vertical,
  //                 itemCount: toBeShown.length, itemBuilder: (BuildContext context, int index){
  //                   return Card(
  //                     child: ListTile(
  //                         title: Text(toBeShown[index],textAlign: TextAlign.center),
  //                       onTap: ()=>scape(toBeShown[index]),
  //                   ),
  //                   );
  //
  //                 }),
  //           ),
  //         )
  //       ],
  //     );
  //   }
  //   else if (selected == "Developers")
  //   {
  //
  //
  //
  //   }
  //   else if (selected == "") {
  //
  //   }
  //   else
  //   {
  //     return Text("Error");
  //   }
  // }
  //
  // scape(String choice) {
  //   counter++;
  //   if (counter == 1)
  //   setState(() {
  //     type = choice;
  //     toBeShown = values.location();
  //     question = AppLocalizations.of(context)!.whereAreYouLooking;
  //   });
  //   if (counter ==2)
  //    {
  //      location = choice;
  //     Navigator.push(context, MaterialPageRoute(builder:
  //         (context) =>ProjectList(values.translatetype(type) + " units",values.translatetype(type) , Requests.emp(values.translatetype(type), values.translateLocation(location)), "Browse"))).then((value) => refresh(), );
  //   }
  // }

  //
  // refresh() {
  //   setState(() {
  //     selected = "";
  //     counter = 0;
  //     toBeShown = values.type();
  //     question = AppLocalizations.of(context)!.whatAreYouLookingFor;
  //   });
  // }
  //  projectRefresh()
  //  {
  //   setState(() {
  //     counter = 0;
  //     toBeShown = values.type();
  //     question = AppLocalizations.of(context)!.whatAreYouLookingFor;
  //   });
  // }

  void _onItemTapped(int value) {
    if(value == 0)
    {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
          (context) => Home()), (route) => false);
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
}
