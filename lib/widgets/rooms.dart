import 'package:flutter/material.dart';
import 'package:place_event/models/Rooms.dart';

import '../functions/global_variable.dart';

Widget widgetRooms(context, Rooms rooms){
  return Container(
    width: 150.0,
    margin: EdgeInsets.symmetric(horizontal: 11.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              rooms.images,
              fit: BoxFit.cover,),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16)
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${rooms.title}",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Text(
                    "${rooms.places}",
                    style: TextStyle(
                        color: secondaryColor
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}