import 'package:flutter/material.dart';

import '../functions/global_variable.dart';

Widget NavBar(context, navText){
  return Container(
    decoration: BoxDecoration(
        color: tertColor
    ),
    child: Padding(
      padding: const EdgeInsets.only(left:16.0, right: 16.0),
      child: Row(
        children: [
          backButton(context),

          SizedBox(width: width(context) / 80,),

          Text(
            navText,
            style: TextStyle(
                fontSize: width(context) / 20
            ),
          )
        ],
      ),
    ),
  );
}