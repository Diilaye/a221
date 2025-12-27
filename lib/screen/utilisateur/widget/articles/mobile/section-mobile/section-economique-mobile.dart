import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/article-economique-secondaire.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class SectionEconomiqueMobile extends StatelessWidget {
  const SectionEconomiqueMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff0a4d3c), // Vert foncé professionnel
            Color(0xff0d6e58), // Vert émeraude
            Color(0xff108d6f), // Vert moyen
          ],
        ),
      ),
      child: Column(
        children: [
          // Header avec icône et titre
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff10b981),
                            Color(0xff059669),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff10b981).withOpacity(0.4),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Icon(
                        CupertinoIcons.chart_bar_alt_fill,
                        color: blanc,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ÉCONOMIE',
                            style: fontFammilyDii(
                              context,
                              24,
                              blanc,
                              FontWeight.w800,
                              FontStyle.normal,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Finance, Business & Marchés',
                            style: fontFammilyDii(
                              context,
                              14,
                              Color(0xff10b981),
                              FontWeight.w500,
                              FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Article principal en vedette
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  homeUtilisateurBloc.setAticle(homeUtilisateurBloc.uneEconomie!);
                  js.context.callMethod('open', [
                    'https://a221.net/article/${homeUtilisateurBloc.uneEconomie!.slug!}',
                    '_self'
                  ]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: blanc,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: noir.withOpacity(0.25),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image avec overlay et badge
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  BASE_URL_ASSET +
                                      homeUtilisateurBloc.uneEconomie!.imageArticle!.url!,
                                  height: 240,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                // Gradient overlay léger
                                Container(
                                  height: 240,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.3),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Badge "À LA UNE"
                          Positioned(
                            top: 14,
                            right: 14,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff10b981),
                                    Color(0xff059669),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff10b981).withOpacity(0.5),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    CupertinoIcons.star_fill,
                                    color: blanc,
                                    size: 14,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'À LA UNE',
                                    style: fontFammilyDii(
                                      context,
                                      11,
                                      blanc,
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

                      // Contenu
                      Padding(
                        padding: EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Catégorie avec icône
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Color(0xff10b981).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    CupertinoIcons.money_dollar_circle_fill,
                                    color: Color(0xff059669),
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  homeUtilisateurBloc.uneEconomie!.tags!.titre!.toUpperCase(),
                                  style: fontFammilyDii(
                                    context,
                                    13,
                                    Color(0xff059669),
                                    FontWeight.w800,
                                    FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 14),
                            // Titre
                            Text(
                              homeUtilisateurBloc.uneEconomie!.titre!,
                              style: fontFammilyDii(
                                context,
                                19,
                                noir,
                                FontWeight.w800,
                                FontStyle.normal,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 14),
                            // CTA
                            Row(
                              children: [
                                Text(
                                  'Lire l\'analyse',
                                  style: fontFammilyDii(
                                    context,
                                    14,
                                    Color(0xff059669),
                                    FontWeight.w700,
                                    FontStyle.normal,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(
                                  CupertinoIcons.arrow_right_circle_fill,
                                  color: Color(0xff059669),
                                  size: 18,
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
            ),
          ),

          SizedBox(height: 24),

          // Articles secondaires
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: homeUtilisateurBloc.articleEconomies
                  .sublist(0, 5)
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: ArticleEconomiqueSecondaire(
                          article: e,
                          color: Color(0xff059669),
                        ),
                      ))
                  .toList(),
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
