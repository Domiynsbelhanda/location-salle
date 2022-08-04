import 'package:flutter/material.dart';

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


  @override
  void initState() {

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
                        'device_name' : 'mobile'
                      };
                      if(_formKey.currentState!.validate()){
                        print(data);
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