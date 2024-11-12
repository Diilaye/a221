class MotClesModel {
  String? date;
  String? titre;
  String? slug;
  String? id;
  String? statusOnline;

  MotClesModel({this.date, this.titre, this.slug, this.id});

  MotClesModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    titre = json['titre'];
    slug = json['slug'];
    id = json['id'];
    statusOnline = json['statusOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['titre'] = this.titre;
    data['slug'] = this.slug;
    data['id'] = this.id;
    data['statusOnline'] = this.statusOnline;
    return data;
  }

  static List<MotClesModel> fromList({required data}) {
    List<MotClesModel> liste = [];

    for (var element in data) {
      liste.add(MotClesModel.fromJson(element));
    }
    return liste;
  }
}
