import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class UneArticleAvenir extends StatelessWidget {
  final ArticlesModel article;
  const UneArticleAvenir({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff1e3a5f), // Bleu marine profond
                Color(0xff2c5282), // Bleu marine
                Color(0xff2b6cb0), // Bleu professionnel
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color(0xff2c5282).withOpacity(0.4),
                blurRadius: 24,
                offset: Offset(0, 10),
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
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    child: Stack(
                      children: [
                        Image.network(
                          BASE_URL_ASSET + article.imageArticle!.url!,
                          height: 260,
                          width: size.width,
                          fit: BoxFit.cover,
                        ),
                        // Gradient overlay
                        Container(
                          height: 260,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Color(0xff1e3a5f).withOpacity(0.5),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Badge "À VENIR" avec icône horloge
                  Positioned(
                    top: 14,
                    left: 14,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff06b6d4), // Cyan
                            Color(0xff0891b2), // Cyan foncé
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff06b6d4).withOpacity(0.6),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.clock_fill,
                            color: blanc,
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'À VENIR',
                            style: fontFammilyDii(
                              context,
                              12,
                              blanc,
                              FontWeight.w800,
                              FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Badge catégorie en haut à droite
                  Positioned(
                    top: 14,
                    right: 14,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: blanc.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: noir.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        article.tags!.titre!.toUpperCase(),
                        style: fontFammilyDii(
                          context,
                          11,
                          Color(0xff2c5282),
                          FontWeight.w800,
                          FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Contenu
              Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff1e3a5f),
                      Color(0xff2c5282),
                    ],
                  ),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre
                    Text(
                      article.titre!,
                      style: fontFammilyDii(
                        context,
                        20,
                        blanc,
                        FontWeight.w900,
                        FontStyle.normal,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 14),
                    // Ligne décorative
                    Container(
                      height: 3,
                      width: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff06b6d4),
                            Color(0xff0891b2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(height: 14),
                    // CTA
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.arrow_right_circle_fill,
                          color: Color(0xff06b6d4),
                          size: 22,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Découvrir l\'article',
                          style: fontFammilyDii(
                            context,
                            15,
                            blanc,
                            FontWeight.w700,
                            FontStyle.normal,
                          ),
                        ),
                      ],
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
