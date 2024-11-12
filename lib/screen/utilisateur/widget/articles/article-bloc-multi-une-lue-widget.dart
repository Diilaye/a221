import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/htm-to-string-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArticleBlocMultiUneLueWidget extends StatelessWidget {
  final double card;
  final Color color;
  final ArticlesModel? article;
  const ArticleBlocMultiUneLueWidget(
      {super.key,
      this.card = 0,
      this.color = Colors.black,
      this.article = null});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Expanded(
        flex: 4,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Card(
            elevation: card,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
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
                        fit: BoxFit.cover,
                        height: 300,
                        width: 300,
                      ),
                    )),
                Expanded(
                  child: Column(
                    children: [
                      paddingVerticalGlobal(4),
                      Row(
                        children: [
                          paddingHorizontalGlobal(8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.go('/tag/${article!.tags!.slug!}');
                              },
                              child: Text(article!.tags!.titre!,
                                  style: fontFammilyDii(
                                      context,
                                      size.width >= 1440 ? 14 : 10,
                                      color,
                                      FontWeight.bold,
                                      FontStyle.normal)),
                            ),
                          ),
                          paddingHorizontalGlobal(8),
                        ],
                      ),
                      paddingVerticalGlobal(4),
                      Row(
                        children: [
                          paddingHorizontalGlobal(8),
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
                                  style: fontFammilyDii(
                                      context,
                                      size.width >= 1440 ? 14 : 10,
                                      noir,
                                      FontWeight.w700,
                                      FontStyle.normal)),
                            ),
                          ),
                          paddingHorizontalGlobal(8),
                        ],
                      ),
                      paddingVerticalGlobal(4),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              homeUtilisateurBloc.setAticle(article!);
                              js.context.callMethod('open', [
                                'https://a221.net/article/${article!.slug!}',
                                '_self'
                              ]);
                            },
                            child: HtmlWidget(
                              extractFirstTwoSentences(
                                  article!.description!, 1),
                              textStyle: fontFammilyDii(
                                  context,
                                  size.width >= 1440
                                      ? 14
                                      : size.width >= 1024 && size.width < 1440
                                          ? 10
                                          : 10,
                                  noir,
                                  FontWeight.w300,
                                  FontStyle.normal),
                            ),
                          ),
                        ),
                      ),
                      paddingVerticalGlobal(4)
                    ],
                  ),
                ),
                paddingVerticalGlobal(8),
              ],
            ),
          ),
        ));
  }
}
