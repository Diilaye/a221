import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class UneCentraleSecondaire extends StatelessWidget {
  final ArticlesModel article;
  final int index;
  const UneCentraleSecondaire(
      {super.key, required this.article, required this.index});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          homeUtilisateurBloc.setArticleMobile(index);
          homeUtilisateurBloc.setAticle(article);
          js.context.callMethod(
              'open', ['https://a221.net/article/${article.slug!}', '_self']);
          // context.go('/article/${article.slug!}');
        },
        child: Stack(
          children: [
            Image.network(
              BASE_URL_ASSET + article.imageArticle!.url!,
              fit: BoxFit.contain,
              height: 200,
              width: 200,
            ),
            /* Positioned(
              bottom: 0,
              child: Container(
                color: noir.withOpacity(.5),
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      paddingVerticalGlobal(8),
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            paddingHorizontalGlobal(4),
                            Expanded(
                              child: Text(
                                article.tags!.titre!,
                                style: fontFammilyDii(context, 13, blanc,
                                    FontWeight.bold, FontStyle.normal),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            paddingHorizontalGlobal(4),
                          ],
                        ),
                      ),
                      paddingVerticalGlobal(4),
                      Expanded(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              article.titre!,
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: blanc,
                                  shadows: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: noir.withOpacity(.5),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      paddingVerticalGlobal(8),
                    ],
                  ),
                ),
              ),
            ),

             */
          ],
        ),
      ),
    );
  }
}
