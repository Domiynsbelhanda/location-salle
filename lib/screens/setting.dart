import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../services/auth.dart';
import '../theme/color.dart';
import '../utils/constant.dart';
import '../widgets/custom_image.dart';
import '../widgets/icon_box.dart';
import '../widgets/setting_item.dart';
import 'authentification/login_screen.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: getAppBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => buildBody(),
                childCount: 1,
              ),
            )
          ],
        ));
  }

  Widget getAppBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Paramètre",
                  style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              showAlertDialog(context, 'Profile', 'Connectez-vous sur place-event.com à partir d\'un navigateur pour mettre à jour vos informations.');
            },
            child: IconBox(
              child: SvgPicture.asset(
                "assets/icons/edit.svg",
                width: 18,
                height: 18,
              ),
              bgColor: appBgColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 20, top: 10),
      child: Column(
        children: [
          Consumer<Auth>(
            builder: (context, auth, child){
              //auth.user.email
              try{
                return Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: <Widget>[
                      CustomImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/Avatar_icon_green.svg/1024px-Avatar_icon_green.svg.png'
                        ,
                        width: 80,
                        height: 80,
                        radius: 50,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        '${auth.user.email}',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${auth.user.name == null ? '' : auth.user.name} ${auth.user.surname == null ? '' : auth.user.surname}',
                        style: TextStyle(
                          color: labelColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              } catch(e){
                return Center(
                  child: SizedBox(
                    height: 45.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                      ),
                      child: Text(
                          'CONNECTEZ-VOUS'
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          SizedBox(height: 40),
          SettingItem(
              title: "Paramètre Générale",
              leadingIcon: Icons.settings,
              leadingIconColor: orange,
              onTap: () {}),
          SizedBox(height: 10),
          SettingItem(
              title: "Politique de confidentialité",
              leadingIcon: Icons.privacy_tip_outlined,
              leadingIconColor: green,
              onTap: () {}),
          SizedBox(height: 10),
          SettingItem(
            title: "Deconnextion",
            leadingIcon: Icons.logout_outlined,
            leadingIconColor: Colors.grey.shade400,
            onTap: () {
              showConfirmLogout();
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  showConfirmLogout() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: Text("Voulez-vous vous deconnecter?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pop();
            },
            child: Text(
              "Deconnection",
              style: TextStyle(color: actionColor),
            ),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("Annuler"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
