import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

import '../models/rooms.dart';
import '../widgets/recommend_item.dart';
import 'details.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key, this.allTextList, this.selectedUserList})
      : super(key: key);
  final List<Rooms>? allTextList;
  final List<Rooms>? selectedUserList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Rechercher une salle"),
      ),
      body: SafeArea(
        child: FilterListWidget<Rooms>(
          themeData: FilterListThemeData(context),
          hideSelectedTextCount: true,
          listData: this.allTextList,
          selectedListData: selectedUserList,
          choiceChipLabel: (item) {
            /// Used to print text on chip
            return item!.title;
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
          validateSelectedItem: (list, val) {
            return list!.contains(val);
          },
          onItemSearch: (user, query) {
            bool val = user.title.toLowerCase().contains(query.toLowerCase())
                || user.town.toLowerCase().contains(query.toLowerCase())
                || user.places.contains(query)
            ;
            return val;
          },
        ),
      ),
    );
  }
}