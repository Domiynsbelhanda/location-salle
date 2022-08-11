import 'package:flutter/material.dart';
import 'package:place_event/services/datas.dart';
import 'package:provider/provider.dart';
import 'screens/root_app.dart';
import 'services/auth.dart';
import 'theme/color.dart';

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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Booking',
      theme: ThemeData(
        primaryColor: primary,
      ),
      home: RootApp(),
    );
  }
}
