import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/article-actualite-secondaire.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class SectionActualiteMobile extends StatelessWidget {
  const SectionActualiteMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return homeUtilisateurBloc.articleActualites.isNotEmpty ? Container(
      color: bgNoir,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: blanc.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    CupertinoIcons.news_solid,
                    color: blanc,
                    size: 22,
                  ),
                ),
                SizedBox(width: 14),
                Text(
                  'ACTUALITÉ',
                  style: fontFammilyDii(
                      context, 24, blanc, FontWeight.w900, FontStyle.normal),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                homeUtilisateurBloc.setAticle(homeUtilisateurBloc.articleActualites.first);

                js.context.callMethod('open', [
                  'https://a221.net/article/${homeUtilisateurBloc.articleActualites.first.slug!}',
                  '_self'
                ]);
              },
              child: Container(
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: noir.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      // Image
                      Image.network(
                        BASE_URL_ASSET +
                            homeUtilisateurBloc.articleActualites.first.imageArticle!.url!,
                        height: 380,
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                      // Gradient overlay
                      Container(
                        height: 380,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              noir.withOpacity(0.9),
                            ],
                            stops: [0.3, 1.0],
                          ),
                        ),
                      ),
                      // Badge catégorie
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [rouge, rouge.withOpacity(0.85)],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: rouge.withOpacity(0.5),
                                blurRadius: 12,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Text(
                            homeUtilisateurBloc.articleActualites.first.tags!.titre!.toUpperCase(),
                            style: fontFammilyDii(context, 13, blanc,
                                FontWeight.w800, FontStyle.normal),
                          ),
                        ),
                      ),
                      // Titre
                      Positioned(
                        bottom: 20,
                        left: 16,
                        right: 16,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: noir.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            homeUtilisateurBloc.articleActualites.first.titre!,
                            style: fontFammilyDii(
                                context, 22, blanc, FontWeight.w900, FontStyle.normal),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: homeUtilisateurBloc.articleActualites
                  .sublist(1, 5)
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ArticleActualiteSecondaire(
                          article: e,
                        ),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 1,
            color: noir,
          ),
        ],
      ),
    ) : SizedBox();
  }
}
