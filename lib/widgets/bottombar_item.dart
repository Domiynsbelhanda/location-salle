import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/color.dart';

class BottomBarItem extends StatelessWidget {
  const BottomBarItem(this.icon,
      this.text,
      {this.onTap,
      this.color = Colors.grey,
      this.activeColor = primary,
      this.isActive = false});
  final String icon;
  final String text;
  final Color color;
  final Color activeColor;
  final bool isActive;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: bottomBarColor,
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              color: isActive ? Colors.black : color,
              width: 20,
              height: 20,
            ),
            SizedBox(height: 4.0,),
            Text(
              '${text}'
            )
          ],
        ),
      ),
    );
  }
}
