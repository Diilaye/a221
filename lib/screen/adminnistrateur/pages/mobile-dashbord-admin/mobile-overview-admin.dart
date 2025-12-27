import 'dart:async';
import 'package:actu/bloc/administrateur/dashboard-stats-bloc.dart';
import 'package:actu/screen/administrateur/animated-chart.dart';
import 'package:actu/screen/administrateur/real-time-activity-feed.dart';
import 'package:actu/screen/administrateur/real-time-stat-card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileOverViewAdmin extends StatefulWidget {
  const MobileOverViewAdmin({super.key});

  @override
  State<MobileOverViewAdmin> createState() => _MobileOverViewAdminState();
}

class _MobileOverViewAdminState extends State<MobileOverViewAdmin> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardStatsBloc>().loadDashboardStats();
    });

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
            Color(0xff0f172a),
            Color(0xff1e293b),
            Color(0xff334155),
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
                    'Chargement...',
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
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Erreur de chargement',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 8),
                // Header Mobile
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF06b6d4).withOpacity(0.3),
                            const Color(0xFFef4444).withOpacity(0.3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF06b6d4).withOpacity(0.5),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        CupertinoIcons.chart_bar_alt_fill,
                        color: Color(0xFF06b6d4),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Dashboard A221',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF10b981),
                                  Color(0xFF059669),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  CupertinoIcons.dot_radiowaves_left_right,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'EN DIRECT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
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
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () => statsBloc.refresh(),
                        icon: const Icon(
                          CupertinoIcons.refresh,
                          color: Colors.white,
                          size: 20,
                        ),
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Stats Cards Mobile (vertical)
                RealTimeStatCard(
                  title: 'Visites Totales',
                  value: stats.totalVisites,
                  growth: stats.visiteGrowth,
                  icon: CupertinoIcons.eye_fill,
                  primaryColor: const Color(0xFF06b6d4),
                  accentColor: const Color(0xFF3b82f6),
                ),
                const SizedBox(height: 16),
                
                RealTimeStatCard(
                  title: 'Articles Publiés',
                  value: stats.totalArticles,
                  growth: stats.articleGrowth,
                  icon: CupertinoIcons.doc_text_fill,
                  primaryColor: const Color(0xFFef4444),
                  accentColor: const Color(0xFFf59e0b),
                ),
                const SizedBox(height: 16),
                
                RealTimeStatCard(
                  title: 'Journal Papier',
                  value: stats.totalJournalPapier,
                  growth: stats.journalGrowth,
                  icon: CupertinoIcons.news_solid,
                  primaryColor: const Color(0xFF8b5cf6),
                  accentColor: const Color(0xFFa78bfa),
                ),
                const SizedBox(height: 16),
                
                RealTimeStatCard(
                  title: 'Posts Digitaux',
                  value: stats.totalPostsDigitaux,
                  growth: stats.postGrowth,
                  icon: CupertinoIcons.chart_bar_square_fill,
                  primaryColor: const Color(0xFF10b981),
                  accentColor: const Color(0xFF34d399),
                ),
                const SizedBox(height: 24),
                
                // Graphique Mobile
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFef4444),
                                Color(0xFFf59e0b),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            CupertinoIcons.chart_bar_fill,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Publications',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '12 derniers mois',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AnimatedChart(
                      data: stats.monthlyArticles
                          .map((e) => e.count.toDouble())
                          .toList(),
                      labels: stats.monthlyArticles
                          .map((e) => e.month)
                          .toList(),
                      primaryColor: const Color(0xFF06b6d4),
                      accentColor: const Color(0xFFef4444),
                      height: 220,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Activité Mobile
                RealTimeActivityFeed(
                  activities: stats.recentActivity,
                ),
                const SizedBox(height: 24),
                
                // Top Catégories Mobile
                Container(
                  padding: const EdgeInsets.all(20),
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
                    borderRadius: BorderRadius.circular(16),
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
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF8b5cf6),
                                  Color(0xFFa78bfa),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              CupertinoIcons.square_grid_2x2_fill,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Top Catégories',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Répartition',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ...stats.topCategories.map((category) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    category.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${category.count}',
                                        style: const TextStyle(
                                          color: Color(0xFF8b5cf6),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '${category.percentage.toStringAsFixed(1)}%',
                                        style: const TextStyle(
                                          color: Colors.white60,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: category.percentage / 100,
                                      child: Container(
                                        height: 6,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF8b5cf6),
                                              Color(0xFFa78bfa),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF8b5cf6)
                                                  .withOpacity(0.5),
                                              blurRadius: 6,
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
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}
