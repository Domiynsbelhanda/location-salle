import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const int ANIMATED_BODY_MS = 500;

const Color primaryColor = Color(0xff10b981);
const Color secondaryColor = Color(0xff9dada8);
const Color tertColor = Color(0xffd7dbda);

double height (context){
  return MediaQuery.of(context).size.height;
}

double width(context){
  return MediaQuery.of(context).size.width;
}

Route createRoute(context, nextScreen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

Widget backButton(context){
  return Container(
    child: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon: Icon(
          FontAwesomeIcons.arrowLeftLong
      ),
      iconSize: width(context) / 15,
    ),
  );
}