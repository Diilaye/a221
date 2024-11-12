class SousCategorieModel {
  String? color;
  String? bgColor;
  String? date;
  String? titre;
  Categorie? categorie;
  String? slug;
  String? id;
  String? statusOnline;

  SousCategorieModel(
      {this.color,
      this.bgColor,
      this.date,
      this.titre,
      this.categorie,
      this.slug,
      this.statusOnline,
      this.id});

  SousCategorieModel.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    bgColor = json['bgColor'];
    date = json['date'];
    titre = json['titre'];
    categorie = json['categorie'] != null
        ? new Categorie.fromJson(json['categorie'])
        : null;
    slug = json['slug'];
    id = json['id'];
    statusOnline = json['statusOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['bgColor'] = this.bgColor;
    data['date'] = this.date;
    data['titre'] = this.titre;
    if (this.categorie != null) {
      data['categorie'] = this.categorie!.toJson();
    }
    data['slug'] = this.slug;
    data['id'] = this.id;
    data['statusOnline'] = this.statusOnline;
    return data;
  }

  static List<SousCategorieModel> fromList({required data}) {
    List<SousCategorieModel> liste = [];

    for (var element in data) {
      liste.add(SousCategorieModel.fromJson(element));
    }
    return liste;
  }
}

class Categorie {
  String? titre;
  String? id;

  Categorie({this.titre, this.id});

  Categorie.fromJson(Map<String, dynamic> json) {
    titre = json['titre'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titre'] = this.titre;
    data['id'] = this.id;
    return data;
  }
}
