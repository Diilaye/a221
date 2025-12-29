import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArticleRevelationCard extends StatefulWidget {
  final ArticlesModel? article;
  final Color accentColor;

  const ArticleRevelationCard({
    super.key,
    this.article,
    required this.accentColor,
  });

  @override
  State<ArticleRevelationCard> createState() => _ArticleRevelationCardState();
}

class _ArticleRevelationCardState extends State<ArticleRevelationCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 12.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    isHovered ? _controller.forward() : _controller.reverse();
  }

  void _navigateToArticle(HomeUtilisateurBloc bloc) {
    if (widget.article?.slug == null) return;
    bloc.setAticle(widget.article!);
    js.context.callMethod(
      'open',
      ['https://a221.net/article/${widget.article!.slug!}', '_self'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _elevationAnimation,
        builder: (context, child) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: widget.accentColor.withOpacity(0.15),
                blurRadius: _elevationAnimation.value,
                offset: Offset(0, _elevationAnimation.value / 3),
              ),
            ],
            border: Border.all(
              color: _isHovered
                  ? widget.accentColor.withOpacity(0.3)
                  : Colors.grey.shade200,
              width: _isHovered ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              GestureDetector(
                onTap: () => _navigateToArticle(homeUtilisateurBloc),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Hero(
                          tag: 'article-revelation-${widget.article?.id ?? ""}',
                          child: Image.network(
                            widget.article?.imageArticle?.url != null &&
                                    widget.article?.imageArticle?.url != ''
                                ? BASE_URL_ASSET +
                                    widget.article!.imageArticle!.url!
                                : 'https://cdn.vectorstock.com/i/500p/81/79/no-photo-icon-default-placeholder-vector-41468179.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade300,
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 40,
                                  color: Colors.grey.shade600,
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.grey.shade200,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: widget.accentColor,
                                    strokeWidth: 2,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        if (_isHovered)
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  widget.accentColor.withOpacity(0.3),
                                ],
                              ),
                            ),
                          ),
                        // Badge exclusif
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: widget.accentColor,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Text(
                              'EXCLUSIF',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Content section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tag
                      if (widget.article?.tags?.titre != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: widget.accentColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            widget.article!.tags!.titre!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: widget.accentColor.withOpacity(0.8),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      const SizedBox(height: 10),
                      // Title
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _navigateToArticle(homeUtilisateurBloc),
                          child: Text(
                            widget.article?.titre ?? '',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Footer with icon
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _getTimeAgo(widget.article?.date),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          AnimatedRotation(
                            turns: _isHovered ? 0.125 : 0,
                            duration: const Duration(milliseconds: 250),
                            child: Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: widget.accentColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTimeAgo(String? dateString) {
    if (dateString == null) return 'Récemment';

    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return 'Il y a ${difference.inDays}j';
      } else if (difference.inHours > 0) {
        return 'Il y a ${difference.inHours}h';
      } else if (difference.inMinutes > 0) {
        return 'Il y a ${difference.inMinutes}min';
      } else {
        return 'À l\'instant';
      }
    } catch (e) {
      return 'Récemment';
    }
  }
}
