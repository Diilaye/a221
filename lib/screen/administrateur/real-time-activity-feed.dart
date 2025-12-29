import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:actu/bloc/administrateur/dashboard-stats-bloc.dart';

class RealTimeActivityFeed extends StatefulWidget {
  final List<ActivityData> activities;

  const RealTimeActivityFeed({
    Key? key,
    required this.activities,
  }) : super(key: key);

  @override
  State<RealTimeActivityFeed> createState() => _RealTimeActivityFeedState();
}

class _RealTimeActivityFeedState extends State<RealTimeActivityFeed>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          color: const Color(0xFF06b6d4).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF06b6d4).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête
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
                    width: 1,
                  ),
                ),
                child: const Icon(
                  CupertinoIcons.bolt_fill,
                  color: Color(0xFF06b6d4),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Activité en temps réel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              _buildLivePulse(),
            ],
          ),
          const SizedBox(height: 24),
          // Liste d'activités
          ...List.generate(
            widget.activities.length,
            (index) => _buildActivityItem(
              widget.activities[index],
              index,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(ActivityData activity, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getActivityColor(activity.type).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Icône du type d'activité
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getActivityColor(activity.type).withOpacity(0.3),
                          _getActivityColor(activity.type).withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _getActivityColor(activity.type).withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      _getActivityIcon(activity.type),
                      color: _getActivityColor(activity.type),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Contenu
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                activity.author,
                                style: TextStyle(
                                  color: _getActivityColor(activity.type),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Colors.white30,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                activity.time,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Badge du type
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getActivityColor(activity.type).withOpacity(0.3),
                          _getActivityColor(activity.type).withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _getActivityColor(activity.type).withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _getActivityLabel(activity.type),
                      style: TextStyle(
                        color: _getActivityColor(activity.type),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLivePulse() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1500),
      tween: Tween(begin: 0.0, end: 1.0),
      onEnd: () {
        setState(() {});
      },
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF10b981).withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF10b981).withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFF10b981),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10b981).withOpacity(value),
                      blurRadius: 10 * value,
                      spreadRadius: 4 * value,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'LIVE',
                style: TextStyle(
                  color: Color(0xFF10b981),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case 'article':
        return const Color(0xFF06b6d4);
      case 'emission':
        return const Color(0xFFef4444);
      case 'flash':
        return const Color(0xFFfbbf24);
      case 'journal':
        return const Color(0xFF8b5cf6);
      default:
        return const Color(0xFF10b981);
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'article':
        return CupertinoIcons.doc_text_fill;
      case 'emission':
        return CupertinoIcons.tv_fill;
      case 'flash':
        return CupertinoIcons.bolt_fill;
      case 'journal':
        return CupertinoIcons.news_solid;
      default:
        return CupertinoIcons.circle_fill;
    }
  }

  String _getActivityLabel(String type) {
    switch (type) {
      case 'article':
        return 'ARTICLE';
      case 'emission':
        return 'ÉMISSION';
      case 'flash':
        return 'FLASH';
      case 'journal':
        return 'JOURNAL';
      default:
        return 'AUTRE';
    }
  }
}
