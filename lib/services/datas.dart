import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:place_event/models/categories.dart';
import '../models/user.dart';
import 'dio.dart';

class Datas extends ChangeNotifier{
  List<Categorie>? _categories;

  void categorie() async {
    try {
      Dio.Response response = await dio()!.get('/categorie/all');

      var datas = jsonDecode(response.data);
      List<Categorie> cat = List<Categorie>.from(datas.map((model)=> Categorie.fromJson(model)));

      print('belhanda $datas');
      notifyListeners();
    } catch (e){
        print(e);
    }
  }
}