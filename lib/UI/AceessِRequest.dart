import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:redwinners/Model/Requests.dart';

import 'ErrorServerPage.dart';
import 'Loading.dart';

class userRequest extends StatefulWidget {
  const userRequest({Key? key}) : super(key: key);

  @override
  State<userRequest> createState() => _userRequestState();
}

class _userRequestState extends State<userRequest> {
  @override
  Widget build(BuildContext context) {

    CollectionReference userR = FirebaseFirestore.instance.collection('requests');
    final Stream<QuerySnapshot> _projectsStream = userR.snapshots();
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
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    userReq requ = new userReq.a();
    requ.fromMap(data!);

    return Container(
        child: Card(
          child: Column(
            children: [
              Text("company: " + requ.company),
              Text("name: " + requ.name),
              Text("number: " + requ.number),
              Text("status: " + requ.status == null?"New":requ.status),
              ElevatedButton(onPressed: (){requestHandeld(requ);}, child: Text("Request Handled"))
            ],
          ),
        ),
      );

  }

  requestHandeld(userReq requ) {
    CollectionReference userR = FirebaseFirestore.instance.collection('requests');
    CollectionReference handled = FirebaseFirestore.instance.collection(
        "handled");
    Map map = requ.toMap();
    handled.doc(requ.number).set(map);

    userR.doc(requ.number).delete();
  }


}
