import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class ArticleAvenirSecondaire extends StatelessWidget {
  final ArticlesModel article;
  const ArticleAvenirSecondaire({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          homeUtilisateurBloc.setAticle(article);
          js.context.callMethod(
              'open', ['https://a221.net/article/${article.slug!}', '_self']);
        },
        child: Container(
          width: 280,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff1e3a5f).withOpacity(0.95),
                Color(0xff2c5282).withOpacity(0.97),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color(0xff06b6d4).withOpacity(0.4),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 16,
                color: Color(0xff2c5282).withOpacity(.3),
                offset: Offset(0, 6),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image avec overlay
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    child: Stack(
                      children: [
                        Image.network(
                          BASE_URL_ASSET + article.imageArticle!.url!,
                          height: 160,
                          width: 280,
                          fit: BoxFit.cover,
                        ),
                        // Gradient overlay
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Color(0xff1e3a5f).withOpacity(0.4),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Badge horloge
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff06b6d4),
                            Color(0xff0891b2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff06b6d4).withOpacity(0.5),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Icon(
                        CupertinoIcons.clock_fill,
                        color: blanc,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),

              // Contenu
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Badge catégorie
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: blanc.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: blanc.withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        article.tags!.titre!.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: fontFammilyDii(
                          context,
                          10,
                          blanc,
                          FontWeight.w800,
                          FontStyle.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    
                    // Titre
                    Text(
                      article.titre!,
                      style: fontFammilyDii(
                        context,
                        14,
                        blanc,
                        FontWeight.w700,
                        FontStyle.normal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    
                    // Icône flèche
                    Icon(
                      CupertinoIcons.arrow_right_circle,
                      color: Color(0xff06b6d4),
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
