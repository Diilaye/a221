// import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

import 'dart:js' as js;

class ArtilceInvestiogationMobile extends StatelessWidget {
  final ArticlesModel article;
  const ArtilceInvestiogationMobile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            homeUtilisateurBloc.setAticle(article);
            js.context.callMethod(
                'open', ['https://a221.net/article/${article.slug!}', '_self']);
          },
          child: Container(
            height: 320,
            width: size.width * .9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: NetworkImage(
                        BASE_URL_ASSET + article.imageArticle!.url!),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: rouge,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      )),
                  child: Column(
                    children: [
                      paddingVerticalGlobal(4),
                      Row(
                        children: [
                          paddingHorizontalGlobal(8),
                          Expanded(
                              child: Text(
                            article.tags!.titre!,
                            overflow: TextOverflow.fade,
                            style: fontFammilyDii(context, 14, blanc,
                                FontWeight.w700, FontStyle.normal),
                          )),
                          paddingHorizontalGlobal(8)
                        ],
                      ),
                      paddingVerticalGlobal(0),
                      Row(
                        children: [
                          paddingHorizontalGlobal(8),
                          Expanded(
                              child: Text(
                            article.titre!,
                            overflow: TextOverflow.fade,
                            style: fontFammilyDii(context, 10, blanc,
                                FontWeight.w700, FontStyle.normal),
                          )),
                          paddingHorizontalGlobal(8)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
