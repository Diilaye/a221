import 'package:actu/models/administrateur/emission-model.dart';
import 'package:actu/models/administrateur/file-model.dart';
import 'package:actu/utils/requette-by-dii.dart';

class EmissionService {
  Future<String?> add(Map<String, dynamic> body) async {
    print(body);

    return await postResponse(url: '/emissions', body: body)
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

    return await putResponse(url: '/emissions/$id', body: body)
        .then((value) async {
      print(value);
      if (value['status'] == 200) {
        return "modif réussi";
      } else {
        return null;
      }
    });
  }

  Future<List<EmissionModel>> all() async {
    return await getResponse(url: '/emissions').then((value) async {
      if (value['status'] == 200) {
        return EmissionModel.fromList(data: value['body']['data']);
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
