import 'package:flutter/material.dart';
import 'package:place_event/screens/ListHotels.dart';
import '../models/rooms.dart';
import '../screens/setting.dart';
import '../theme/color.dart';
import '../utils/constant.dart';
import '../utils/data.dart';
import '../utils/errorEnum.dart';
import '../widgets/bottombar_item.dart';

import 'home.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key, this.rooms, this.tab, this.error, this.errorType, this.network}) : super(key: key);
  final List<Rooms>? rooms;
  final int? tab;
  final bool? error;
  final ErrorStatus? errorType;
  final String? network;

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {

  int activeTabIndex = 0;
  List barItems = [];

//====== set animation=====
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: ANIMATED_BODY_MS),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
    activeTabIndex = widget.tab!;
    barItems = [
      {
        "icon": "assets/icons/home.svg",
        "page": HomePage(),
      },
      {
        "icon": "assets/icons/explore.svg",
        "page": ListItem(rooms: widget.rooms)
      },
      {
        "icon": "assets/icons/pin-area.svg",
        "page": Container(
          alignment: Alignment.center,
          child: Text("Nearby"),
        ),
      },
      {
        "icon": "assets/icons/setting.svg",
        "page": SettingPage(),
      },
    ];
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  animatedPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

  void onPageChanged(int index) {
    if (index == activeTabIndex) return;
    _controller.reset();
    setState(() {
      activeTabIndex = index;
    });
    _controller.forward();
  }

//====== end set animation=====

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        bottomNavigationBar: getBottomBar(),
        body: Stack(
          children: [
            getBarPage(),
            widget.error! ? Positioned(
              bottom: 0.0,
              child: Container(
                height: width(context) / 7,
                width: width(context) / 1,
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: widget.errorType!.name == 'offline' ? offline() : SizedBox()
              ),
            ) : SizedBox()
          ],
        ));
  }

  Widget offline(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Erreur de connection,',
          style: TextStyle(
            color: primary
          ),
        ),

        IconButton(
            onPressed: (){

            },
            icon: Icon(
              Icons.refresh,
              color: primary,
            )
        ),
        Text(
          'Actualisé',
          style: TextStyle(
            color: primary
          ),
        )
      ],
    );
  }

  Widget getBarPage() {
    return IndexedStack(
        index: activeTabIndex,
        children: List.generate(
            barItems.length, (index) => animatedPage(barItems[index]["page"])));
  }

  Widget getBottomBar() {
    return Container(
      height: width(context) / 7,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bottomBarColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: shadowColor.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(0, 1))
          ]),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            barItems.length,
            (index) => BottomBarItem(
              barItems[index]["icon"],
              isActive: activeTabIndex == index,
              activeColor: primary,
              onTap: () {
                onPageChanged(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
