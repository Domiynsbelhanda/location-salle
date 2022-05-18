import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'functions/global_variable.dart';
import 'views/HomePage.dart';

void main() {
  runApp(const MyApp());
}

enum ThemeStyle {
  Dribbble,
  Light,
  NoElevation,
  AntDesign,
  BorderRadius,
  FloatingBar,
  NotificationBadge,
  WithTitle,
  BlurEffect
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Place Event',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      home: Mapping(),
    );
  }
}

class Mapping extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Mapping();
  }
}

class _Mapping extends State<Mapping>{
  int _currentIndex = 0;
  ThemeStyle _currentStyle = ThemeStyle.FloatingBar;

  List<int> _badgeCounts = List<int>.generate(4, (index) => index);
  List<bool> _badgeShows = List<bool>.generate(4, (index) => true);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: body[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: _buildFloatingBar(),
      ),
    );
  }

  List body = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage()
  ];

  Widget _buildFloatingBar() {
    return CustomNavigationBar(
      elevation: 0.0,
      iconSize: width(context) / 18,
      selectedColor: primaryColor,
      strokeColor: primaryColor,
      unSelectedColor: Colors.grey[600],
      backgroundColor: tertColor,
      borderRadius: Radius.circular(20.0),
      items: [
        CustomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.house,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.hotel,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.mapLocationDot,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.mobileRetro,
          ),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      isFloating: true,
    );
  }
}
