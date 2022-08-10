import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen>{

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String? _deviceName;


  @override
  void initState() {
    getDeviceName();
  }

  void getDeviceName() async {
    try {
      if(Platform.isAndroid){
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        _deviceName = androidInfo.model;
      } else if (Platform.isIOS){
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        _deviceName = iosInfo.model;
      }
    } catch (e){

    }
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer un email valide' : null,
                  ),

                  TextFormField(
                    controller: _passwordController,
                    validator: (value) => value!.isEmpty ? 'Veuillez entrer un mot de passe valide' : null,
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Map data = {
                        'email': _emailController.text,
                        'password' : _passwordController.text,
                        'device_name' : _deviceName ?? 'unknown',
                      };
                      if(_formKey.currentState!.validate()){
                        Provider.of<Auth>(context, listen: false).login(creds: data);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'CONNEXION'
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}