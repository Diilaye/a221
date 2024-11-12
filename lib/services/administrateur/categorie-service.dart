import 'package:actu/models/administrateur/categorie-model.dart';
import 'package:actu/utils/requette-by-dii.dart';

class CategorieService {
  Future<String?> add(Map<String, dynamic> body) async {
    return await postResponse(url: '/categories', body: body)
        .then((value) async {
      if (value['status'] == 201) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<String?> update(Map<String, dynamic> body, String id) async {
    print(body);
    return await putResponse(url: '/categories/$id', body: body)
        .then((value) async {
      print("value");
      print(value);
      if (value['status'] == 200) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<List<CategorieModel>> all() async {
    return await getResponse(url: '/categories').then((value) async {
      if (value['status'] == 200) {
        return CategorieModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }
}
