import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:place_event/models/Rooms.dart';

import '../functions/global_variable.dart';

Widget widgetRooms(context, Rooms rooms){
  return Container(
    width: 150.0,
    margin: EdgeInsets.symmetric(horizontal: 11.0),
    child: Card(
      elevation: 8.0,
      color: Colors.transparent,
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
                            fontSize: width(context) / 25,
                            fontWeight: FontWeight.normal,
                            color: Colors.white)
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16)
                    )
                ),
                child: RatingBarIndicator(
                  rating: rooms.note,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: width(context) / 20,
                  unratedColor: Colors.amber.withAlpha(50),
                  direction: Axis.horizontal,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}