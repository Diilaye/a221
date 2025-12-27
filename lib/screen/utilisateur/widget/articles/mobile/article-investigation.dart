import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArtilceInvestiogationMobile extends StatelessWidget {
  final ArticlesModel article;
  const ArtilceInvestiogationMobile({super.key, required this.article});

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
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: noir.withOpacity(0.5),
              blurRadius: 25,
              offset: Offset(0, 12),
            ),
          ],
          border: Border.all(
            color: Color(0xFFffd93d).withOpacity(0.4),
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
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
                top: 16,
                right: 16,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFffd93d), Color(0xFFffb830)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFffd93d).withOpacity(0.6),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.star_fill,
                        color: noir,
                        size: 12,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'EXCLUSIF',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: noir,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Icône loupe en haut à gauche
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: noir.withOpacity(0.8),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFFffd93d),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    CupertinoIcons.search,
                    color: Color(0xFFffd93d),
                    size: 18,
                  ),
                ),
              ),
              
              // Contenu en bas
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Catégorie avec ligne
                      if (article.tags?.titre != null)
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 2,
                              color: Color(0xFFffd93d),
                            ),
                            SizedBox(width: 8),
                            Text(
                              article.tags!.titre!.toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFffd93d),
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 12),
                      
                      // Titre
                      Text(
                        article.titre!,
                        style: fontFammilyDii(
                            context, 17, blanc, FontWeight.w900, FontStyle.normal),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      SizedBox(height: 14),
                      
                      // Séparateur
                      Container(
                        height: 1,
                        width: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFffd93d),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 10),
                      
                      // "Lire l'enquête"
                      Row(
                        children: [
                          Text(
                            'Lire l\'enquête',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFffd93d),
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            CupertinoIcons.arrow_right,
                            color: Color(0xFFffd93d),
                            size: 14,
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
