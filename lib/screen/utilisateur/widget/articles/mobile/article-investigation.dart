import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArticleInvestigationMobile extends StatelessWidget {
  final ArticlesModel article;
  const ArticleInvestigationMobile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return GestureDetector(
      onTap: () {
        homeUtilisateurBloc.setAticle(article);
        js.context.callMethod(
            'open', ['https://a221.net/article/${article.slug!}', '_self']);
      },
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          color: noir,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFFffd93d).withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Image pleine hauteur
              (article.imageArticle?.url != null && article.imageArticle!.url!.isNotEmpty)
                  ? Image.network(
                      BASE_URL_ASSET + article.imageArticle!.url!,
                      height: 420,
                      width: 280,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 420,
                      width: 280,
                      color: Color(0xFF1a1a1a),
                      child: Icon(
                        CupertinoIcons.photo,
                        size: 80,
                        color: blanc.withOpacity(0.2),
                      ),
                    ),
              
              // Overlay gradient noir fort
              Container(
                height: 420,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      noir.withOpacity(0.7),
                      noir.withOpacity(0.95),
                    ],
                    stops: [0.3, 0.7, 1.0],
                  ),
                ),
              ),
              
              // Badge EXCLUSIF en haut
              Positioned(
                top: 14,
                right: 14,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFFffd93d),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'EXCLUSIF',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: noir,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
              
              // Icône loupe en haut à gauche
              Positioned(
                top: 14,
                left: 14,
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: noir.withOpacity(0.7),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFFffd93d).withOpacity(0.6),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    CupertinoIcons.search,
                    color: Color(0xFFffd93d),
                    size: 16,
                  ),
                ),
              ),
              
              // Contenu en bas
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Catégorie avec ligne
                      if (article.tags?.titre != null)
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 1.5,
                              color: Color(0xFFffd93d),
                            ),
                            SizedBox(width: 8),
                            Text(
                              article.tags!.titre!.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFffd93d),
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 10),
                      
                      // Titre
                      Text(
                        article.titre!,
                        style: fontFammilyDii(
                            context, 16, blanc, FontWeight.w800, FontStyle.normal),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      SizedBox(height: 12),
                      
                      // Séparateur
                      Container(
                        height: 1,
                        width: 50,
                        color: Color(0xFFffd93d).withOpacity(0.4),
                        ),
                      
                      SizedBox(height: 10),
                      
                      // "Lire l'enquête"
                      Row(
                        children: [
                          Text(
                            'Lire l\'enquête',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFffd93d),
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            CupertinoIcons.arrow_right,
                            color: Color(0xFFffd93d),
                            size: 13,
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
}
