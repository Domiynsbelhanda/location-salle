import 'package:flutter/material.dart';
import 'package:place_event/services/datas.dart';
import 'package:provider/provider.dart';
import 'screens/root_app.dart';
import 'services/auth.dart';
import 'theme/color.dart';
import '../utils/data.dart';

void main() {
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
            return RootApp(rooms: datas.rooms, tab: 0,);
          } catch (e){
            return Scaffold(
              body: Container(
                child: Text('Belhanda'),
              ),
            );
          }

        },
      )
    );
  }

  @override
  void initState() {
    Provider.of<Datas>(context, listen: false).categorie();
    Provider.of<Datas>(context, listen: false).room();
    Provider.of<Datas>(context, listen: false).roomNoted();
  }
}
