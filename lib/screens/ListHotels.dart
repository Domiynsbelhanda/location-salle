import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:place_event/screens/details.dart';
import 'package:provider/provider.dart';
import '../models/rooms.dart';
import '../services/datas.dart';
import '../theme/color.dart';
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


  List<Rooms>? selectedUserList;

  Future<void> _openFilterDialog(userList) async {
    await FilterListDialog.display<Rooms>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(context),
      headlineText: 'Choisir une salle',
      height: 500,
      listData: userList,
      selectedListData: userList,
      choiceChipLabel: (item) => item!.title,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (user, query) {
        bool val = user.title.toLowerCase().contains(query.toLowerCase())
            || user.town.toLowerCase().contains(query.toLowerCase())
            || user.places.contains(query)
        ;
        return val;
      },

      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = List.from(list!);
        });
        Navigator.pop(context);
      },

      choiceChipBuilder: (context, item, isSelected) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: RecommendItem(
            data: item,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Details(
                  data: item,
                )),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Toutes les salles',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),

                Consumer<Datas>(
                  builder: (context, datas, child){
                  return TextButton(
                    onPressed: ()=>_openFilterDialog(datas.rooms),
                    child: const Text(
                      "Filtrer",
                      style: TextStyle(color: Colors.grey),
                    ),
                    // color: Colors.blue,
                  );
                })
              ],
            ),
          ),
          (widget.rooms!.length != 0) ?
          Expanded(
            child: ListView.builder(
              itemCount: widget.rooms!.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
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