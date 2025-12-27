import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class ArticleActualiteSecondaire extends StatelessWidget {
  final ArticlesModel article;
  const ArticleActualiteSecondaire({
    super.key,
    required this.article,
  });

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
          height: 140,
          decoration: BoxDecoration(
            color: Color(0xff1a1a2e),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: blanc.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: noir.withOpacity(.3),
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Row(
            children: [
              // Image à gauche
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      BASE_URL_ASSET + article.imageArticle!.url!,
                      width: 130,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                    // Overlay gradient
                    Container(
                      width: 130,
                      height: 140,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Color(0xff1a1a2e).withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Contenu à droite
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Badge catégorie
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: rouge.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: rouge.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              article.tags!.titre!.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: fontFammilyDii(
                                context,
                                10,
                                rouge,
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
                              15,
                              blanc,
                              FontWeight.w700,
                              FontStyle.normal,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      
                      // Icône lire plus en bas
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.arrow_right_circle,
                            color: rouge.withOpacity(0.8),
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Lire',
                            style: fontFammilyDii(
                              context,
                              12,
                              rouge.withOpacity(0.8),
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
    );
  }
}
