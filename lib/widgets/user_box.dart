import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/color.dart';

class UserBox extends StatelessWidget {
  UserBox(
      {Key? key, this.onTap, this.size = 5, this.notifiedNumber = 0})
      : super(key: key);
  final GestureTapCallback? onTap;
  final int notifiedNumber;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(size),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: appBarColor,
            border: Border.all(color: Colors.grey.withOpacity(.3)),
          ),
          child: notifiedNumber > 0
              ? Badge(
                  badgeColor: actionColor,
                  padding: EdgeInsets.all(3),
                  position: BadgePosition.topEnd(top: -7, end: 0),
                  badgeContent: Text(
                    '',
                    style: TextStyle(color: Colors.white),
                  ),
                  child: Icon(
                      FontAwesomeIcons.user,
                    color: Colors.black,
                    size: 20.0,
                  ),
          )
              : Icon(
                  FontAwesomeIcons.user
                ),
      )
    );
  }
}
