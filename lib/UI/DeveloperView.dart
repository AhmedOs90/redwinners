import 'package:redwinners/Model/Requests.dart';
import 'package:redwinners/Model/Units.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../engines/prevelant.dart';
import 'ErrorServerPage.dart';
import 'Loading.dart';
import 'ProjectView.dart';
import 'Projectlist.dart';

class DeveloperView extends StatelessWidget {
  @override
  String id;
  DeveloperView(this.id);
  Widget build(BuildContext context) {
    CollectionReference developers = FirebaseFirestore.instance.collection('Developers');
    var loc = AppLocalizations.of(context);
    return FutureBuilder<DocumentSnapshot>(
        future: developers.doc(id).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot)  {
          if (snapshot.hasError) {
            return OpsError();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }

          if (snapshot.connectionState == ConnectionState.done)
            {

              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              Developer developer = new Developer.a();
              developer.fromMap(data);


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
              title: Text(developer.developerName),backgroundColor: Colors.redAccent.shade700,),
            body: ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child:
                      FadeInImage(
                       image: NetworkImage(developer.Logo),

                          width: 150,
                          height: 150,
                        imageErrorBuilder: (context, exception,stackTrace) {
                          return Image(height: 120,
                            width: 120,
                            image: AssetImage("assets/ErrorImage.png"),);
                        },
                        placeholder: AssetImage("assets/Eclipse-1s-200px.gif"),
                          ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        margin: EdgeInsets.all(12),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
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
                          child: Directionality(
                            textDirection: developer.Arabic?TextDirection.rtl:TextDirection.ltr,
                            child: ReadMoreText(
                              developer.dscription,
                              trimLines: 8,
                              colorClickableText: Colors.pink,
                              trimMode: TrimMode.Line,
                              style: Alltheme.textTheme.bodyText2,
                              trimCollapsedText: loc!.showMore,
                              trimExpandedText: loc!.showLess,
                            ),
                          ),
                        ),
                      ),
                    ), //Description body
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: developer.contactperson2 =="0"&&developer.phone2 !="0"?
                      Text(loc.youCanSign+ developer.developerName + loc.byCalling + developer.contactperson1 + loc.on +reversePhone(developer.phone1) +
                          loc.or +reversePhone(developer.phone2) + ".")
                          :Text(loc.youCanSign+ developer.developerName +loc.byCalling+ developer.contactperson1 + loc.on +reversePhone(developer.phone1)),
                    ),//contact
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: developer.contactperson2 =="0"?Container():Text(loc.or + developer.contactperson2+loc.on + reversePhone(developer.phone2) + "."),
                    ),//contact
                  ],
                ),
                Container(margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectList(developer.id,developer.id, new Requests.emp("", ''),"Dev")));},
                      style: mainTheme,
                      child: Text(loc.showProjects)),
                ),
              ],

            ),

          );
            }
          return Loading();
        });

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
}