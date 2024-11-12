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
    return Expanded(
        flex: 4,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Stack(
            children: [
              Card(
                elevation: card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: size.width >= 1440
                          ? 2
                          : size.width >= 1024 && size.width < 1440
                              ? 1
                              : 1,
                      child: GestureDetector(
                        onTap: () {
                          homeUtilisateurBloc.setAticle(article!);

                          js.context.callMethod('open', [
                            'https://a221.net/article/${article!.slug!}',
                            '_self'
                          ]);
                        },
                        child: Image.network(
                          BASE_URL_ASSET + article!.imageArticle!.url!,
                          height: 200,
                          width: 500,
                          fit: BoxFit.cover,
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
                                          size.width >= 1440
                                              ? 12
                                              : size.width >= 1024 &&
                                                      size.width < 1440
                                                  ? 10
                                                  : 8,
                                          noir,
                                          FontWeight.w400,
                                          FontStyle.normal)),
                                ),
                              ),
                              paddingHorizontalGlobal(8),
                            ],
                          ),
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
                                  child: Text(article!.tags!.titre!,
                                      style: fontFammilyDii(
                                          context,
                                          size.width >= 1440
                                              ? 16
                                              : size.width >= 1024 &&
                                                      size.width < 1440
                                                  ? 14
                                                  : 12,
                                          noir,
                                          FontWeight.bold,
                                          FontStyle.normal)),
                                ),
                              ),
                              paddingHorizontalGlobal(8),
                            ],
                          ),
                        ],
                      ),
                    ),
                    paddingVerticalGlobal(4),
                  ],
                ),
              ),
              Positioned(
                top: size.width >= 1440
                    ? 194
                    : size.width >= 1024 && size.width < 1440
                        ? 145
                        : 14,
                left: 4,
                child: Row(
                  children: [
                    // paddingHorizontalGlobal(8),
                    Container(
                      color: rouge,
                      height: size.width >= 1440
                          ? 30
                          : size.width >= 1024 && size.width < 1440
                              ? 25
                              : 20,
                      child: Row(
                        children: [
                          paddingHorizontalGlobal(
                            size.width >= 1440
                                ? 6
                                : size.width >= 1024 && size.width < 1440
                                    ? 4
                                    : 2,
                          ),
                          Text(article!.categorie!.titre!,
                              style: fontFammilyDii(
                                  context,
                                  size.width >= 1440
                                      ? 14
                                      : size.width >= 1024 && size.width < 1440
                                          ? 10
                                          : 8,
                                  blanc,
                                  FontWeight.bold,
                                  FontStyle.normal)),
                          paddingHorizontalGlobal(
                            size.width >= 1440
                                ? 6
                                : size.width >= 1024 && size.width < 1440
                                    ? 4
                                    : 2,
                          ),
                        ],
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
