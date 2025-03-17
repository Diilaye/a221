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

    return SizedBox(
        height: 520,
        width: 600,
        child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              homeUtilisateurBloc.setAticle(article);
              js.context.callMethod('open',
                  ['https://a221.net/article/${article.slug!}', '_self']);
            },
            child: Image.network(
              BASE_URL_ASSET + article.imageArticle!.url!,
              height: 440,
              width: 600,
              fit: BoxFit.contain,
            ),
          ),
          paddingVerticalGlobal(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  context.go('/tag/${article.tags!.slug!}');
                },
                child: Container(

                  color: rouge,
                  child: Row(
                    children: [
                      paddingHorizontalGlobal(6),
                      Text(
                        article.tags!.titre!.toUpperCase(),
                        style: fontFammilyDii(
                            context,
                             18  ,
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
          paddingVerticalGlobal(4),
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
                   16,
                  noir,
                  FontWeight.bold,
                  FontStyle.normal),
            ),
          )
        ],
      ),
    ));
  }
}
