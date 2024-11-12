class FlashNewsModel {
  String? type;
  String? desc;
  String? date;
  Author? author;
  String? id;
  String? statusOnline;

  FlashNewsModel(
      {this.type,
      this.desc,
      this.date,
      this.author,
      this.id,
      this.statusOnline});

  FlashNewsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    desc = json['desc'];
    date = json['date'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    id = json['id'];
    statusOnline = json['statusOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['desc'] = this.desc;
    data['date'] = this.date;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['id'] = this.id;
    data['statusOnline'] = this.statusOnline;
    return data;
  }

  static List<FlashNewsModel> fromList({required data}) {
    List<FlashNewsModel> liste = [];

    for (var element in data) {
      liste.add(FlashNewsModel.fromJson(element));
    }
    return liste;
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
