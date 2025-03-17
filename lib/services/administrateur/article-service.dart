import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/requette-by-dii.dart';

class ArticleService {
  Future<String?> add(Map<String, dynamic> body) async {
    return await postResponse(url: '/articles', body: body).then((value) async {
      if (value['status'] == 201) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<String?> update(Map<String, dynamic> body, String id) async {
    print(body);
    return await putResponse(url: '/articles/$id', body: body)
        .then((value) async {
      print(value);
      if (value['status'] == 200) {
        return "modifie réussi";
      } else {
        return null;
      }
    });
  }

  Future<String?> active(Map<String, dynamic> body, String id) async {
    print(body);
    return await putResponse(url: '/articles/active/$id', body: body)
        .then((value) async {
      print(value);
      if (value['status'] == 200) {
        return "modifie réussi";
      } else {
        return null;
      }
    });
  }

    Future<ArticlePagination?> all(int page) async {
    return await getResponse(url: '/articles?page=$page').then((value) async {
      if (value['status'] == 200) {
        return ArticlePagination.fromJson(value['body']);
      } else {
        return null;
      }
    });
  }

  bool hasEmptyField(Map<String, dynamic> json) {
    return json.values.any((value) => value == null || value.toString().trim().isEmpty);
  }

  Future<ArticlePagination?> allCategorie(int page, String idCat) async {
    return await getResponse(url: '/articles/cat?page=$page&categorie=$idCat').then((value) async {

      if (value['status'] == 200) {
        return ArticlePagination.fromJson(value['body']);
      } else {
        return null;
      }
    });
  }
}
