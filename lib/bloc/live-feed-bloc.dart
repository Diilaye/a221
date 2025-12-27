import 'dart:async';
import 'package:actu/models/live-feed-model.dart';
import 'package:actu/services/live-feed-service.dart';
import 'package:flutter/material.dart';

class LiveFeedBloc extends ChangeNotifier {
  final LiveFeedService _liveFeedService = LiveFeedService();
  
  List<LiveFeedModel> liveFeeds = [];
  List<LiveFeedModel> breakingNews = [];
  bool isLoading = false;
  Timer? _autoRefreshTimer;

  LiveFeedBloc() {
    loadLatestFeeds();
    loadBreakingNews();
    startAutoRefresh();
  }

  // Charger les dernières actualités
  Future<void> loadLatestFeeds({int limit = 20}) async {
    isLoading = true;
    notifyListeners();

    try {
      liveFeeds = await _liveFeedService.latest(limit: limit);
    } catch (e) {
      print('Erreur lors du chargement des actualités live: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  // Charger les actualités urgentes
  Future<void> loadBreakingNews() async {
    try {
      breakingNews = await _liveFeedService.breaking();
      notifyListeners();
    } catch (e) {
      print('Erreur lors du chargement des actualités urgentes: $e');
    }
  }

  // Actualisation automatique toutes les 30 secondes
  void startAutoRefresh() {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      loadLatestFeeds();
      loadBreakingNews();
    });
  }

  void stopAutoRefresh() {
    _autoRefreshTimer?.cancel();
  }

  @override
  void dispose() {
    _autoRefreshTimer?.cancel();
    super.dispose();
  }

  // Méthodes pour l'administration
  Future<String?> addLiveFeed(Map<String, dynamic> body) async {
    final result = await _liveFeedService.add(body);
    if (result != null) {
      await loadLatestFeeds();
    }
    return result;
  }

  Future<String?> updateLiveFeed(Map<String, dynamic> body, String id) async {
    final result = await _liveFeedService.update(body, id);
    if (result != null) {
      await loadLatestFeeds();
    }
    return result;
  }

  Future<String?> deleteLiveFeed(String id) async {
    final result = await _liveFeedService.delete(id);
    if (result != null) {
      await loadLatestFeeds();
    }
    return result;
  }
}
