import 'package:redwinners/UI/stylesAndThemes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompanyOffers extends StatefulWidget {
  final String name, describ;

  const CompanyOffers({
    Key? key,
    required this.name,
    required this.describ,
    }) : super(key: key);

  @override
  State<CompanyOffers> createState() => _CompanyOffersState();
}

class _CompanyOffersState extends State<CompanyOffers> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
