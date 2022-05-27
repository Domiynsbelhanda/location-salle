import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:place_event/models/Rooms.dart';
import 'package:place_event/widgets/NavBar.dart';
import 'package:place_event/widgets/roomsHorizontal.dart';

import '../functions/api.dart';
import '../functions/global_variable.dart';

class ListItem extends StatefulWidget{

  final String? categorie;
  final String? query;
  final List<Rooms>? rooms;

  ListItem({this.categorie, this.query, this.rooms});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListItem();
  }
}

class _ListItem extends State<ListItem>{

  String navText = "Salles et Hotels";


  @override
  void initState() {
    if(widget.categorie != null){
      navText = 'Categorie : ${widget.categorie!}';
    }

    if(widget.query != null){
      navText = 'Recherche : ${widget.query!}';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            NavBar(context, navText),

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
      ),
    );
  }
}