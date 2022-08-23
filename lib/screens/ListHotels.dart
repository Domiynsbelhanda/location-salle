import 'package:flutter/material.dart';
import 'package:place_event/screens/details.dart';
import 'package:provider/provider.dart';
import '../models/rooms.dart';
import '../services/datas.dart';
import '../widgets/recommend_item.dart';

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
          (widget.rooms!.length != 0) ?
          Expanded(
            child: ListView.builder(
              itemCount: widget.rooms!.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: RecommendItem(
                    data: widget.rooms![index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Details(
                          data: widget.rooms![index],
                        )),
                      );
                    },
                  ),
                );
              },
            ),
          ) :
          Consumer<Datas>(
            builder: (context, datas, child){
              try{
                return Expanded(
                  child: ListView.builder(
                    itemCount: datas.rooms.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: RecommendItem(
                          data: datas.rooms[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Details(
                                data: datas.rooms[index],
                              )),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              } catch(e){
                return SizedBox();
              }
            }
          )
        ],
      ),
    );
  }
}