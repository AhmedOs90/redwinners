import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//      height: double.infinity,
//      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Image(
                  width: 50,
                  height: 50,
                  image: AssetImage("assets/loading-buffering.gif")),
      ),


    );

  }
}
