import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/models/administrateur/categorie-model.dart';
import 'package:actu/models/administrateur/file-model.dart';

class LiveFeedModel {
  String? id;
  String? titre;
  String? contenu;
  CategorieModel? categorie;
  FileModel? image;
  String? type; // breaking, update, info, urgent
  int? priorite;
  String? statusOnline;
  ArticlesModel? article;
  String? date;
  String? dateModification;

  LiveFeedModel({
    this.id,
    this.titre,
    this.contenu,
    this.categorie,
    this.image,
    this.type,
    this.priorite,
    this.statusOnline,
    this.article,
    this.date,
    this.dateModification,
  });

  factory LiveFeedModel.fromJson(Map<String, dynamic> json) {
    return LiveFeedModel(
      id: json['id'],
      titre: json['titre'],
      contenu: json['contenu'],
      categorie: json['categorie'] != null 
          ? CategorieModel.fromJson(json['categorie']) 
          : null,
      image: json['image'] != null 
          ? FileModel.fromJson(json['image']) 
          : null,
      type: json['type'],
      priorite: json['priorite'],
      statusOnline: json['statusOnline'],
      article: json['article'] != null 
          ? ArticlesModel.fromJson(json['article']) 
          : null,
      date: json['date'],
      dateModification: json['dateModification'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'contenu': contenu,
      'categorie': categorie?.id,
      'image': image?.id,
      'type': type,
      'priorite': priorite,
      'statusOnline': statusOnline,
      'article': article?.id,
      'date': date,
      'dateModification': dateModification,
    };
  }

  static List<LiveFeedModel> fromList({required List data}) {
    return data.map((item) => LiveFeedModel.fromJson(item)).toList();
  }
}
