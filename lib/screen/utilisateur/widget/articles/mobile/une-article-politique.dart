import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class UneArticlePolitique extends StatelessWidget {
  final ArticlesModel article;
  const UneArticlePolitique({super.key, required this.article});

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

          // context.go('/article/${article.slug!}');
        },
        child: Container(
          height: 330,
          width: size.width,
          color: blanc,
          child: Center(
            child: Container(
                width: size.width * .95,
                color: blanc,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      child: (article.imageArticle?.url != null && article.imageArticle!.url!.isNotEmpty)
                        ? Image.network(
                            height: 300,
                            width: size.width * .95,
                            BASE_URL_ASSET + article.imageArticle!.url!,
                            fit: BoxFit.contain,
                          )
                        : Image.network(
                            height: 300,
                            width: size.width * .95,
                            'https://cdn.vectorstock.com/i/500p/81/79/no-photo-icon-default-placeholder-vector-41468179.jpg',
                            fit: BoxFit.contain,
                          ),
                    ),
                    Positioned(
                        top: 250,
                        left: size.width * .1,
                        right: size.width * .1,
                        child: Container(
                          height: 70,
                          width: size.width * .8,
                          color: blanc,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              paddingVerticalGlobal(4),
                              Text(
                                article.tags!.titre!,
                                style: fontFammilyDii(context, 15, rouge,
                                    FontWeight.bold, FontStyle.normal),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: SizedBox(
                                    child: Center(
                                      child: Text(
                                        article.titre!,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.fade,
                                        style: fontFammilyDii(context, 10, noir,
                                            FontWeight.w500, FontStyle.normal),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
