import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class UneCentraleSecondaireModern extends StatelessWidget {
  final ArticlesModel article;

  const UneCentraleSecondaireModern({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return GestureDetector(
      onTap: () {
        homeUtilisateurBloc.setAticle(article);
        js.context.callMethod('open', [
          'https://a221.net/article/${article.slug!}',
          '_self'
        ]);
      },
      child: Container(
        width: 240,
        margin: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: blanc,
          boxShadow: [
            BoxShadow(
              color: noir.withOpacity(0.08),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Stack(
                children: [
                  article.imageArticle?.url != null
                      ? Image.network(
                          BASE_URL_ASSET + article.imageArticle!.url!,
                          height: 140,
                          width: 240,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 140,
                          width: 240,
                          color: Colors.grey.shade300,
                          child: Icon(
                            CupertinoIcons.photo,
                            size: 40,
                            color: Colors.grey.shade400,
                          ),
                        ),
                  
                  // Gradient overlay léger
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          noir.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),

                  // Badge catégorie
                  if (article.tags?.titre != null)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: rouge,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: noir.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Text(
                          article.tags!.titre!.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: blanc,
                            letterSpacing: 0.5,
                          ),
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
                  children: [
                    Text(
                      article.titre ?? '',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: noir,
                        height: 1.35,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.arrow_right_circle_fill,
                          color: rouge,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Lire plus',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: rouge,
                            letterSpacing: 0.2,
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
