import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class SectionArticleQuatrenaireWidget extends StatelessWidget {
  final ArticlesModel article;
  const SectionArticleQuatrenaireWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Expanded(
      flex: 2,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Stack(
          children: [
            Container(
              color: blanc,
            ),
            Positioned(
                child: GestureDetector(
              onTap: () {
                homeUtilisateurBloc.setAticle(article);
                js.context.callMethod('open',
                    ['https://a221.net/article/${article.slug!}', '_self']);
                // context.go('/article/${article.slug!}');
              },
              child: Container(
                height: 200,
                // width: size.width * .2,
                decoration: BoxDecoration(
                    color: blanc,
                    image: DecorationImage(
                        image: NetworkImage(
                            BASE_URL_ASSET + article.imageArticle!.url!),
                        fit: BoxFit.cover)),
              ),
            )),
            Positioned(
                top: 170,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    context.go('/tag/${article.tags!.slug!}');
                  },
                  child: Container(
                    height: 30,
                    // width: 150,
                    color: blanc,
                    child: Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Text(
                          article.tags!.titre!.toUpperCase(),
                          style: fontFammilyDii(context, 10, rouge,
                              FontWeight.bold, FontStyle.normal),
                        ),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                  ),
                )),
            Positioned(
                top: 200,
                width: size.width * .27,
                height: 120,
                child: Column(
                  children: [
                    paddingVerticalGlobal(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            homeUtilisateurBloc.setAticle(article);
                            js.context.callMethod('open', [
                              'https://a221.net/article/${article.slug!}',
                              '_self'
                            ]);
                            // context.go('/article/${article.slug!}');
                          },
                          child: Text(
                            article.titre!,
                            style: fontFammilyDii(context, 14, noir,
                                FontWeight.w600, FontStyle.normal),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
