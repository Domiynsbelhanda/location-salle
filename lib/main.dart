import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:place_event/services/datas.dart';
import 'package:place_event/utils/errorEnum.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'screens/root_app.dart';
import 'services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

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
      theme:ThemeData(

        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
      )),
      home: SplashScreen(
        seconds: 10,
        navigateAfterSeconds: Consumer<Datas>(
          builder: (context, datas, child){
            try {
              return RootApp(rooms: datas.rooms, tab: 0, error: false,);
            } catch (e){
              return RootApp(tab: 0, error: true, errorType: ErrorStatus.offline,);
            }
            },
          ),
        title: new Text('PLACE EVENT'),
        image: new Image.asset('assets/images/icon.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.red,
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