import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/article-economique-secondaire.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class SectionActualiteMobile extends StatelessWidget {
  const SectionActualiteMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return homeUtilisateurBloc.articleActualites.isNotEmpty ? Container(
      color: bgNoir,
      child: Column(
        children: [
          SizedBox(
            height: 45,
            child: Row(
              children: [
                paddingHorizontalGlobal(),
                Text(
                  'actualité'.toUpperCase(),
                  style: fontFammilyDii(
                      context, 22, blanc, FontWeight.bold, FontStyle.normal),
                ),
              ],
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                homeUtilisateurBloc.setAticle(homeUtilisateurBloc.articleActualites!.first);

                js.context.callMethod('open', [
                  'https://a221.net/article/${homeUtilisateurBloc.articleActualites!.first.slug!}',
                  '_self'
                ]);
              },
              child: SizedBox(
                height: 350,
                width: size.width,
                child: Center(
                  child: Column(
                    children: [
                      Image.network(
                        BASE_URL_ASSET +
                            homeUtilisateurBloc.articleActualites!.first!.imageArticle!.url!,
                        height: 250,
                        width: size.width * .92,
                        fit: BoxFit.cover,
                      ),
                      Row(
                        children: [
                          paddingHorizontalGlobal(16),
                          Text(
                            homeUtilisateurBloc.articleActualites!.first!.tags!.titre!,
                            style: fontFammilyDii(context, 24, blanc,
                                FontWeight.w600, FontStyle.normal),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          homeUtilisateurBloc.articleActualites!.first!.titre!,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.fade,
                          style: fontFammilyDii(
                              context, 16, blanc, FontWeight.w500, FontStyle.normal),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: homeUtilisateurBloc.articleActualites
                .sublist(1, 5)
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ArticleEconomiqueSecondaire(
                        article: e,
                        color: noir,
                      ),
                    ))
                .toList(),
          ),
          paddingVerticalGlobal(),
          Container(
            height: 1,
            color: noir,
          ),
        ],
      ),
    ) : SizedBox();
  }
}
