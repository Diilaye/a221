class ArticlesModel {
  String? description;
  String? typeUne;
  List<String>? keyWorod;
  String? date;
  String? titre;
  Categorie? categorie;
  Tags? tags;
  ImageArticle? imageArticle;
  Author? author;
  String? id;
  String? statusOnline;
  String? slug;

  ArticlesModel(
      {this.description,
      this.typeUne,
      this.keyWorod,
      this.date,
      this.titre,
      this.categorie,
      this.tags,
      this.imageArticle,
      this.author,
      this.statusOnline,
      this.slug,
      this.id});

  ArticlesModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    typeUne = json['typeUne'];
    keyWorod = json['keyWorod'].cast<String>();
    date = json['date'];
    titre = json['titre'];
    categorie = json['categorie'] != null
        ? new Categorie.fromJson(json['categorie'])
        : null;
    tags = json['tags'] != null ? new Tags.fromJson(json['tags']) : null;
    imageArticle =
        json['image'] != null ? new ImageArticle.fromJson(json['image']) : null;
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    id = json['id'];
    statusOnline = json['statusOnline'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['typeUne'] = this.typeUne;
    data['keyWorod'] = this.keyWorod;
    data['date'] = this.date;
    data['titre'] = this.titre;
    if (this.categorie != null) {
      data['categorie'] = this.categorie!.toJson();
    }
    if (this.tags != null) {
      data['tags'] = this.tags!.toJson();
    }
    if (this.imageArticle != null) {
      data['imageArticle'] = this.imageArticle!.toJson();
    }
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['id'] = this.id;
    data['statusOnline'] = this.statusOnline;
    data['slug'] = this.slug;
    return data;
  }

  static List<ArticlesModel> fromList({required data}) {
    List<ArticlesModel> liste = [];

    for (var element in data) {
      liste.add(ArticlesModel.fromJson(element));
    }
    return liste;
  }
}

class Categorie {
  String? color;
  String? bgColor;
  String? titre;
  String? slug;
  String? id;

  Categorie({this.color, this.bgColor, this.titre, this.slug, this.id});

  Categorie.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    bgColor = json['bgColor'];
    titre = json['titre'];
    slug = json['slug'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['bgColor'] = this.bgColor;
    data['titre'] = this.titre;
    data['slug'] = this.slug;
    data['id'] = this.id;
    return data;
  }
}

class Tags {
  String? titre;
  String? slug;
  String? id;

  Tags({this.titre, this.slug, this.id});

  Tags.fromJson(Map<String, dynamic> json) {
    titre = json['titre'];
    slug = json['slug'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titre'] = this.titre;
    data['slug'] = this.slug;
    data['id'] = this.id;
    return data;
  }
}

class ImageArticle {
  String? url;
  String? id;

  ImageArticle({this.url, this.id});

  ImageArticle.fromJson(Map<String, dynamic> json) {
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
