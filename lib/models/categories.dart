class Categorie {
  int id;
  String key;
  String name;
  String slug;
  String? images;

  Categorie({
    required this.id,
    required this.key,
    required this.name,
    required this.slug,
    this.images
  });

  Categorie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        key = json['key'],
        name = json['name'],
        slug = json['slug'],
        images = json['images'];
}