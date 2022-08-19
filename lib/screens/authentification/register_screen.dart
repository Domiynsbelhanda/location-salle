import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:place_event/main.dart';
import 'package:place_event/screens/authentification/login_screen.dart';
import 'package:place_event/screens/root_app.dart';
import 'package:place_event/utils/constant.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';

class RegisterScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterScreen();
  }
}

class _RegisterScreen extends State<RegisterScreen>{

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
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
    _userNameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0,16.0),
              child: Image.asset(
                'assets/images/logo2.png',
                width: MediaQuery.of(context).size.width / 1.5,
                fit: BoxFit.contain,
              ),
            ),

            Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0,0),
                child: Text(
                  'Créer un compte',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0
                  ),
                ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nom d\'utilisateur',
                      style: TextStyle(
                          fontSize: 18.0
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _userNameController,
                      validator: (value) => value!.isEmpty ? 'Veuillez entrer un nom valide' : null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Enter your username",
                          fillColor: Colors.white70
                      ),
                    ),
                    SizedBox(height: 16.0),


                    Text(
                      'Adresse mail',
                      style: TextStyle(
                          fontSize: 18.0
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) => value!.isEmpty ? 'Veuillez entrer un email valide' : null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Enter your email adress",
                          fillColor: Colors.white70
                      ),
                    ),
                    SizedBox(height: 16.0),

                    Text(
                      'Mot de passe',
                      style: TextStyle(
                          fontSize: 18.0
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) => value!.isEmpty ? 'Veuillez entrer un mot de passe valide' : null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Enter your password",
                          fillColor: Colors.white70
                      ),
                    ),
                    SizedBox(height: 16.0),

                    Text(
                      'Confirmation MDP',
                      style: TextStyle(
                          fontSize: 18.0
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _confirmPasswordController,
                      validator: (value) => value!.isEmpty ? 'Veuillez entrer un mot de passe valide' : null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Enter your confirm password",
                          fillColor: Colors.white70
                      ),
                    ),
                    SizedBox(height: 16.0),

                    SizedBox(
                      width: double.infinity,
                      height: 45.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Map data = {
                            'name': _userNameController.text,
                            'email': _emailController.text,
                            'password' : _passwordController.text,
                            'device_name' : _deviceName ?? 'unknown',
                          };
                          if(_formKey.currentState!.validate()){
                            if(_confirmPasswordController.text.trim() == _passwordController.text){
                              // showDialog(
                              //   context: context,
                              //   barrierDismissible: false,
                              //   builder: (BuildContext context) {
                              //     return Dialog(
                              //       child: Container(
                              //         height: width(context)/ 4,
                              //         child: Row(
                              //           mainAxisSize: MainAxisSize.min,
                              //           children: [
                              //             SizedBox(width: 16.0,),
                              //             new CircularProgressIndicator(),
                              //             SizedBox(width: 16.0),
                              //             new Text(
                              //                 'Chargement...'
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // );
                              Provider.of<Auth>(context, listen: false).register(creds: data, context: context);
                              //Navigator.pop(context);
                            } else {
                              showAlertDialog(context, 'Authentification', 'Mot de passe de confirmation incorrect.');
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                        ),
                        child: Text(
                          'INSCRIPTION'
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0,16.0),
              child: Row(
                children: [
                  Text(
                    'Vous avez un compte? ',
                    style: TextStyle(
                        fontSize: 15.0
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen())
                      );
                    },
                    child: Text(
                      'Connectez-vous.',
                      style: TextStyle(
                        color: primaryColor,
                          fontSize: 15.0
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}