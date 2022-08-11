import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:place_event/models/categories.dart';
import '../models/user.dart';
import 'dio.dart';

class Datas extends ChangeNotifier{
  List<Categorie>? _categories;

  List<Categorie> get categories => _categories!;

  void categorie() async {
    try {
      Dio.Response response = await dio()!.get('/categorie/all');
      Iterable datas = jsonDecode(response.data);
      List<Categorie>? cat = List<Categorie>.from(datas.map((model)=> Categorie.fromJson(model)));
      _categories = cat;
      notifyListeners();
    } catch (e){
        print(e);
    }
  }
}