import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;

class SectionCategoryMobile extends StatelessWidget {
  final List<ArticlesModel> articles;
  final String title;
  final IconData icon;
  final Color primaryColor;

  const SectionCategoryMobile({
    super.key,
    required this.articles,
    required this.title,
    required this.icon,
    this.primaryColor = const Color(0xFFE31E24),
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (articles.isEmpty) return SizedBox();

    return Container(
      width: size.width,
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          // Header moderne
          Container(
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withOpacity(0.1),
                  primaryColor.withOpacity(0.05),
                ],
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: primaryColor,
                    size: 22,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  title.toUpperCase(),
                  style: fontFammilyDii(
                    context,
                    22,
                    noir,
                    FontWeight.w900,
                    FontStyle.normal,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: blanc,
                  ),
                ),
              ],
            ),
          ),

          paddingVerticalGlobal(8),

          // Article principal avec image
          GestureDetector(
            onTap: () {
              js.context.callMethod('open', [
                'https://a221.net/article/${articles[0].slug!}',
                '_self'
              ]);
            },
            child: Container(
              width: size.width * 0.94,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: noir.withOpacity(0.1),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Image principale
                    articles[0].imageArticle?.url != null
                        ? Image.network(
                            BASE_URL_ASSET + articles[0].imageArticle!.url!,
                            height: 280,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 280,
                            color: Colors.grey.shade300,
                            child: Icon(
                              CupertinoIcons.photo,
                              size: 60,
                              color: Colors.grey.shade400,
                            ),
                          ),

                    // Gradient overlay
                    Container(
                      height: 280,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            noir.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),

                    // Badge catégorie
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.4),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.tag_fill,
                              color: blanc,
                              size: 14,
                            ),
                            SizedBox(width: 6),
                            Text(
                              articles[0].tags?.titre?.toUpperCase() ?? title.toUpperCase(),
                              style: fontFammilyDii(
                                context,
                                12,
                                blanc,
                                FontWeight.w700,
                                FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Titre en bas
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              articles[0].titre ?? '',
                              style: fontFammilyDii(
                                context,
                                18,
                                blanc,
                                FontWeight.w700,
                                FontStyle.normal,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.arrow_right_circle_fill,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Lire l\'article',
                                  style: fontFammilyDii(
                                    context,
                                    14,
                                    blanc,
                                    FontWeight.w600,
                                    FontStyle.normal,
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
          ),

          paddingVerticalGlobal(12),

          // Liste des articles secondaires
          ...List.generate(
            articles.length > 4 ? 3 : articles.length - 1,
            (index) {
              final article = articles[index + 1];
              
              return GestureDetector(
                onTap: () {
                  js.context.callMethod('open', [
                    'https://a221.net/article/${article.slug!}',
                    '_self'
                  ]);
                },
                child: Container(
                  width: size.width * 0.94,
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03,
                    vertical: 6,
                  ),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: blanc,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: noir.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Numéro stylisé
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryColor, primaryColor.withOpacity(0.8)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: fontFammilyDii(
                              context,
                              16,
                              blanc,
                              FontWeight.w900,
                              FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      
                      // Contenu
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (article.tags?.titre != null)
                              Text(
                                article.tags!.titre!.toUpperCase(),
                                style: fontFammilyDii(
                                  context,
                                  11,
                                  primaryColor,
                                  FontWeight.w700,
                                  FontStyle.normal,
                                ),
                              ),
                            SizedBox(height: 4),
                            Text(
                              article.titre ?? '',
                              style: fontFammilyDii(
                                context,
                                15,
                                Colors.grey.shade800,
                                FontWeight.w600,
                                FontStyle.normal,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      
                      // Icône
                      Icon(
                        CupertinoIcons.chevron_right,
                        color: primaryColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          paddingVerticalGlobal(8),

          // Séparateur
          Container(
            width: size.width * 0.94,
            height: 1,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
