import 'package:actu/models/administrateur/sous-categorie-model.dart';
import 'package:actu/utils/requette-by-dii.dart';

class SousCategorieService {
  Future<String?> add(Map<String, dynamic> body) async {
    return await postResponse(url: '/sous-categories', body: body)
        .then((value) async {
      print(value);

      if (value['status'] == 201) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<String?> update(Map<String, dynamic> body, String id) async {
    return await putResponse(url: '/sous-categories/$id', body: body)
        .then((value) async {
      print(value);

      if (value['status'] == 200) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<List<SousCategorieModel>> all() async {
    return await getResponse(url: '/sous-categories').then((value) async {
      print(value);
      if (value['status'] == 200) {
        return SousCategorieModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }
}
