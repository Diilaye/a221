class PapierJournalModel {
  String? date;
  ImageJournal? image;
  Author? author;
  String? id;
  String? statusOnline;

  PapierJournalModel({this.date, this.image, this.author, this.id});

  PapierJournalModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    image =
        json['image'] != null ? new ImageJournal.fromJson(json['image']) : null;
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    id = json['id'];
    statusOnline = json['statusOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['id'] = this.id;
    data['statusOnline'] = this.statusOnline;
    return data;
  }

  static List<PapierJournalModel> fromList({required data}) {
    List<PapierJournalModel> liste = [];

    for (var element in data) {
      liste.add(PapierJournalModel.fromJson(element));
    }
    return liste;
  }
}

class ImageJournal {
  String? url;
  String? id;

  ImageJournal({this.url, this.id});

  ImageJournal.fromJson(Map<String, dynamic> json) {
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
