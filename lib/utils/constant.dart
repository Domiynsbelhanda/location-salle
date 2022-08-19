import 'dart:io';

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

Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('https://place-event.com/public/');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

showAlertDialog(BuildContext context, String titre, String message) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('$titre'),
    content: Text('$message.'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void spinner(BuildContext context, String text){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: width(context)/ 4,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 16.0,),
              new CircularProgressIndicator(),
              SizedBox(width: 16.0),
              new Text(
                '$text'
              ),
            ],
          ),
        ),
      );
    },
  );
}