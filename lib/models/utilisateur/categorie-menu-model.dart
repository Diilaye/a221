class CategorieMenuModel {
  Categorie? categorie;
  List<SousRubrique>? sousRubrique;
  List<Articles>? articles;

  CategorieMenuModel({this.categorie, this.sousRubrique, this.articles});

  CategorieMenuModel.fromJson(Map<String, dynamic> json) {
    categorie = json['categorie'] != null
        ? new Categorie.fromJson(json['categorie'])
        : null;
    if (json['sous-rubrique'] != null) {
      sousRubrique = <SousRubrique>[];
      json['sous-rubrique'].forEach((v) {
        sousRubrique!.add(new SousRubrique.fromJson(v));
      });
    }
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categorie != null) {
      data['categorie'] = this.categorie!.toJson();
    }
    if (this.sousRubrique != null) {
      data['sous-rubrique'] =
          this.sousRubrique!.map((v) => v.toJson()).toList();
    }
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categorie {
  String? color;
  String? bgColor;
  String? date;
  String? titre;
  String? slug;
  String? author;
  String? showMenu;
  String? id;

  Categorie(
      {this.color,
      this.bgColor,
      this.date,
      this.titre,
      this.slug,
      this.author,
      this.showMenu,
      this.id});

  Categorie.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    bgColor = json['bgColor'];
    date = json['date'];
    titre = json['titre'];
    slug = json['slug'];
    author = json['author'];
    showMenu = json['showMenu'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['bgColor'] = this.bgColor;
    data['date'] = this.date;
    data['titre'] = this.titre;
    data['slug'] = this.slug;
    data['author'] = this.author;
    data['showMenu'] = this.showMenu;
    data['id'] = this.id;
    return data;
  }
}

class SousRubrique {
  String? color;
  String? bgColor;
  String? date;
  String? titre;
  String? categorie;
  String? slug;
  String? id;

  SousRubrique(
      {this.color,
      this.bgColor,
      this.date,
      this.titre,
      this.categorie,
      this.slug,
      this.id});

  SousRubrique.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    bgColor = json['bgColor'];
    date = json['date'];
    titre = json['titre'];
    categorie = json['categorie'];
    slug = json['slug'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['bgColor'] = this.bgColor;
    data['date'] = this.date;
    data['titre'] = this.titre;
    data['categorie'] = this.categorie;
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
  CategorieAricle? categorieAricle;
  Tags? tags;
  ImageArticle? imageArticle;
  Author? author;
  String? id;
  String? slug;

  Articles(
      {this.description,
      this.typeUne,
      this.keyWorod,
      this.date,
      this.titre,
      this.categorieAricle,
      this.tags,
      this.imageArticle,
      this.author,
      this.slug,
      this.id});

  Articles.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    typeUne = json['typeUne'];
    keyWorod = json['keyWorod'].cast<String>();
    date = json['date'];
    titre = json['titre'];
    categorieAricle = json['categorieAricle'] != null
        ? new CategorieAricle.fromJson(json['categorieAricle'])
        : null;
    tags = json['tags'] != null ? new Tags.fromJson(json['tags']) : null;
    imageArticle =
        json['image'] != null ? new ImageArticle.fromJson(json['image']) : null;
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    id = json['id'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['typeUne'] = this.typeUne;
    data['keyWorod'] = this.keyWorod;
    data['date'] = this.date;
    data['titre'] = this.titre;
    if (this.categorieAricle != null) {
      data['categorieAricle'] = this.categorieAricle!.toJson();
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
    data['slug'] = this.slug;
    return data;
  }
}

class CategorieAricle {
  String? color;
  String? bgColor;
  String? titre;
  String? slug;
  String? id;

  CategorieAricle({this.color, this.bgColor, this.titre, this.slug, this.id});

  CategorieAricle.fromJson(Map<String, dynamic> json) {
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
