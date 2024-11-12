class UserModel {
  String? service;
  String? nom;
  String? prenom;
  String? telephone;
  String? date;
  String? email;
  String? token;
  String? id;
  String? statusOnline;

  UserModel(
      {this.service,
      this.nom,
      this.prenom,
      this.telephone,
      this.date,
      this.email,
      this.token,
      this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    nom = json['nom'];
    prenom = json['prenom'];
    telephone = json['telephone'];
    date = json['date'];
    email = json['email'];
    token = json['token'];
    id = json['id'];
    statusOnline = json['statusOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service'] = this.service;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['telephone'] = this.telephone;
    data['date'] = this.date;
    data['email'] = this.email;
    data['token'] = this.token;
    data['id'] = this.id;
    data['statusOnline'] = this.statusOnline;
    return data;
  }

  static List<UserModel> fromList({required data}) {
    List<UserModel> liste = [];

    for (var element in data) {
      liste.add(UserModel.fromJson(element));
    }
    return liste;
  }
}
