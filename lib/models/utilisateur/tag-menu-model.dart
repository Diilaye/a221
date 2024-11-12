class TagModelMenu {
  Tag? tag;
  List<Articles>? articles;

  TagModelMenu({this.tag, this.articles});

  TagModelMenu.fromJson(Map<String, dynamic> json) {
    tag = json['tag'] != null ? new Tag.fromJson(json['tag']) : null;
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tag != null) {
      data['tag'] = this.tag!.toJson();
    }
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tag {
  String? statusOnline;
  String? date;
  String? titre;
  String? slug;
  String? id;

  Tag({this.statusOnline, this.date, this.titre, this.slug, this.id});

  Tag.fromJson(Map<String, dynamic> json) {
    statusOnline = json['statusOnline'];
    date = json['date'];
    titre = json['titre'];
    slug = json['slug'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusOnline'] = this.statusOnline;
    data['date'] = this.date;
    data['titre'] = this.titre;
    data['slug'] = this.slug;
    data['id'] = this.id;
    return data;
  }
}

class Articles {
  String? description;
  String? typeUne;
  List<String>? keyWorod;
  String? date;
  String? titre;
  Categorie? categorie;
  Tags? tags;
  ImageArticle? image;
  Author? author;
  String? slug;
  String? statusOnline;
  String? id;

  Articles(
      {this.description,
      this.typeUne,
      this.keyWorod,
      this.date,
      this.titre,
      this.categorie,
      this.tags,
      this.image,
      this.author,
      this.slug,
      this.statusOnline,
      this.id});

  Articles.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    typeUne = json['typeUne'];
    keyWorod = json['keyWorod'].cast<String>();
    date = json['date'];
    titre = json['titre'];
    categorie = json['categorie'] != null
        ? new Categorie.fromJson(json['categorie'])
        : null;
    tags = json['tags'] != null ? new Tags.fromJson(json['tags']) : null;
    image =
        json['image'] != null ? new ImageArticle.fromJson(json['image']) : null;
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    slug = json['slug'];
    statusOnline = json['statusOnline'];
    id = json['id'];
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
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['slug'] = this.slug;
    data['statusOnline'] = this.statusOnline;
    data['id'] = this.id;
    return data;
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
