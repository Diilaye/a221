class CategorieModel {
  String? color;
  String? bgColor;
  String? date;
  String? titre;
  String? slug;
  String? author;
  String? id;
  String? showMenu;
  String? statusOnline;

  CategorieModel(
      {this.color,
      this.bgColor,
      this.date,
      this.titre,
      this.slug,
      this.author,
      this.showMenu,
      this.statusOnline,
      this.id});

  CategorieModel.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    bgColor = json['bgColor'];
    date = json['date'];
    titre = json['titre'];
    slug = json['slug'];
    author = json['author'];
    id = json['id'];
    showMenu = json['showMenu'];
    statusOnline = json['statusOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['bgColor'] = this.bgColor;
    data['date'] = this.date;
    data['titre'] = this.titre;
    data['slug'] = this.slug;
    data['author'] = this.author;
    data['id'] = this.id;
    data['showMenu'] = this.showMenu;
    data['statusOnline'] = this.statusOnline;
    return data;
  }

  static List<CategorieModel> fromList({required data}) {
    List<CategorieModel> liste = [];

    for (var element in data) {
      liste.add(CategorieModel.fromJson(element));
    }
    return liste;
  }
}
