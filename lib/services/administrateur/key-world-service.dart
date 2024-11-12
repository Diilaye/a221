import 'package:actu/models/administrateur/mot-cles-model.dart';
import 'package:actu/utils/requette-by-dii.dart';

class KeyWorlService {
  Future<String?> add(Map<String, dynamic> body) async {
    return await postResponse(url: '/mots-cles', body: body)
        .then((value) async {
      if (value['status'] == 201) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<String?> update(Map<String, dynamic> body, String id) async {
    return await putResponse(url: '/mots-cles/$id', body: body)
        .then((value) async {
      print(value);
      if (value['status'] == 200) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<List<MotClesModel>> all() async {
    return await getResponse(url: '/mots-cles').then((value) async {
      if (value['status'] == 200) {
        return MotClesModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }
}
