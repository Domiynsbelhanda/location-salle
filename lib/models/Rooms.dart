import 'package:place_event/models/User.dart';

class Rooms {
  final int id;
  final String key;
  final int user;
  final String title;
  final String description;
  final String images;
  final double prices;
  final int places;
  final String town;
  final String commune;
  final String address;
  final String phones;
  final String email;
  final double note;
  final double? latitude;
  final double? longitude;
  final bool confirmed;
  final bool booster;

  Rooms(
      {required this.id,
      required this.key,
      required this.user,
      required this.title,
      required this.description,
      required this.images,
      required this.prices,
      required this.places,
      required this.town,
      required this.commune,
      required this.address,
      required this.phones,
      required this.email,
      required this.note,
      this.latitude,
      this.longitude,
      required this.confirmed,
      required this.booster});

  Rooms.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        key = json['key'],
        user = json['user'],
        title = json['title'],
        description = json['description'],
        images = json['images'],
        prices = json['prices'],
        places = json['places'],
        town = json['town'],
        commune = json['commune'],
        address = json['address'],
        phones = json['phones'],
        email = json['email'],
        note = json['note'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        confirmed = json['confirmed'],
        booster = json['booster']
  ;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'key' : key,
    'user' : user,
    'title' : title,
    'description' : description,
    'images' : images,
    'prices' : prices,
    'places' : places,
    'town' : town,
    'commune' : commune,
    'address' : address,
    'phones' : phones,
    'email' : email,
    'note' : note,
    'latitude' : latitude,
    'longitude' : longitude,
    'confirmed' : confirmed,
    'booster' : booster,
  };
}