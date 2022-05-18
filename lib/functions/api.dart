import 'package:place_event/models/Categorie.dart';

import '../models/User.dart';

User user = User(
    name  : 'Dominique',
    email : 'infos@domiyns.com',
    id : 1,
    key : 'belhanda',
    surname : 'Youness',
    email_verified_at : DateTime.now(),
    password : '12345678',
    phone : '+243996852377',
    address : '15, Boulanger, Lubumbashi.',
    role_id : 1,
    images : 'https://www.pngitem.com/pimgs/b/78-786293_avatar-png-icon.png',
    date : DateTime.now(),
    gender : 'M',
    coverage : '',
    residence : '',
    social_id : '',
    social_type : '',
    rememberToken : '',
);

List jsonCategorie = [
  {
    'id' : 1,
    'key' : 'key',
    'name' : 'Salle Privée',
    'slug' : 'salle_prive',
    'images' : 'https://groupeferreira.com/wp-content/uploads/2016/07/cafe-ferreira-54.jpg'
  },

  {
    'id' : 2,
    'key' : 'conf',
    'name' : 'Salle de conférence',
    'slug' : 'salle_conference',
    'images' : 'https://upload.wikimedia.org/wikipedia/commons/f/f2/Salle_de_conf%C3%A9rence.JPG'
  },

  {
    'id' : 3,
    'key' : 'vip',
    'name' : 'VIP 1',
    'slug' : 'salle_vip1',
    'images' : 'https://www.auroch-corporate.com/wp-content/uploads/2018/05/auroch-corporate-agencement-amphitheatre-cinemas-600x400px-3-3.jpg'
  }
];

List<Categorie> categories = jsonCategorie.map((catJson) => Categorie.fromJson(catJson)).toList();

List jsonRooms = [
  {
    'id' : 1,
    'key' : 'palace',
    'user' : 1,
    'title' : 'Pacifique Palace',
    'description' : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    'images' : 'http://pacifiquepalacerdc.com/wp-content/uploads/2019/04/0014.jpg',
    'prices' : 500.0,
    'places' : 20,
    'town' : 'Kinshasa',
    'commune' : 'Limeté',
    'address' : '8, Gombé, Limeté',
    'phones' : '+243818045132',
    'email' : 'pacifique@gmail.com',
    'note' : 4,
    'latitude' : 127.0,
    'longitude' : 100.45,
    'confirmed' : false,
    'booster' : true
  },

  {
    'id' : 2,
    'key' : 'palace',
    'user' : 1,
    'title' : 'Pullman Lubumbashi',
    'description' : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    'images' : 'https://media-cdn.tripadvisor.com/media/photo-m/1280/1c/b5/84/bf/hotel-lubumbashi.jpg',
    'prices' : 250.0,
    'places' : 17,
    'town' : 'Lubumbashi',
    'commune' : 'Limeté',
    'address' : '8, Gombé, Limeté',
    'phones' : '+243818045132',
    'email' : 'pacifique@gmail.com',
    'note' : 3,
    'latitude' : 127.0,
    'longitude' : 100.45,
    'confirmed' : false,
    'booster' : true
  },

  {
    'id' : 3,
    'key' : 'palace',
    'user' : 1,
    'title' : 'NGOKAF',
    'description' : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    'images' : 'https://cf.bstatic.com/xdata/images/hotel/max1280x900/53636120.jpg?k=c70e34200dbce3dbfbcad27607dfa5c686323dab8014eb2b05fbba33d4f18caf&o=&hp=1',
    'prices' : 500.0,
    'places' : 20,
    'town' : 'Kinshasa',
    'commune' : 'Limeté',
    'address' : '8, Gombé, Limeté',
    'phones' : '+243818045132',
    'email' : 'pacifique@gmail.com',
    'note' : 2.5,
    'latitude' : 127.0,
    'longitude' : 100.45,
    'confirmed' : false,
    'booster' : true
  },

  {
    'id' : 4,
    'key' : 'palace',
    'user' : 1,
    'title' : 'New Generation',
    'description' : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    'images' : 'https://media-cdn.tripadvisor.com/media/photo-m/1280/17/92/3f/3e/hotellubumbashi.jpg',
    'prices' : 500.0,
    'places' : 20,
    'town' : 'Kinshasa',
    'commune' : 'Limeté',
    'address' : '8, Gombé, Limeté',
    'phones' : '+243818045132',
    'email' : 'pacifique@gmail.com',
    'note' : 4,
    'latitude' : 127.0,
    'longitude' : 100.45,
    'confirmed' : false,
    'booster' : true
  }
];