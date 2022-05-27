import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:place_event/models/Rooms.dart';
import 'package:place_event/widgets/NavBar.dart';
import 'package:place_event/widgets/roomsHorizontal.dart';

import '../functions/api.dart';
import '../functions/global_variable.dart';

class ListItem extends StatefulWidget{

  final List<Rooms>? rooms;

  ListItem({this.rooms});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListItem();
  }
}

class _ListItem extends State<ListItem>{

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //NavBar(context, navText),
          SizedBox(height: 8.0,),
          Expanded(
            child: ListView.builder(
              itemCount: rooms.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: horiRooms(context, rooms[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}