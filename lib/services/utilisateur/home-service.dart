import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/models/administrateur/categorie-model.dart';
import 'package:actu/models/administrateur/emission-model.dart';
import 'package:actu/models/administrateur/flash-news-model.dart';
import 'package:actu/models/administrateur/journal-papier-model.dart';
import 'package:actu/models/administrateur/post-digiteaux-model.dart';
import 'package:actu/models/administrateur/video-youtube-model.dart';
import 'package:actu/models/utilisateur/categorie-menu-model.dart';
import 'package:actu/models/utilisateur/tag-menu-model.dart';
import 'package:actu/utils/requette-by-dii.dart';

class HomeService {
  Future<List<CategorieModel>> allCatgerie() async {
    return await getResponse(url: '/categories').then((value) async {
      if (value['status'] == 200) {
        return CategorieModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<List<FlashNewsModel>> allFlashNews() async {
    return await getResponse(url: '/flash-news').then((value) async {
      if (value['status'] == 200) {
        return FlashNewsModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<List<PostsDigiteauxModel>> allPostDigiteaux() async {
    return await getResponse(url: '/posts-digiteaux').then((value) async {
      if (value['status'] == 200) {
        return PostsDigiteauxModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<List<PapierJournalModel>> allPapierJournal() async {
    return await getResponse(url: '/journal-papier').then((value) async {
      // print(value);

      if (value['status'] == 200) {
        return PapierJournalModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<List<EmissionModel>> allEmission() async {
    return await getResponse(url: '/emissions').then((value) async {
      // print(value);

      if (value['status'] == 200) {
        return EmissionModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<List<ArticlesModel>> allAricles() async {
    return await getResponse(url: '/articles').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<List<ArticlesModel>> uneArticles() async {
    return await getResponse(url: '/articles/une').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<List<ArticlesModel>> articleActualite() async {
    return await getResponse(url: '/articles/articleActualite').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<List<ArticlesModel>> articlePolitique() async {
    return await getResponse(url: '/articles/articlePolitique').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<ArticlesModel?> unePolitique() async {
    return await getResponse(url: '/articles/unePolitique').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromJson( value['body']['data']);
      } else {
        return null;
      }
    });
  }

  Future<List<ArticlesModel>> articleEconomie() async {
    return await getResponse(url: '/articles/articleEconomie').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<ArticlesModel?> uneEconomie() async {
    return await getResponse(url: '/articles/uneEconomie').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromJson( value['body']['data']);
      } else {
        return null;
      }
    });
  }

  Future<List<ArticlesModel>> articleInvestigation() async {
    return await getResponse(url: '/articles/articleInvestigation').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<ArticlesModel?> uneInvestigation() async {
    return await getResponse(url: '/articles/uneInvestigation').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromJson( value['body']['data']);
      } else {
        return null;
      }
    });
  }

  Future<List<ArticlesModel>> articleChoixRedac() async {
    return await getResponse(url: '/articles/articleChoixRedac').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<List<ArticlesModel>> articleContribution() async {
    return await getResponse(url: '/articles/articleContribution').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<List<ArticlesModel>> articleSport() async {
    return await getResponse(url: '/articles/articleSport').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<List<ArticlesModel>> articleCulture() async {
    return await getResponse(url: '/articles/articleCulture').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<List<ArticlesModel>> articleAfrique() async {
    return await getResponse(url: '/articles/articleAfrique').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<List<ArticlesModel>> articleInternational() async {
    return await getResponse(url: '/articles/articleInternational').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<List<VideoYoutubeModel>> allVideos() async {
    return await getResponse(url: '/videos/').then((value) async {
      if (value['status'] == 200) {
        return VideoYoutubeModel.fromList(data: value['body']['data']);
      } else {
        return [];
      }
    });
  }

  Future<ArticlesModel?> ArtilceTop() async {
    return await getResponse(url: '/articles/top').then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromJson(value['body']['data']);
      } else {
        return null;
      }
    });
  }

  Future<CategorieMenuModel?> categorieMenu(String id) async {
    return await getResponse(url: '/categories/$id').then((value) async {
      if (value['status'] == 200) {
        return CategorieMenuModel.fromJson(value['body']['data']);
      } else {
        return null;
      }
    });
  }

  Future<CategorieMenuModel?> categorieMenuName(String id) async {
    return await getResponse(url: '/categories/slug/$id').then((value) async {
      if (value['status'] == 200) {
        return CategorieMenuModel.fromJson(value['body']['data']);
      } else {
        return null;
      }
    });
  }

  Future<TagModelMenu?> tagsMenuName(String id) async {
    return await getResponse(url: '/tags/slug/$id').then((value) async {
      if (value['status'] == 200) {
        return TagModelMenu.fromJson(value['body']['data']);
      } else {
        return null;
      }
    });
  }

  Future<ArticlesModel?> articleSlug(String slug) async {
    return await getResponse(url: '/articles/article/$slug')
        .then((value) async {
      if (value['status'] == 200) {
        return ArticlesModel.fromJson(value['body']['data']);
      } else {
        return null;
      }
    });
  }
}
