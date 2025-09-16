import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
// import 'package:actu/models/utilisateur/categorie-menu-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/htm-to-string-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class ArticleBlocMultiHomeWidget extends StatelessWidget {
  final double card;
  final ArticlesModel? article;
  const ArticleBlocMultiHomeWidget(
      {super.key, this.card = 0, this.article = null});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: 250,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Column(
            children: [
              Expanded(

                child: GestureDetector(
                  onTap: () {
                    homeUtilisateurBloc.setAticle(article!);

                    js.context.callMethod('open', [
                      'https://a221.net/article/${article!.slug!}',
                      '_self'
                    ]);
                  },
                  child: (article?.imageArticle?.url != null && article?.imageArticle?.url != '')
                    ? Image.network(
                        BASE_URL_ASSET + article!.imageArticle!.url!,
                        height: 250,
                        width: 500,
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        'https://cdn.vectorstock.com/i/500p/81/79/no-photo-icon-default-placeholder-vector-41468179.jpg',
                        height: 250,
                        width: 500,
                        fit: BoxFit.fill,
                      ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    paddingVerticalGlobal(4),
                    Row(
                      children: [
                        // paddingHorizontalGlobal(8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              js.context.callMethod('open', [
                                'https://a221.net/tag/${article!.tags!.slug}',
                                '_self'
                              ]);
                            },
                            child: Text(article!.tags!.titre!.toUpperCase(),
                                style: fontFammilyDii(
                                    context,
                                    13,
                                    rouge,
                                    FontWeight.bold,
                                    FontStyle.normal)),
                          ),
                        ),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                    Row(
                      children: [
                        // paddingHorizontalGlobal(8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              homeUtilisateurBloc.setAticle(article!);

                              js.context.callMethod('open', [
                                'https://a221.net/article/${article!.slug!}',
                                '_self'
                              ]);
                            },
                            child: Text(article!.titre!,
                                overflow: TextOverflow.clip,
                                style: fontFammilyDii(
                                    context,
                                    13,
                                    noir,
                                    FontWeight.w400,
                                    FontStyle.normal)),
                          ),
                        ),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                    paddingVerticalGlobal(4),
                  ],
                ),
              ),
              paddingVerticalGlobal(4),
            ],
          ),


        ));
  }
}
