class PostsDigiteauxModel {
  String? type;
  String? date;
  ImagePost? image;
  Author? author;
  String? statusOnline;
  String? titre;
  String? id;

  PostsDigiteauxModel({this.type, this.date, this.image, this.author, this.id});

  PostsDigiteauxModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    date = json['date'];
    image =
        json['image'] != null ? new ImagePost.fromJson(json['image']) : null;
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    id = json['id'];
    statusOnline = json['statusOnline'];
    titre = json['titre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['date'] = this.date;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['id'] = this.id;
    data['statusOnline'] = this.statusOnline;
    data['titre'] = this.titre;
    return data;
  }

  static List<PostsDigiteauxModel> fromList({required data}) {
    List<PostsDigiteauxModel> liste = [];

    for (var element in data) {
      liste.add(PostsDigiteauxModel.fromJson(element));
    }
    return liste;
  }
}

class ImagePost {
  String? url;
  String? id;

  ImagePost({this.url, this.id});

  ImagePost.fromJson(Map<String, dynamic> json) {
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
