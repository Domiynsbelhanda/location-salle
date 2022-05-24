import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:place_event/functions/global_variable.dart';

import '../models/Categorie.dart';

Widget categorieItem(context, Categorie categorie){
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.luminosity),
        image: NetworkImage(categorie.images),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(5.0),
      color: tertColor,
      border: Border.all(
        color: Colors.black,
        style: BorderStyle.solid,
        width: 0.5,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon(
          //   FontAwesomeIcons.city,
          //   color: tertColor,
          // ),
          //
          // SizedBox(width: 16.0,),
          Text(
              categorie.name,
            style: TextStyle(
              fontSize: width(context) / 20,
              fontWeight: FontWeight.w300,
              fontFamily: GoogleFonts.gothicA1().fontFamily,
              color: tertColor,
              letterSpacing: -1.0
            ),
          ),
        ],
      ),
    ),
  );
}