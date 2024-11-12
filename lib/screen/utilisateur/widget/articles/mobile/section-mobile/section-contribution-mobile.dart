import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/article-contribution-secondaire.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
// import 'package:go_router/go_router.dart';s
import 'package:provider/provider.dart';

import 'dart:js' as js;

class SectionContributionMobile extends StatelessWidget {
  const SectionContributionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Container(
      color: rouge,
      child: Column(
        children: [
          SizedBox(
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Contribution & Analyse'.toUpperCase(),
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
                homeUtilisateurBloc
                    .setAticle(homeUtilisateurBloc.articleContributions.first);
                js.context.callMethod('open', [
                  'https://a221.net/article/${homeUtilisateurBloc.articleContributions.first.slug!}',
                  '_self'
                ]);
              },
              child: SizedBox(
                height: 330,
                width: size.width,
                child: Column(
                  children: [
                    Image.network(
                      BASE_URL_ASSET +
                          homeUtilisateurBloc.uneEconomie!.imageArticle!.url!,
                      height: 250,
                      width: size.width * .92,
                      fit: BoxFit.cover,
                    ),
                    Row(
                      children: [
                        paddingHorizontalGlobal(16),
                        Text(
                          homeUtilisateurBloc.uneEconomie!.tags!.titre!,
                          style: fontFammilyDii(context, 24, blanc,
                              FontWeight.w600, FontStyle.normal),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        homeUtilisateurBloc.uneEconomie!.titre!,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                        style: fontFammilyDii(context, 18, blanc,
                            FontWeight.w500, FontStyle.normal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: homeUtilisateurBloc.articleContributions
                .sublist(0, 5)
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ArticlecontributionSecondaire(
                        article: e,
                      ),
                    ))
                .toList(),
          ),
          paddingVerticalGlobal(),
        ],
      ),
    );
  }
}
