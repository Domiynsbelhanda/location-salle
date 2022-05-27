import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../functions/global_variable.dart';
import '../models/Rooms.dart';

Widget horiRooms(context, Rooms rooms){
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
    child: Container(
      child: Card(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: width(context) / 5,
            child: Row(
              children: [
                Card(
                  elevation: 0.0,
                  child: Container(
                    height: width(context) / 5,
                    width: width(context) / 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        '${rooms.images}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.0),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${rooms.title}'.toUpperCase(),
                        style: TextStyle(
                            fontSize: width(context) / 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black
                        )
                    ),

                    RatingBarIndicator(
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

                    Text(
                        '${rooms.places} places - ${rooms.prices}\$',
                        style: TextStyle(
                            fontSize: width(context) / 22,
                            fontWeight: FontWeight.normal,
                            color: secondaryColor
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}