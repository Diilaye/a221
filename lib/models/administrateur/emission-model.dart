class EmissionModel {
  String? type;
  String? urlMedia;
  String? description;
  String? heure;
  String? date;
  String? titre;
  PhotoCouverture? photoCouverture;
  String? slug;
  Author? author;
  String? id;
  String? statusOnline;

  EmissionModel(
      {this.type,
      this.urlMedia,
      this.description,
      this.heure,
      this.date,
      this.titre,
      this.photoCouverture,
      this.slug,
      this.author,
      this.statusOnline,
      this.id});

  EmissionModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    urlMedia = json['urlMedia'];
    description = json['description'];
    heure = json['heure'];

    date = json['date'];
    titre = json['titre'];
    photoCouverture = json['photoCouverture'] != null
        ? new PhotoCouverture.fromJson(json['photoCouverture'])
        : null;
    slug = json['slug'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    id = json['id'];
    statusOnline = json['statusOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['urlMedia'] = this.urlMedia;
    data['description'] = this.description;
    data['heure'] = this.heure;

    data['date'] = this.date;
    data['titre'] = this.titre;
    if (this.photoCouverture != null) {
      data['photoCouverture'] = this.photoCouverture!.toJson();
    }
    data['slug'] = this.slug;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['id'] = this.id;
    data['statusOnline'] = this.statusOnline;
    return data;
  }

  static List<EmissionModel> fromList({required data}) {
    List<EmissionModel> liste = [];

    for (var element in data) {
      liste.add(EmissionModel.fromJson(element));
    }
    return liste;
  }
}

class PhotoCouverture {
  String? url;
  String? id;

  PhotoCouverture({this.url, this.id});

  PhotoCouverture.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['id'] = this.id;
    return data;
  }
}

class Author {
  String? nom;
  String? prenom;
  String? id;

  Author({this.nom, this.prenom, this.id});

  Author.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    prenom = json['prenom'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['id'] = this.id;
    return data;
  }
}
