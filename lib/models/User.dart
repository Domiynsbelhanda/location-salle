class User {
  final int id;
  final String key;
  final String? name;
  final String? surname;
  final String email;
  final DateTime? email_verified_at;
  final String? password;
  final String? phone;
  final String? address;
  final int role_id;
  final String? images;
  final DateTime? date;
  final String? gender;
  final String? coverage;
  final String? residence;
  final String? social_id;
  final String? social_type;
  final String? rememberToken;


  User(
      {this.name,
      required this.email,
      required this.id,
      required this.key,
      this.surname,
      this.email_verified_at,
      this.password,
      this.phone,
      this.address,
      required this.role_id,
      this.images,
      this.date,
      this.gender,
      this.coverage,
      this.residence,
      this.social_id,
      this.social_type,
      this.rememberToken});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        id = json['id'],
        key= json['key'],
        surname = json['surname'],
        email_verified_at = json['email_verified_at'],
        password = json['password'],
        phone = json['phone'],
        address = json['address'],
        role_id = json['role_id'],
        images = json['images'],
        date = json['date'],
        gender = json['gender'],
        coverage = json['coverage'],
        residence = json['residence'],
        social_id = json['social_id'],
        social_type = json['social_type'],
        rememberToken = json['rememberToken']
  ;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'email' : email,
    'id' : id,
    'key': key,
    'surname' : surname,
    'email_verified_at' : email_verified_at,
    'password' : password,
    'phone' : phone,
    'address' : address,
    'role_id' : role_id,
    'images' : images,
    'date' : date,
    'gender' : gender,
    'coverage' : coverage,
    'residence' : residence,
    'social_id' : social_id,
    'social_type' : social_type,
    'rememberToken' : rememberToken
  };
}