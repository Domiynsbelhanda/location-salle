import 'categories.dart';

class Rooms {
  int id;
  String key;
  var user_id;
  String title;
  String description;
  String images;
  var prices;
  var places;
  String town;
  String commune;
  String address;
  var phones;
  String email;
  var note;
  var latitude;
  var longitude;
  bool confirmed;
  bool booster;
  List<dynamic>? categories;

  Rooms({
    required this.id, required this.key, required this.user_id, required this.title, required this.description,
    required this.images, required this.prices, required this.places, required this.town, required this.commune,
    required this.address, this.phones, required this.email, required this.confirmed, required this.booster,
    required this.note, this.latitude, this.longitude, this.categories
  });

  Rooms.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        key = json['key'],
        user_id = json['user_id'],
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
        confirmed = json['confirmed'],
        booster = json['booster'],
        note = json['note'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        categories = json['categories']  ;
}