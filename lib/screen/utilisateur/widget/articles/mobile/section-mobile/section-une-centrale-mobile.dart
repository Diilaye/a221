import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class SectionUneCentraleMobile extends StatelessWidget {
  const SectionUneCentraleMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    bool isDesktop = size.width > 900;

    if (homeUtilisateurBloc.articleUnes.isEmpty || homeUtilisateurBloc.uneArticleMobile == null) {
      return SizedBox();
    }

    return Container(
      width: size.width,
      color: blanc,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 16, vertical: 24),
      child: isDesktop ? _buildDesktopLayout(context, homeUtilisateurBloc, size) : _buildMobileLayout(context, homeUtilisateurBloc, size),
    );
  }

  // Layout Desktop avec article principal à gauche et sidebar à droite
  Widget _buildDesktopLayout(BuildContext context, HomeUtilisateurBloc bloc, Size size) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article principal (70%)
            Expanded(
              flex: 7,
              child: _buildMainArticle(context, bloc, size, isLarge: true),
            ),
            SizedBox(width: 30),
            // Sidebar avec articles secondaires (30%)
            Expanded(
              flex: 3,
              child: _buildSidebar(context, bloc),
            ),
          ],
        ),
        paddingVerticalGlobal(30),
      ],
    );
  }

  // Layout Mobile
  Widget _buildMobileLayout(BuildContext context, HomeUtilisateurBloc bloc, Size size) {
    return Column(
      children: [
        _buildMainArticle(context, bloc, size, isLarge: false),
        paddingVerticalGlobal(20),
        _buildMobileSecondaryArticles(context, bloc),
        paddingVerticalGlobal(20),
      ],
    );
  }

  // Article principal avec image et overlay
  Widget _buildMainArticle(BuildContext context, HomeUtilisateurBloc bloc, Size size, {required bool isLarge}) {
    return GestureDetector(
      onTap: () {
        bloc.setAticle(bloc.uneArticleMobile!);
        js.context.callMethod('open', [
          'https://a221.net/article/${bloc.uneArticleMobile!.slug!}',
          '_self'
        ]);
      },
      child: Container(
        height: isLarge ? 580 : 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: noir.withOpacity(0.15),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Image de fond
              bloc.uneArticleMobile!.imageArticle?.url != null
                  ? Image.network(
                      BASE_URL_ASSET + bloc.uneArticleMobile!.imageArticle!.url!,
                      height: isLarge ? 580 : 450,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    )
                  : Container(
                      height: isLarge ? 580 : 450,
                      color: Colors.grey.shade300,
                      child: Icon(CupertinoIcons.photo, size: 80, color: Colors.grey.shade400),
                    ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      noir.withOpacity(0.4),
                      noir.withOpacity(0.9),
                    ],
                    stops: [0.3, 0.6, 1.0],
                  ),
                ),
              ),

              // Badge Date en bas
              Positioned(
                bottom: 20,
                left: 20,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: blanc.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: noir.withOpacity(0.2),
                        blurRadius: 15,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.clock_fill, color: rouge, size: 18),
                      SizedBox(width: 10),
                      Text(
                        _formatDate(bloc.uneArticleMobile!.date),
                        style: fontFammilyDii(
                          context,
                          isLarge ? 15 : 14,
                          Colors.grey.shade800,
                          FontWeight.w700,
                          FontStyle.normal,
                        ),
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

  // Sidebar avec liste d'articles - Images seulement
  Widget _buildSidebar(BuildContext context, HomeUtilisateurBloc bloc) {
    final otherArticles = bloc.articleUnes
        .where((article) => article.id != bloc.uneArticleMobile!.id)
        .take(4)
        .toList();

    return Column(
      children: otherArticles.asMap().entries.map((entry) {
        final article = entry.value;
        return _buildSidebarArticleItem(context, bloc, article);
      }).toList(),
    );
  }

  // Item d'article dans la sidebar - Design élégant sans titre
  Widget _buildSidebarArticleItem(BuildContext context, HomeUtilisateurBloc bloc, article) {
    return GestureDetector(
      onTap: () {
        bloc.setAticle(article);
        js.context.callMethod('open', ['https://a221.net/article/${article.slug!}', '_self']);
      },
      child: Container(
        height: 200,
        margin: EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: noir.withOpacity(0.15),
              blurRadius: 20,
              offset: Offset(0, 8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image de fond
              article.imageArticle?.url != null
                  ? Image.network(
                      BASE_URL_ASSET + article.imageArticle!.url!,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey.shade300,
                      child: Icon(CupertinoIcons.photo, size: 60, color: Colors.grey.shade400),
                    ),
              
              // Gradient overlay moderne
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      noir.withOpacity(0.2),
                      noir.withOpacity(0.9),
                    ],
                    stops: [0.3, 0.65, 1.0],
                  ),
                ),
              ),

              // Badge Date en bas
              Positioned(
                bottom: 16,
                left: 16,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: blanc.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: noir.withOpacity(0.2),
                        blurRadius: 12,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.clock_fill, color: rouge, size: 14),
                      SizedBox(width: 8),
                      Text(
                        _formatDate(article.date),
                        style: fontFammilyDii(
                          context,
                          13,
                          Colors.grey.shade800,
                          FontWeight.w700,
                          FontStyle.normal,
                        ),
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

  // Articles secondaires - Grid mobile élégant
  Widget _buildMobileSecondaryArticles(BuildContext context, HomeUtilisateurBloc bloc) {
    final otherArticles = bloc.articleUnes
        .where((article) => article.id != bloc.uneArticleMobile!.id)
        .take(4)
        .toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: otherArticles.length,
      itemBuilder: (context, index) => _buildMobileArticleCard(context, bloc, otherArticles[index]),
    );
  }

  Widget _buildMobileArticleCard(BuildContext context, HomeUtilisateurBloc bloc, article) {
    return GestureDetector(
      onTap: () {
        bloc.setAticle(article);
        js.context.callMethod('open', ['https://a221.net/article/${article.slug!}', '_self']);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: noir.withOpacity(0.15),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image
              article.imageArticle?.url != null
                  ? Image.network(
                      BASE_URL_ASSET + article.imageArticle!.url!,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey.shade300,
                      child: Icon(CupertinoIcons.photo, size: 45, color: Colors.grey.shade400),
                    ),
              
              // Gradient moderne
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      noir.withOpacity(0.2),
                      noir.withOpacity(0.7),
                    ],
                    stops: [0.5, 0.8, 1.0],
                  ),
                ),
              ),

              // Badge Date en bas
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: blanc.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: noir.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.clock_fill, color: rouge, size: 11),
                      SizedBox(width: 5),
                      Text(
                        _formatDate(article.date),
                        style: fontFammilyDii(
                          context,
                          10,
                          Colors.grey.shade800,
                          FontWeight.w700,
                          FontStyle.normal,
                        ),
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

  String _formatDate(String? date) {
    if (date == null) return '';
    try {
      final dateTime = DateTime.parse(date);
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      
      if (difference.inHours < 1) {
        return 'Il y a ${difference.inMinutes} min';
      } else if (difference.inHours < 24) {
        return 'Il y a ${difference.inHours}h';
      } else if (difference.inDays < 7) {
        return 'Il y a ${difference.inDays}j';
      } else {
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      }
    } catch (e) {
      return '';
    }
  }

  Color _getCategoryColor(String? category) {
    switch (category?.toLowerCase()) {
      case 'politique':
        return Color(0xFF1e40af);
      case 'économie':
        return Color(0xFF16a34a);
      case 'sport':
        return Color(0xFFdc2626);
      case 'culture':
        return Color(0xFF9333ea);
      case 'investigation':
        return Color(0xFFea580c);
      case 'international':
        return Color(0xFF0891b2);
      default:
        return rouge;
    }
  }

  IconData _getCategoryIcon(String? category) {
    switch (category?.toLowerCase()) {
      case 'politique':
        return CupertinoIcons.building_2_fill;
      case 'économie':
        return CupertinoIcons.money_dollar_circle_fill;
      case 'sport':
        return CupertinoIcons.sportscourt_fill;
      case 'culture':
        return CupertinoIcons.paintbrush_fill;
      case 'investigation':
        return CupertinoIcons.search_circle_fill;
      case 'international':
        return CupertinoIcons.globe;
      default:
        return CupertinoIcons.news_solid;
    }
  }
}
