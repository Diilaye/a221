import 'package:actu/models/administrateur/post-digiteaux-model.dart';
import 'package:actu/utils/requette-by-dii.dart';

class PostsDigiteauxService {
  Future<String?> add(Map<String, dynamic> body) async {
    return await postResponse(url: '/posts-digiteaux', body: body)
        .then((value) async {


      if (value['status'] == 201) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<String?> update(Map<String, dynamic> body, String id) async {
    return await putResponse(url: '/posts-digiteaux/$id', body: body)
        .then((value) async {


      if (value['status'] == 200) {
        return "modif réussi";
      } else {
        return null;
      }
    });
  }

  Future<List<PostsDigiteauxModel>> all() async {
    return await getResponse(url: '/posts-digiteaux').then((value) async {

      if (value['status'] == 200) {
        return PostsDigiteauxModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }
}
