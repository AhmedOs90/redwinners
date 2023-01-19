import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OpsError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          appHeadWithBack(loc!.notFound,Icons.error ,true,context),
          Expanded(
              child: ListView(
                children: [
                  Center(
                    child: Image(
                      height: 200,
                      width: 200,
                      image: AssetImage("assets/error.png"),
                    ),
                  ),
                  Center(
                      child: Text(loc!.ops)),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                        onPressed: (){Navigator.pop(context);},
                        child: Text(loc!.back)),
                  )
                ],
              ))

        ],
      ),
    );
  }
}
