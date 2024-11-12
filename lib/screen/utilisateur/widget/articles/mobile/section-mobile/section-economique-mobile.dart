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

class SectionEconomiqueMobile extends StatelessWidget {
  const SectionEconomiqueMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Column(
      children: [
        Container(
          height: 45,
          color: blanc,
          child: Row(
            children: [
              paddingHorizontalGlobal(),
              Text(
                'économie'.toUpperCase(),
                style: fontFammilyDii(
                    context, 22, rouge, FontWeight.bold, FontStyle.normal),
              ),
            ],
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              homeUtilisateurBloc.setAticle(homeUtilisateurBloc.uneEconomie!);

              js.context.callMethod('open', [
                'https://a221.net/article/${homeUtilisateurBloc.uneEconomie!.slug!}',
                '_self'
              ]);
            },
            child: Container(
              height: 330,
              width: size.width,
              color: blanc,
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
                        style: fontFammilyDii(context, 24, rouge,
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
                      style: fontFammilyDii(
                          context, 16, noir, FontWeight.w500, FontStyle.normal),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: homeUtilisateurBloc.articleEconomies
              .sublist(0, 5)
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ArticleEconomiqueSecondaire(
                      article: e,
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
    );
  }
}
