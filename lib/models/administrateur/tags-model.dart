class TagsModel {
  String? date;
  String? titre;
  String? slug;
  String? id;
  String? statusOnline;

  TagsModel({this.date, this.titre, this.slug, this.id});

  TagsModel.fromJson(Map<String, dynamic> json) {
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

  static List<TagsModel> fromList({required data}) {
    List<TagsModel> liste = [];

    for (var element in data) {
      liste.add(TagsModel.fromJson(element));
    }
    return liste;
  }
}
