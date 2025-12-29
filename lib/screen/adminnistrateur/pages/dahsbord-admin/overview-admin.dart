import 'dart:async';
import 'package:actu/bloc/administrateur/dashboard-stats-bloc.dart';
import 'package:actu/screen/administrateur/animated-chart.dart';
import 'package:actu/screen/administrateur/real-time-activity-feed.dart';
import 'package:actu/screen/administrateur/real-time-stat-card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverViewAdmin extends StatefulWidget {
  const OverViewAdmin({super.key});

  @override
  State<OverViewAdmin> createState() => _OverViewAdminState();
}

class _OverViewAdminState extends State<OverViewAdmin> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    // Charger les stats au démarrage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardStatsBloc>().loadDashboardStats();
    });

    // Auto-refresh toutes les 30 secondes
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        context.read<DashboardStatsBloc>().refresh();
      }
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff0f172a), // Bleu nuit foncé
            Color(0xff1e293b), // Bleu nuit moyen
            Color(0xff334155), // Bleu gris
          ],
        ),
      ),
      child: Consumer<DashboardStatsBloc>(
        builder: (context, statsBloc, child) {
          if (statsBloc.isLoading && statsBloc.stats == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color(0xFF06b6d4),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Chargement des statistiques...',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          final stats = statsBloc.stats;
          if (stats == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.exclamationmark_triangle,
                    color: const Color(0xFFef4444),
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Erreur de chargement',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    statsBloc.error ?? 'Erreur inconnue',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => statsBloc.refresh(),
                    icon: const Icon(CupertinoIcons.refresh),
                    label: const Text('Réessayer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF06b6d4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => statsBloc.refresh(),
            color: const Color(0xFF06b6d4),
            backgroundColor: const Color(0xFF1a1a2e),
            child: ListView(
              children: [
                const SizedBox(height: 24),
                // Header futuriste
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF06b6d4).withOpacity(0.3),
                              const Color(0xFFef4444).withOpacity(0.3),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF06b6d4).withOpacity(0.5),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF06b6d4).withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          CupertinoIcons.chart_bar_alt_fill,
                          color: Color(0xFF06b6d4),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Dashboard A221',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF10b981),
                                    Color(0xFF059669),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    CupertinoIcons.dot_radiowaves_left_right,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'EN DIRECT',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Bouton rafraîchir
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: IconButton(
                          onPressed: () => statsBloc.refresh(),
                          icon: Icon(
                            CupertinoIcons.refresh,
                            color: Colors.white,
                            size: 24,
                          ),
                          tooltip: 'Actualiser',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                // Statistiques principales avec RealTimeStatCard
                SizedBox(
                  height: 220,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      SizedBox(
                        width: 320,
                        child: RealTimeStatCard(
                          title: 'Visites Totales',
                          value: stats.totalVisites,
                          growth: stats.visiteGrowth,
                          icon: CupertinoIcons.eye_fill,
                          primaryColor: const Color(0xFF06b6d4),
                          accentColor: const Color(0xFF3b82f6),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 320,
                        child: RealTimeStatCard(
                          title: 'Articles Publiés',
                          value: stats.totalArticles,
                          growth: stats.articleGrowth,
                          icon: CupertinoIcons.doc_text_fill,
                          primaryColor: const Color(0xFFef4444),
                          accentColor: const Color(0xFFf59e0b),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 320,
                        child: RealTimeStatCard(
                          title: 'Journal Papier',
                          value: stats.totalJournalPapier,
                          growth: stats.journalGrowth,
                          icon: CupertinoIcons.news_solid,
                          primaryColor: const Color(0xFF8b5cf6),
                          accentColor: const Color(0xFFa78bfa),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 320,
                        child: RealTimeStatCard(
                          title: 'Posts Digitaux',
                          value: stats.totalPostsDigitaux,
                          growth: stats.postGrowth,
                          icon: CupertinoIcons.chart_bar_square_fill,
                          primaryColor: const Color(0xFF10b981),
                          accentColor: const Color(0xFF34d399),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                // Graphique d'activité mensuelle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFef4444),
                                  Color(0xFFf59e0b),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              CupertinoIcons.chart_bar_fill,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Publications Mensuelles',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Évolution sur 12 mois',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      AnimatedChart(
                        data: stats.monthlyArticles
                            .map((e) => e.count.toDouble())
                            .toList(),
                        labels: stats.monthlyArticles
                            .map((e) => e.month)
                            .toList(),
                        primaryColor: const Color(0xFF06b6d4),
                        accentColor: const Color(0xFFef4444),
                        height: 280,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                // Activité en temps réel
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RealTimeActivityFeed(
                    activities: stats.recentActivity,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Catégories principales
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF1a1a2e),
                          Color(0xFF16213e),
                          Color(0xFF0f3460),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF8b5cf6).withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8b5cf6).withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF8b5cf6),
                                    Color(0xFFa78bfa),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                CupertinoIcons.square_grid_2x2_fill,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Top Catégories',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Répartition par contenu',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        ...stats.topCategories.map((category) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      category.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${category.count}',
                                          style: const TextStyle(
                                            color: Color(0xFF8b5cf6),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${category.percentage.toStringAsFixed(1)}%',
                                          style: const TextStyle(
                                            color: Colors.white60,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      FractionallySizedBox(
                                        widthFactor: category.percentage / 100,
                                        child: Container(
                                          height: 8,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF8b5cf6),
                                                Color(0xFFa78bfa),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF8b5cf6)
                                                    .withOpacity(0.5),
                                                blurRadius: 8,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
