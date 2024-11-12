import 'package:actu/models/administrateur/flash-news-model.dart';
import 'package:actu/utils/requette-by-dii.dart';

class FlashNewsService {
  Future<String?> add(Map<String, dynamic> body) async {
    return await postResponse(url: '/flash-news', body: body)
        .then((value) async {
      if (value['status'] == 201) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<String?> update(Map<String, dynamic> body, String id) async {
    return await putResponse(url: '/flash-news/$id', body: body)
        .then((value) async {
      if (value['status'] == 200) {
        return "modif réussi";
      } else {
        return null;
      }
    });
  }

  Future<List<FlashNewsModel>> all() async {
    return await getResponse(url: '/flash-news').then((value) async {
      if (value['status'] == 200) {
        return FlashNewsModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }
}
