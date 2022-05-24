class Categorie {
  final int id;
  final String key;
  final String name;
  final String slug;
  final String images;

  Categorie({required this.id, required this.key, required this.name, required this.slug, required this.images});

  Categorie.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      key = json['key'],
      name = json['name'],
      slug = json['slug'],
      images = json['images'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'key' : key,
    'name' : name,
    'slug' : slug,
    'images' : images
  };
}