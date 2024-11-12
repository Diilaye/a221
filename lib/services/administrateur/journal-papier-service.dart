import 'package:actu/models/administrateur/journal-papier-model.dart';
import 'package:actu/utils/requette-by-dii.dart';

class JournalPapierService {
  Future<String?> add(Map<String, dynamic> body) async {
    return await postResponse(url: '/journal-papier', body: body)
        .then((value) async {
      if (value['status'] == 201) {
        return "ajout réussi";
      } else {
        return null;
      }
    });
  }

  Future<String?> update(Map<String, dynamic> body, String id) async {
    return await putResponse(url: '/journal-papier/$id', body: body)
        .then((value) async {
      if (value['status'] == 200) {
        return "modif réussi";
      } else {
        return null;
      }
    });
  }

  Future<List<PapierJournalModel>> all() async {
    return await getResponse(url: '/journal-papier').then((value) async {
      if (value['status'] == 200) {
        return PapierJournalModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }
}
