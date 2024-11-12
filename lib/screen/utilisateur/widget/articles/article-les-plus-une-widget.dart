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

class ArticleLesPlusLueUneWidget extends StatelessWidget {
  final ArticlesModel? article;
  const ArticleLesPlusLueUneWidget({super.key, this.article = null});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Expanded(
        flex: 2,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  homeUtilisateurBloc.setAticle(article!);
                  js.context.callMethod('open',
                      ['https://a221.net/article/${article!.slug!}', '_self']);
                },
                child: SizedBox(
                  child: Image.network(
                    BASE_URL_ASSET + article!.imageArticle!.url!,
                    height: 300,
                    width: 500,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
              paddingHorizontalGlobal(8),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  paddingVerticalGlobal(0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.go('/tag/${article!.tags!.slug!}');
                        },
                        child: Container(
                          height: 30,
                          color: blanc,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(6),
                              Text(
                                article!.tags!.titre!,
                                style: fontFammilyDii(
                                    context,
                                    size.width >= 1440
                                        ? 14
                                        : size.width >= 1024 &&
                                                size.width < 1440
                                            ? 12
                                            : 10,
                                    rouge,
                                    FontWeight.bold,
                                    FontStyle.normal),
                              ),
                              paddingHorizontalGlobal(6),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(6),
                  GestureDetector(
                    onTap: () {
                      homeUtilisateurBloc.setAticle(article!);
                      js.context.callMethod('open', [
                        'https://a221.net/article/${article!.slug!}',
                        '_self'
                      ]);
                    },
                    child: Text(
                      article!.titre!,
                      style: fontFammilyDii(
                          context,
                          size.width >= 1440
                              ? 14
                              : size.width >= 1024 && size.width < 1440
                                  ? 12
                                  : 10,
                          blanc,
                          FontWeight.bold,
                          FontStyle.normal),
                    ),
                  ),
                  paddingVerticalGlobal(4),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        homeUtilisateurBloc.setAticle(article!);
                        js.context.callMethod('open', [
                          'https://a221.net/article/${article!.slug!}',
                          '_self'
                        ]);
                      },
                      child: HtmlWidget(
                        extractFirstTwoSentences(article!.description!, 1),
                        textStyle: fontFammilyDii(
                            context,
                            size.width >= 1440
                                ? 13
                                : size.width >= 1024 && size.width < 1440
                                    ? 10
                                    : 8,
                            blanc,
                            FontWeight.w300,
                            FontStyle.normal),
                      ),
                    ),
                  ),
                  paddingVerticalGlobal(6),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Container(
                  //       height: 35,
                  //       color: blanc,
                  //       child: Row(
                  //         children: [
                  //           paddingHorizontalGlobal(8),
                  //           Text(
                  //             "Lire la suite ...",
                  //             style: fontFammilyDii(context, 12, rouge,
                  //                 FontWeight.bold, FontStyle.normal),
                  //           ),
                  //           paddingHorizontalGlobal(8),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              )),
              paddingHorizontalGlobal(8),
            ],
          ),
        ));
  }
}
