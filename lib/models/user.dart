class User {
  int id;
  String key;
  String? name;
  String? surname;
  String email;
  String? email_verified_at;
  String? phone;
  String? address;
  var role_id;
  String? images;
  String? date;
  String? gender;
  String? coverage;
  String? residence;
  String? social_id;
  String? social_type;
  String? created_at;
  String? updated_at;
  String? deleted_at;


  User({
    this.name, required this.email, required this.id, required this.key,
    this.surname, this.address, this.images, this.social_type, this.social_id,
    this.phone, this.role_id, this.gender,
    this.residence, this.updated_at,
    this.email_verified_at, this.coverage, this.created_at, this.date, this.deleted_at
  });

  User.fromJson(Map<String, dynamic> json)
  : name = json['name'],
    email = json['email'],
    id = json['id'],
    key = json['key'],
    surname = json['surname'],
    address = json['address'],
    images = json['images'],
    social_type = json['social_type'],
    social_id = json['social_id'],
    phone = json['phone'],
    role_id = json['role_id'],
    gender = json['gender'],
    residence = json['residence'],
    updated_at = json['updated_at'],
    email_verified_at = json['email_verified_at'],
    coverage = json['coverage'],
    created_at = json['created_at'],
    date = json['date'],
    deleted_at = json['deleted_at'];
}