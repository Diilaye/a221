import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/models/utilisateur/categorie-menu-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArticleBlocMultiWidget extends StatelessWidget {
  final double card;
  final Articles? article;
  const ArticleBlocMultiWidget({super.key, this.card = 0, this.article = null});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return MouseRegion(
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
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      homeUtilisateurBloc.setAticle(ArticlesModel.fromJson(article!.toJson()));
                      js.context.callMethod('open', [
                        'https://a221.net/article/${article!.slug!}',
                        '_self'
                      ]);
                    },
                    child: Image.network(
                      BASE_URL_ASSET + article!.imageArticle!.url!,
                      height: 200,
                      width: 500,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      paddingVerticalGlobal(4),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: GestureDetector(
                            onTap: () {
                              homeUtilisateurBloc.setAticle(ArticlesModel.fromJson(article!.toJson()));
                              js.context.callMethod('open', [
                                'https://a221.net/article/${article!.slug!}',
                                '_self'
                              ]);
                            },
                            child: Text(article!.titre!,
                                overflow: TextOverflow.fade,
                                style: fontFammilyDii(context, 15, noir,
                                    FontWeight.w500, FontStyle.normal)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                paddingVerticalGlobal(4),
              ],
            ),
          ),
          Positioned(
            top: 180,
            left: 4,
            child: Row(
              children: [
                // paddingHorizontalGlobal(8),
                GestureDetector(
                  onTap: () {
                    context.go('/tag/${article!.tags!.slug!}');
                  },
                  child: Container(
                    color: rouge,
                    height: 30,
                    child: Row(
                      children: [
                        paddingHorizontalGlobal(6),
                        Text(article!.tags!.titre!,
                            style: fontFammilyDii(context, 15, blanc,
                                FontWeight.w700, FontStyle.normal)),
                        paddingHorizontalGlobal(6),
                      ],
                    ),
                  ),
                ),
                paddingHorizontalGlobal(8),
              ],
            ),
          )
        ],
      ),
    );
  }
}
