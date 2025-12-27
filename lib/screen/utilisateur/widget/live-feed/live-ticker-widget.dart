import 'dart:async';
import 'package:actu/bloc/live-feed-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

/// Widget de bandeau d'actualités en direct (style chaîne TV)
class LiveTickerWidget extends StatefulWidget {
  final double height;
  final bool showTime;
  
  const LiveTickerWidget({
    Key? key,
    this.height = 50,
    this.showTime = true,
  }) : super(key: key);

  @override
  State<LiveTickerWidget> createState() => _LiveTickerWidgetState();
}

class _LiveTickerWidgetState extends State<LiveTickerWidget> {
  final ScrollController _scrollController = ScrollController();
  Timer? _scrollTimer;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!_isPaused && _scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;
        
        if (currentScroll >= maxScroll) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(
            currentScroll + 1,
            duration: const Duration(milliseconds: 50),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final liveFeedBloc = Provider.of<LiveFeedBloc>(context);

    if (liveFeedBloc.liveFeeds.isEmpty) {
      return const SizedBox.shrink();
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isPaused = true),
      onExit: (_) => setState(() => _isPaused = false),
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: noir,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Badge "EN DIRECT"
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: rouge,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'EN DIRECT',
                    style: TextStyle(
                      color: rouge,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            // Bandeau déroulant
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i = 0; i < liveFeedBloc.liveFeeds.length; i++) ...[
                      _buildTickerItem(liveFeedBloc.liveFeeds[i]),
                      Container(
                        width: 1,
                        height: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ],
                    // Dupliquer pour un défilement infini fluide
                    for (var i = 0; i < liveFeedBloc.liveFeeds.length; i++) ...[
                      _buildTickerItem(liveFeedBloc.liveFeeds[i]),
                      Container(
                        width: 1,
                        height: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Heure (optionnel)
            if (widget.showTime)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    final now = DateTime.now();
                    final formatter = DateFormat('HH:mm:ss');
                    return Text(
                      formatter.format(now),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTickerItem(liveFeed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Badge type
          if (liveFeed.type == 'breaking' || liveFeed.type == 'urgent')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                liveFeed.type == 'breaking' ? 'BREAKING' : 'URGENT',
                style: TextStyle(
                  color: rouge,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          
          if (liveFeed.type == 'breaking' || liveFeed.type == 'urgent')
            const SizedBox(width: 10),

          // Titre
          Text(
            liveFeed.titre ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(width: 8),

          // Heure
          if (liveFeed.date != null)
            Text(
              _formatTimeAgo(liveFeed.date!),
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  String _formatTimeAgo(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inMinutes < 1) {
        return 'À l\'instant';
      } else if (difference.inMinutes < 60) {
        return 'Il y a ${difference.inMinutes}min';
      } else if (difference.inHours < 24) {
        return 'Il y a ${difference.inHours}h';
      } else {
        final formatter = DateFormat('HH:mm');
        return formatter.format(date);
      }
    } catch (e) {
      return '';
    }
  
  }
}
