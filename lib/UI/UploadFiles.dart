import 'dart:io';

import 'package:redwinners/Model/Units.dart';
import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:redwinners/engines/prevelant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

import 'StuffPannel.dart';


class UploadFiles extends StatefulWidget {
  Project project;

  UploadFiles(this.project);

  @override
  _UploadeFilesState createState() => _UploadeFilesState(project);
}

class _UploadeFilesState extends State<UploadFiles> {
  Project proj;

  UploadTask? task;

  _UploadeFilesState(this.proj);

  var progress = 0.0;
  File? broch;
  File? location;
  File? inventory;
  File? masterPlan;
  int fileNo = 0;
  List<File>? files;
  bool _broch = false;
  bool _location = false;
  bool _inventory = false;
  bool _masterPlan = false;
  bool _images = false;

  

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: progress == 0?ListView(
        children: [
          //brochure
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration: BoxDecoration(
            ),
            child: ElevatedButton(
                onPressed: () {
                  SelectFile(1);
                },
                style: mainTheme,
                child: Text("Select Brochure")),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(child: Text(broch != null
                ? basename(broch!.path)
                : "Nothing Selected")),
          ),
          Row(
            children: [
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Checkbox(
                      value: _broch,
                      onChanged: (value) {
                        setState(() {
                          _broch = value!;
                        });
                      },
                    );
                    }
    ),
              Text("Dont Upload Brochure" )
                  ],
                  ),
          //Location
          Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                  ),
                  child: ElevatedButton(
                  onPressed: () {
                  SelectFile(2);
                  },
                  style: mainTheme,
                  child: Text("Upload Location on Map")),
                  ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
                  child: Center(child: Text(location != null
                  ? basename(location!.path)
                      : "Nothing Selected")),
                  ),
          Row(
            children: [
               StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          value: _location,
                          onChanged: (value) {
                            setState(() {
                              _location = value!;
                            });
                          },
                        );
                      }
                  ),
              Text("Dont Upload Location")
            ],
          ),
          //masterplan
          Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                  ),
                  child: ElevatedButton(
                  onPressed: () {
                  SelectFile(3);
                  },
                  style: mainTheme,
                  child: Text("Upload MasterPlan")),
                  ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
                  child: Center(child: Text(masterPlan != null
                  ? basename(masterPlan!.path)
                      : "Nothing Selected")),
                  ),
          Row(
            children: [
              StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          value: _masterPlan,
                          onChanged: (value) {
                            setState(() {
                              _masterPlan = value!;
                            });
                          },
                        );
                      }
                  ),
              Text("Dont't Upload materplan" ,),
            ],
          ),
          //Inventory
          Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                  ),
                  child: ElevatedButton(
                  onPressed: () {
                  SelectFile(4);
                  },
                  style: mainTheme,
                  child: Text("Upload redwinners")),
                  ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
                  child: Center(child: Text(inventory != null
                  ? basename(inventory!.path)
                      : "Nothing Selected")),
                  ),
          Row(
            children: [
              StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          value: _inventory,

                          onChanged: (value) {
                            setState(() {
                              _inventory = value!;
                            });
                          },
                        );
                      }
                  )
              ,
              Text("Dont Upload Inventory"),
            ],
          ),
          //images
          Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(

                  ),
                  child: ElevatedButton(

                  onPressed: () {

                  SelectImages();
                  },
                  style: mainTheme,
                  child: Text("Upload Images")),
                  ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(child: Text(fileNo > 0
                ? fileNo.toString() + " Selected"
                : "Nothing Selected")),
          ),
          Row(
            children: [
              StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          value: _images,
                          onChanged: (value) {
                            setState(() {
                              _images = value!;
                            });
                          },
                        );
                      }
                  ),
              Text("Dont Upload Images" )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration: BoxDecoration(

            ),
            child: ElevatedButton(

                onPressed: () {

                  UploadBrochure(context);
                },
                style: mainTheme,
                child: Text("Upload Files")),
          ),
        ],
      ) : progressView()
    );
  }
//
  void SelectFile(int i) async {

    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      setState(() {
        switch (i)
        {
          case 1:
            broch = File(result.files.single.path!);
            break;
          case 2:
            location = File(result.files.single.path!);
            break;
          case 3:
            masterPlan = File(result.files.single.path!);
            break;
          case 4:
            inventory = File(result.files.single.path!);
            break;
          case 5:
            break;

        }

      });
    }
  }


  updateProject() {
  }

  void UploadBrochure(BuildContext context) async {
    List<String> imag = [];
    CollectionReference AllProjects = FirebaseFirestore.instance.collection(
        Prevalent.currentOnlineUser.userName);
    CollectionReference AllUnits = FirebaseFirestore.instance.collection(
        Prevalent.currentOnlineUser.userName+"Units"+ proj.id);
    setState(() {
      progress = 0.01;
    });
      if(!_broch) {
        if (broch == null) {
          proj.brochure = "0";
        }
        else {
          final name = basename(broch!.path);
          final destination = "Data/" + proj.developer + "/" +
              proj.projectName +
              "/" + name;
          task = FirebaseApi.uploadFile(destination, broch!);


          if (task == null) return;

          final snapShot = await task!.whenComplete(() => {});
          final downLoad = await snapShot.ref.getDownloadURL();
          proj.brochure = downLoad;
        }
        setState(() {
          progress = 0.2;
        });
      }
      else
        {
          setState(() {
            progress = 0.2;
          });
        }
      if(!_location) {
        if (location == null) {
          proj.locationMap = "0";
        }
        else {
          final name = basename(location!.path);
          final destination = "Data/" + proj.developer + "/" +
              proj.projectName +
              "/" + name;

          task = FirebaseApi.uploadFile(destination, location!);
          if (task == null) return;

          final snapShot = await task!.whenComplete(() => {});
          final downLoad = await snapShot.ref.getDownloadURL();
          proj.locationMap = downLoad;
        }
        setState(() {
          progress = 0.4;

        });
      }
      else{
        setState(() {
          progress = 0.4;
        });
      }
      if(!_masterPlan) {
        if (masterPlan == null) {
          proj.masterPlan = "0";
        }
        else {
          final name = basename(masterPlan!.path);
          final destination = "Data/" + proj.developer + "/" +
              proj.projectName +
              "/" + name;

          task = FirebaseApi.uploadFile(destination, masterPlan!);

          if (task == null) return;

          final snapShot = await task!.whenComplete(() => {});
          final downLoad = await snapShot.ref.getDownloadURL();
          proj.masterPlan = downLoad;
        }
        setState(() {
          progress = 0.6;

        });
      }
      else{
        setState(() {
          progress = 0.6;
        });

      }
      if(!_inventory) {
        if (inventory == null) {
          proj.redwinnersSheet = "0";
        }
        else {
          final name = basename(inventory!.path);
          final destination = "Data/" + proj.developer + "/" +
              proj.projectName +
              "/" + name;

          task = FirebaseApi.uploadFile(destination, inventory!);

          if (task == null) return;

          final snapShot = await task!.whenComplete(() => {});
          final downLoad = await snapShot.ref.getDownloadURL();
          proj.redwinnersSheet = downLoad;
        }
        setState(() {
          progress = 0.7;
        });

      }
      else{
        setState(() {
          progress = 0.7;
        });
      }
    var querySnapshots = await AllUnits.get();
      if(!_images) {
        if (files == null) {
          imag = ["0","0","0","0","0","0","0","0","0","0"];
          proj.setImages(imag);
          updateIneventoryImage(querySnapshots,imag);
          setState(() {
            progress = 0.95;
          });
        }
        else {
          if (files!.length < 10) {
            int c = 10 - files!.length;
            for (int i = 0; i < files!.length; i++) {
              final name = basename(files![i].path);
              final destination = "Data/" + proj.developer + "/" +
                  proj.projectName + "/" + name;
              task = FirebaseApi.uploadFile(destination, files![i]);
              if (task == null) return;
              final snapShot = await task!.whenComplete(() => {});
              final downLoad = await snapShot.ref.getDownloadURL();
              imag.add(downLoad);
            }
            for (int x = 0; x < c; x++) {
              imag.add("0");
            }
          }
          else if (files!.length >= 10) {
            for (int i = 0; i < 10; i++) {
              final name = basename(files![i].path);
              final destination = "Data/" + proj.developer + "/" +
                  proj.projectName + "/" + name;
              task = FirebaseApi.uploadFile(destination, files![i]);

              if (task == null) return;
              final snapShot = await task!.whenComplete(() => {});
              final downLoad = await snapShot.ref.getDownloadURL();
              imag.add(downLoad);
            }
          }
          proj.setImages(imag);
          updateIneventoryImage(querySnapshots,imag);
          setState(() {
            progress = 0.95;
          });
        }
      }
      else
        {
          setState(() {
            progress = 0.95;
          });
        }




    AllProjects.doc(proj.id).set(proj.toMap()).then((value)
        {
          FilePicker.platform.clearTemporaryFiles();
          showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: const Text('Project Updated'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () =>
                    {
                      Navigator.pop(context),
                      Navigator.pop(context),
                      Navigator.pop(context),
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
        }
    );
  }

  void SelectImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    files = result!.paths.map((path) => File(path!)).toList();
    setState(() {
      fileNo = files!.length;
    });
  }

  progressView() {

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: LinearProgressIndicator(

            value: progress,

            ),
        ),
      ),
    );
//    return StreamBuilder<TaskSnapshot>(
//      stream: task.snapshotEvents,
//      builder: (context, snapshot){
//        if(snapshot.hasData) {
//        final snap = snapshot.data;
//        var progress = snap!.bytesTransferred / snap!.totalBytes;
//
//
//        return CircularProgressIndicator(
//          value: progress,
//        );
//        }
//        else
//          {
//            return Container();
//          }
//      },
//    );
  }

  getCount(){
    
  }

  Future<void> updateIneventoryImage(QuerySnapshot<Object?> querySnapshots, List<String> imag) async {
    for (var doc in querySnapshots.docs) {
      await doc.reference.update({
        'image0': imag[0],
        'image1': imag[1],
        'image2': imag[2],
        'image3': imag[3],
        'image4': imag[4],
        'image5': imag[5],
        'image6': imag[6],
        'image7': imag[7],
        'image8': imag[8],
        'image9': imag[9],
      });
    }
  }
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File name)
  {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(name);
  }
}
