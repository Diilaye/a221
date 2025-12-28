import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/models/utilisateur/categorie-menu-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArticleBlocMultiWidget extends StatefulWidget {
  final double card;
  final Articles? article;
  const ArticleBlocMultiWidget({super.key, this.card = 0, this.article});

  @override
  State<ArticleBlocMultiWidget> createState() => _ArticleBlocMultiWidgetState();
}

class _ArticleBlocMultiWidgetState extends State<ArticleBlocMultiWidget> {
  bool isHovered = false;

  void _navigateToArticle(BuildContext context) {
    if (widget.article != null) {
      try {
        final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context, listen: false);
        homeUtilisateurBloc.setAticle(ArticlesModel.fromJson(widget.article!.toJson()));
        js.context.callMethod('open', [
          'https://a221.net/article/${widget.article!.slug!}',
          '_self'
        ]);
      } catch (e) {
        print('Erreur lors de la navigation vers l\'article: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.article == null) {
      return const SizedBox.shrink();
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () => _navigateToArticle(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: blanc,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isHovered ? 0.15 : 0.06),
                blurRadius: isHovered ? 30 : 20,
                offset: Offset(0, isHovered ? 8 : 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image avec overlay et tag
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      // Image principale
                      AnimatedScale(
                        scale: isHovered ? 1.05 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                          ),
                          child: (widget.article?.imageArticle?.url != null && 
                                 widget.article?.imageArticle?.url != '')
                              ? Image.network(
                                  BASE_URL_ASSET + widget.article!.imageArticle!.url!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return _buildPlaceholderImage();
                                  },
                                )
                              : _buildPlaceholderImage(),
                        ),
                      ),

                      // Gradient overlay en bas
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Tag positionné
                      if (widget.article!.tags?.titre != null)
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: GestureDetector(
                            onTap: () {
                              if (widget.article!.tags?.slug != null) {
                                context.go('/tag/${widget.article!.tags!.slug!}');
                              }
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: rouge,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: rouge.withOpacity(0.4),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      CupertinoIcons.tag_fill,
                                      color: blanc,
                                      size: 12,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      widget.article!.tags!.titre!.toUpperCase(),
                                      style: TextStyle(
                                        color: blanc,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Contenu texte
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Titre de l'article
                        Expanded(
                          child: Text(
                            widget.article!.titre!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: noir,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Footer avec date et icône
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.time,
                              size: 14,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                _formatDate(widget.article!.date),
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(
                              CupertinoIcons.arrow_right_circle_fill,
                              size: 20,
                              color: isHovered ? rouge : Colors.grey.shade400,
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
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Icon(
          CupertinoIcons.photo,
          size: 48,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'Date non disponible';
    
    try {
      DateTime dateTime;
      if (date is String) {
        dateTime = DateTime.parse(date);
      } else if (date is DateTime) {
        dateTime = date;
      } else {
        return 'Date invalide';
      }

      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays == 0) {
        if (difference.inHours == 0) {
          return 'Il y a ${difference.inMinutes} min';
        }
        return 'Il y a ${difference.inHours}h';
      } else if (difference.inDays == 1) {
        return 'Hier';
      } else if (difference.inDays < 7) {
        return 'Il y a ${difference.inDays} jours';
      } else {
        final months = [
          'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
          'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'
        ];
        return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
      }
    } catch (e) {
      return 'Date invalide';
    }
  }
}
