import 'package:actu/models/administrateur/tags-model.dart';
import 'package:actu/utils/requette-by-dii.dart';

class TagsService {
  Future<String?> add(Map<String, dynamic> body) async {
    return await postResponse(url: '/tags', body: body).then((value) async {
      if (value['status'] == 201) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<String?> update(Map<String, dynamic> body, String id) async {
    return await putResponse(url: '/tags/$id', body: body).then((value) async {
      if (value['status'] == 200) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<List<TagsModel>> all() async {
    return await getResponse(url: '/tags').then((value) async {
      if (value['status'] == 200) {
        return TagsModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }
}
