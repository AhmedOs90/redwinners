import 'package:redwinners/Model/Units.dart';
import 'package:redwinners/UI/DeveloperView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'ErrorServerPage.dart';
import 'Loading.dart';
import 'SpecificRequest.dart';
import 'home.dart';
import 'scheme.dart';
import 'stylesAndThemes.dart';

class DevelopersList extends StatefulWidget {
  @override
  _DevelopersListState createState() => _DevelopersListState();
}

class _DevelopersListState extends State<DevelopersList> {
  String nameSearch = "";
  bool focusbool = false;
  int _selectedIndex = 1;
  final myController = TextEditingController();
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
    CollectionReference developers = FirebaseFirestore.instance.collection('Developers');
    final Stream<QuerySnapshot> _projectsStream = developers.snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _projectsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return OpsError();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }


          return Scaffold(
            body:Column(
              mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                        )
                      ]),
                  margin: EdgeInsets.only(bottom: 5),
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
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: TextField(
                                controller: myController,
                                autofocus: focusbool,
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    hintText: loc!.searchDevelopers),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ),


                Expanded(
                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return ProjectCard(
                                          snapshot.data!.docs[index], context);
                                    }),
                )



//          ]


//                ),
              ],
            ),
          );
        });

  }
  Widget ProjectCard(QueryDocumentSnapshot<Object?> doc, BuildContext context) {
    bool condition = true;
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    Developer developer = new Developer.a();
    developer.fromMap(data!);
    String test = developer.developerName.toLowerCase();
    if (test.length >= nameSearch.length) {
      for (int i = 0; i < nameSearch.length; i++) {
        if (nameSearch[i] != test[i]) {
          condition = false;
        }
      }

    }
    else {condition = false;}

    if(condition) {
      return InkWell(
        child: Container(width: double.infinity,
          child: Card(
              child: Row(
                children: [
                  FadeInImage(
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                      image: NetworkImage(developer.Logo),
                      imageErrorBuilder: (context, exception,stackTrace) {
                        return Image(height: 120,
                          width: 120,
                          image: AssetImage("assets/ErrorImage.png"),);
                      },
                      placeholder: AssetImage("assets/Eclipse-1s-200px.gif")
                  ),
                  Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          developer.developerName,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                ],
              )
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder:
              (context) => DeveloperView(developer.id)));
        },
      );
    }
    else
      {
        return Container();
      }
  }

  reSearch() async {
    String test = nameSearch;
    focusbool = true;
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
