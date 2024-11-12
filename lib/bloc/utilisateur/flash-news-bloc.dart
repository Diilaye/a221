import 'package:actu/models/administrateur/flash-news-model.dart';
import 'package:actu/services/utilisateur/home-service.dart';
import 'package:flutter/material.dart';

class FlashNewsUserBloc with ChangeNotifier {
  HomeService homeService = HomeService();

  List<FlashNewsModel> flashNews = [];
  FlashNewsModel? flashNewsModel;
  allFlashNews() async {
    flashNews = await homeService.allFlashNews();
    flashNewsModel = flashNews.first;
    notifyListeners();
  }

  FlashNewsUserBloc() {
    allFlashNews();
  }

  int indexShow = 0;

  setIndexShow(int i) {
    if (i < 0) {
      indexShow = flashNews.length - 1;
      notifyListeners();
    } else if (i >= flashNews.length) {
      indexShow = 0;
      notifyListeners();
    } else {
      indexShow = i;
      notifyListeners();
    }

    notifyListeners();
  }
}
