import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:place_event/models/categories.dart';
import '../models/rooms.dart';
import '../models/user.dart';
import 'dio.dart';

class Datas extends ChangeNotifier{
  List<Categorie>? _categories;
  List<Rooms>? _rooms;
  List<Rooms>? _noted;

  List<Categorie> get categories => _categories!;
  List<Rooms> get rooms => _rooms!;
  List<Rooms> get noted => _noted!;

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

  void room() async {
    try {
      Dio.Response response = await dio()!.get('/rooms/all');
      Iterable datas = jsonDecode(response.data);
      List<Rooms>? rooms = List<Rooms>.from(datas.map((model)=> Rooms.fromJson(model)));
      _rooms = rooms;
      notifyListeners();
    } catch (e){
      print(e);
    }
  }

  void recommandation() async {
    try {
      Dio.Response response = await dio()!.get('/rooms/recommandation');
      Iterable datas = jsonDecode(response.data);
      List<Rooms>? rooms = List<Rooms>.from(datas.map((model)=> Rooms.fromJson(model)));
      _rooms = rooms;
      notifyListeners();
    } catch (e){
      print(e);
    }
  }

  void roomNoted() async {
    try {
      Dio.Response response = await dio()!.get('/rooms/noted');
      Iterable datas = jsonDecode(response.data);
      List<Rooms>? rooms = List<Rooms>.from(datas.map((model)=> Rooms.fromJson(model)));
      _noted = rooms;
      notifyListeners();
    } catch (e){
      print(e);
    }
  }
}