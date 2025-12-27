import 'dart:convert';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardStatsModel {
  final int totalArticles;
  final int totalVisites;
  final int totalJournalPapier;
  final int totalPostsDigitaux;
  final int totalEmissions;
  final int totalFlashNews;
  final int articlesToday;
  final int visitesToday;
  final double articleGrowth;
  final double visiteGrowth;
  final double journalGrowth;
  final double postGrowth;
  final List<MonthlyData> monthlyArticles;
  final List<CategoryData> topCategories;
  final List<ActivityData> recentActivity;

  DashboardStatsModel({
    required this.totalArticles,
    required this.totalVisites,
    required this.totalJournalPapier,
    required this.totalPostsDigitaux,
    required this.totalEmissions,
    required this.totalFlashNews,
    required this.articlesToday,
    required this.visitesToday,
    required this.articleGrowth,
    required this.visiteGrowth,
    required this.journalGrowth,
    required this.postGrowth,
    required this.monthlyArticles,
    required this.topCategories,
    required this.recentActivity,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      totalArticles: json['totalArticles'] ?? 0,
      totalVisites: json['totalVisites'] ?? 0,
      totalJournalPapier: json['totalJournalPapier'] ?? 0,
      totalPostsDigitaux: json['totalPostsDigitaux'] ?? 0,
      totalEmissions: json['totalEmissions'] ?? 0,
      totalFlashNews: json['totalFlashNews'] ?? 0,
      articlesToday: json['articlesToday'] ?? 0,
      visitesToday: json['visitesToday'] ?? 0,
      articleGrowth: (json['articleGrowth'] ?? 0).toDouble(),
      visiteGrowth: (json['visiteGrowth'] ?? 0).toDouble(),
      journalGrowth: (json['journalGrowth'] ?? 0).toDouble(),
      postGrowth: (json['postGrowth'] ?? 0).toDouble(),
      monthlyArticles: (json['monthlyArticles'] as List?)
              ?.map((e) => MonthlyData.fromJson(e))
              .toList() ??
          [],
      topCategories: (json['topCategories'] as List?)
              ?.map((e) => CategoryData.fromJson(e))
              .toList() ??
          [],
      recentActivity: (json['recentActivity'] as List?)
              ?.map((e) => ActivityData.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class MonthlyData {
  final String month;
  final int count;

  MonthlyData({required this.month, required this.count});

  factory MonthlyData.fromJson(Map<String, dynamic> json) {
    return MonthlyData(
      month: json['month'] ?? '',
      count: json['count'] ?? 0,
    );
  }
}

class CategoryData {
  final String name;
  final int count;
  final double percentage;

  CategoryData({
    required this.name,
    required this.count,
    required this.percentage,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      name: json['name'] ?? '',
      count: json['count'] ?? 0,
      percentage: (json['percentage'] ?? 0).toDouble(),
    );
  }
}

class ActivityData {
  final String type;
  final String title;
  final String time;
  final String author;

  ActivityData({
    required this.type,
    required this.title,
    required this.time,
    required this.author,
  });

  factory ActivityData.fromJson(Map<String, dynamic> json) {
    return ActivityData(
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      time: json['time'] ?? '',
      author: json['author'] ?? '',
    );
  }
}

class DashboardStatsBloc with ChangeNotifier {
  DashboardStatsModel? _stats;
  bool _isLoading = false;
  String? _error;

  DashboardStatsModel? get stats => _stats;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Charger les statistiques du dashboard
  Future<void> loadDashboardStats() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('${BASE_URL}admin/dashboard-stats'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _stats = DashboardStatsModel.fromJson(data);
        _error = null;
      } else {
        _error = 'Erreur lors du chargement des statistiques';
        // Données de fallback pour démonstration
        _loadMockData();
      }
    } catch (e) {
      _error = 'Erreur de connexion: $e';
      // Données de fallback pour démonstration
      _loadMockData();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Données mockées pour démonstration
  void _loadMockData() {
    _stats = DashboardStatsModel(
      totalArticles: 2847,
      totalVisites: 145678,
      totalJournalPapier: 342,
      totalPostsDigitaux: 1245,
      totalEmissions: 156,
      totalFlashNews: 89,
      articlesToday: 23,
      visitesToday: 4567,
      articleGrowth: 12.5,
      visiteGrowth: 8.3,
      journalGrowth: -5.2,
      postGrowth: 15.7,
      monthlyArticles: [
        MonthlyData(month: 'Jan', count: 180),
        MonthlyData(month: 'Fév', count: 220),
        MonthlyData(month: 'Mar', count: 250),
        MonthlyData(month: 'Avr', count: 240),
        MonthlyData(month: 'Mai', count: 280),
        MonthlyData(month: 'Juin', count: 260),
        MonthlyData(month: 'Juil', count: 290),
        MonthlyData(month: 'Août', count: 270),
        MonthlyData(month: 'Sep', count: 300),
        MonthlyData(month: 'Oct', count: 320),
        MonthlyData(month: 'Nov', count: 310),
        MonthlyData(month: 'Déc', count: 287),
      ],
      topCategories: [
        CategoryData(name: 'Politique', count: 567, percentage: 35.2),
        CategoryData(name: 'Économie', count: 432, percentage: 26.8),
        CategoryData(name: 'Sport', count: 289, percentage: 18.0),
        CategoryData(name: 'Culture', count: 203, percentage: 12.6),
        CategoryData(name: 'International', count: 120, percentage: 7.4),
      ],
      recentActivity: [
        ActivityData(
          type: 'article',
          title: 'Nouvelle loi sur l\'économie numérique',
          time: 'Il y a 5 min',
          author: 'Jean Dupont',
        ),
        ActivityData(
          type: 'emission',
          title: 'Débat politique du soir',
          time: 'Il y a 15 min',
          author: 'Marie Martin',
        ),
        ActivityData(
          type: 'flash',
          title: 'Breaking: Événement majeur en cours',
          time: 'Il y a 30 min',
          author: 'Pierre Dubois',
        ),
      ],
    );
  }

  // Rafraîchir les statistiques
  Future<void> refresh() async {
    await loadDashboardStats();
  }
}
