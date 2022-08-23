import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:place_event/services/datas.dart';
import 'package:place_event/utils/constant.dart';
import 'package:place_event/utils/errorEnum.dart';
import 'package:provider/provider.dart';
import 'screens/root_app.dart';
import 'services/auth.dart';
import 'theme/color.dart';

void main() {
  // var out = '\\x01\\x01';
  // print('printing out as --> ${out.replaceAll('\\x', 'X')} <--');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> Auth()),
        ChangeNotifierProvider(create: (context)=> Datas())
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyApp();
  }
}

class _MyApp extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Place Event',
      theme: ThemeData(
        primaryColor: primary,
      ),
      home: Consumer<Datas>(
        builder: (context, datas, child){
          try {
            return RootApp(rooms: datas.rooms, tab: 0, error: false,);
          } catch (e){
            return RootApp(tab: 0, error: true, errorType: ErrorStatus.offline,);
          }
        },
      )
    );
  }

  @override
  void initState() {
    super.initState();
    read();
    readToken();
  }

  void read(){
    Provider.of<Datas>(context, listen: false).categorie();
    Provider.of<Datas>(context, listen: false).room();
    Provider.of<Datas>(context, listen: false).roomNoted();
  }

  void readToken() async {
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    if(token != null){
      Provider.of<Auth>(context, listen: false).tryToken(token: token, context: context);
    }
  }
}