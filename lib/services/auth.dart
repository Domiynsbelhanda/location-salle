import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import '../models/user.dart';
import 'dio.dart';

class Auth extends ChangeNotifier{
  bool _isLoggedIn = false;
  User? _user;
  String? _token;

  bool get authenticated => _isLoggedIn;
  User get user => _user!;

  void login ({required Map creds}) async {

    try {
      Dio.Response response = await dio()!.post('/sanctum/token', data: creds);
      String token = response.data.toString();

      this.tryToken(token: token);
    } catch (e){
        print(e);
    }
  }

  void tryToken({required String token}) async {
    if(token == null){
      return;
    } else {
      try {
        Dio.Response response = await dio()!.post('/user',
          options: Dio.Options(
            headers: {'Authorization' : 'Bearer $token'}
          )
        );
        this._isLoggedIn = true;
        this._user = User.fromJson(response.data);
        notifyListeners();
      } catch (e){

      }
    }
  }

  void logout(){
    _isLoggedIn = false;
    notifyListeners();
  }
}