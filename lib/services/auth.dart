import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'dio.dart';

class Auth extends ChangeNotifier{
  bool _isLoggedIn = false;

  bool get authenticated => _isLoggedIn;

  void login ({required Map creds}) async {

    try {
      Dio.Response response = await dio()!.post('/sanctum/token', data: creds);
      _isLoggedIn = true;
      print('${response.data.toString()}');

      notifyListeners();
    } catch (e){
        print(e);
    }
  }

  void logout(){
    _isLoggedIn = false;
    notifyListeners();
  }
}