import 'dart:async';

import 'package:actu/models/administrateur/flash-news-model.dart';
import 'package:actu/services/utilisateur/home-service.dart';
import 'package:flutter/material.dart';

class FlashNewsUserBloc with ChangeNotifier {
  HomeService homeService = HomeService();

  List<FlashNewsModel> flashNews = [];
  FlashNewsModel? flashNewsModel;
  bool isLoading = true;
  
  allFlashNews() async {
    isLoading = true;
    _safeNotify();
    
    try {
      print('🔄 Chargement des flash news...');
      flashNews = await homeService.allFlashNews();
      print('✅ Flash news chargées: ${flashNews.length} éléments');
      if (flashNews.isNotEmpty) {
        print('📰 Premier flash: ${flashNews.first.desc}');
      }
      flashNewsModel = flashNews.isNotEmpty ? flashNews.first : null;
    } catch (e) {
      print('❌ Erreur lors du chargement des flash news: $e');
      flashNews = [];
      flashNewsModel = null;
    } finally {
      isLoading = false;
      _safeNotify();
    }
  }

  FlashNewsUserBloc() {
    allFlashNews();
    setCarouselFlashTop();
  }


  Timer? timer;
  bool _disposed = false;

  void _safeNotify() {
    if (!_disposed) notifyListeners();
  }

  setCarouselFlashTop() async {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (flashNews.isEmpty) return;
      // advance circularly based on available items
      indexShow = (indexShow + 1) % flashNews.length;
      _safeNotify();
    });
  }

  int indexShow = 0;

  setIndexShow(int i) {
    if (flashNews.isEmpty) {
      indexShow = 0;
      _safeNotify();
      return;
    }

    if (i < 0) {
      indexShow = flashNews.length - 1;
    } else if (i >= flashNews.length) {
      indexShow = 0;
    } else {
      indexShow = i;
    }

    _safeNotify();
  }

  @override
  void dispose() {
    timer?.cancel();
    _disposed = true;
    super.dispose();
  }
}
