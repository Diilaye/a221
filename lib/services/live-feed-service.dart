import 'package:actu/models/live-feed-model.dart';
import 'package:actu/utils/requette-by-dii.dart';

class LiveFeedService {
  // Récupérer toutes les actualités live
  Future<List<LiveFeedModel>> all(int page) async {
    return await getResponse(url: '/live-feed?page=$page&pageSize=50')
        .then((value) async {
      if (value['status'] == 200) {
        return LiveFeedModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  // Récupérer les dernières actualités (pour le bandeau)
  Future<List<LiveFeedModel>> latest({int limit = 10}) async {
    return await getResponse(url: '/live-feed/latest?limit=$limit')
        .then((value) async {
      if (value['status'] == 200) {
        return LiveFeedModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  // Récupérer les actualités urgentes
  Future<List<LiveFeedModel>> breaking() async {
    return await getResponse(url: '/live-feed/breaking').then((value) async {
      if (value['status'] == 200) {
        return LiveFeedModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  // Ajouter une actualité live (admin)
  Future<String?> add(Map<String, dynamic> body) async {
    return await postResponse(url: '/live-feed', body: body)
        .then((value) async {
      if (value['status'] == 201) {
        return "Actualité live ajoutée avec succès";
      } else {
        return null;
      }
    });
  }

  // Modifier une actualité live (admin)
  Future<String?> update(Map<String, dynamic> body, String id) async {
    return await putResponse(url: '/live-feed/$id', body: body)
        .then((value) async {
      if (value['status'] == 200) {
        return "Actualité live modifiée avec succès";
      } else {
        return null;
      }
    });
  }

  // Supprimer une actualité live (admin)
  Future<String?> delete(String id) async {
    return await deleteResponse(url: '/live-feed/$id').then((value) async {
      if (value['status'] == 200) {
        return "Actualité live supprimée avec succès";
      } else {
        return null;
      }
    });
  }

  // Récupérer toutes les actualités (admin)
  Future<List<LiveFeedModel>> allForAdmin(int page, {String status = 'on'}) async {
    return await getResponse(url: '/live-feed/admin/all?page=$page&status=$status')
        .then((value) async {
      if (value['status'] == 200) {
        return LiveFeedModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }
}
