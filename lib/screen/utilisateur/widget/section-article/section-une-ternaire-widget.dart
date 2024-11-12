import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'dart:js' as js;

import 'package:provider/provider.dart';

class SectionUneTernaireWidget extends StatelessWidget {
  final ArticlesModel article;
  const SectionUneTernaireWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Expanded(
        child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  homeUtilisateurBloc.setAticle(article);
                  js.context.callMethod('open',
                      ['https://a221.net/article/${article.slug!}', '_self']);
                },
                child: Image.network(
                  BASE_URL_ASSET + article.imageArticle!.url!,
                  height: 500,
                  width: 1200,
                  fit: BoxFit.fill,
                ),
              )),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  paddingVerticalGlobal(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.go('/tag/${article.tags!.slug!}');
                        },
                        child: Container(
                          height: 30,
                          color: rouge,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(6),
                              Text(
                                article.tags!.titre!.toUpperCase(),
                                style: fontFammilyDii(
                                    context,
                                    size.width >= 1440
                                        ? 14
                                        : size.width >= 1024 &&
                                                size.width < 1440
                                            ? 12
                                            : 10,
                                    blanc,
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
                  GestureDetector(
                    onTap: () {
                      homeUtilisateurBloc.setAticle(article);
                      js.context.callMethod('open', [
                        'https://a221.net/article/${article.slug!}',
                        '_self'
                      ]);
                    },
                    child: Text(
                      article.titre!,
                      style: fontFammilyDii(
                          context,
                          size.width >= 1440
                              ? 28
                              : size.width >= 1024 && size.width < 1440
                                  ? 22
                                  : 16,
                          noir,
                          FontWeight.bold,
                          FontStyle.normal),
                    ),
                  )
                ],
              )),
        ],
      ),
    ));
  }
}
