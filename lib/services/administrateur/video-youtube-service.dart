import 'package:actu/models/administrateur/tags-model.dart';
import 'package:actu/models/administrateur/video-youtube-model.dart';
import 'package:actu/utils/requette-by-dii.dart';

import '../../models/administrateur/file-model.dart';

class VideoYoutubeService {
  Future<String?> add(Map<String, dynamic> body) async {
    return await postResponse(url: '/videoRubriqueRoutes', body: body).then((value) async {
      if (value['status'] == 201) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<String?> update(Map<String, dynamic> body, String id) async {
    return await putResponse(url: '/videoRubriqueRoutes/$id', body: body).then((value) async {
      if (value['status'] == 200) {
        return "ajout réussi";
      } else {
        return null;
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

  Future<List<VideoYoutubeModel>> all() async {
    return await getResponse(url: '/videoRubriqueRoutes').then((value) async {
      if (value['status'] == 200) {
        return VideoYoutubeModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }
}
