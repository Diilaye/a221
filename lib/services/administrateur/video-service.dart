/*import 'package:actu/models/administrateur/VideoModel.dart';
import 'package:actu/models/administrateur/emission-model.dart';
import 'package:actu/models/administrateur/file-model.dart';
import 'package:actu/utils/requette-by-dii.dart';

class VideosService {
  Future<String?> add(Map<String, dynamic> body) async {
    print(body);

    return await postResponse(url: '/videos', body: body)
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
    print(body);

    return await putResponse(url: '/videos/$id', body: body)
        .then((value) async {
      print(value);
      if (value['status'] == 200) {
        return "modif réussi";
      } else {
        return null;
      }
    });
  }

  Future<List<VideoModel>> all() async {
    return await getResponse(url: '/videos').then((value) async {
      if (value['status'] == 200) {
        return VideoModel.fromList(data: value['body']);
      } else {
        return [];
      }
    });
  }

  Future<List<FileModel>> allFile() async {
    return await getResponse(url: '/files').then((value) async {
      if (value['status'] == 200) {
        return FileModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }


}


 */