import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-article-ternaire.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-une-ternaire-widget.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SectionPolitiqueWidget extends StatelessWidget {
  const SectionPolitiqueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return SizedBox(
      height: 500,
      width: size.width,
      child: Column(
        children: [
          paddingVerticalGlobal(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              paddingHorizontalGlobal(size.width * .1),
              Text(
                'Politique'.toUpperCase(),
                style: fontFammilyDii(
                    context,
                    size.width >= 1440
                        ? 24
                        : size.width >= 1024 && size.width < 1440
                            ? 18
                            : 14,
                    noir,
                    FontWeight.bold,
                    FontStyle.normal),
              ),
              const Spacer(),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    await homeUtilisateurBloc.setCatMenu(homeUtilisateurBloc
                        .categories
                        .firstWhere((e) => e.titre! == "POLITIQUE"));
                    await homeUtilisateurBloc.setCategorieMenu();

                    context.go(
                        '/categorie/${homeUtilisateurBloc.categories.firstWhere((e) => e.titre! == "POLITIQUE").slug!.toLowerCase()}');
                  },
                  child: Text(
                    'voir +'.toUpperCase(),
                    style: fontFammilyDii(
                        context,
                        size.width >= 1440
                            ? 20
                            : size.width >= 1024 && size.width < 1440
                                ? 14
                                : 10,
                        rouge,
                        FontWeight.bold,
                        FontStyle.normal),
                  ),
                ),
              ),
              paddingHorizontalGlobal(size.width * .1)
            ],
          ),
          paddingVerticalGlobal(),
          Expanded(
              child: Row(
            children: [
              paddingHorizontalGlobal(size.width * .1),
              Expanded(
                  child: Row(
                children: [
                  SectionUneTernaireWidget(
                    article: homeUtilisateurBloc.unePolitique!,
                  ),
                  paddingHorizontalGlobal(),
                  homeUtilisateurBloc.articles.isEmpty
                      ? SizedBox()
                      : Expanded(
                          child: Column(
                          children: [
                            SectionArticleTernaireWidget(
                              articlesModel:
                                  homeUtilisateurBloc.articlePolitiques[0],
                              sizeTags: size.width >= 1440 ? 14 : 10,
                              sizeTitle: size.width >= 1440 ? 14 : 12,
                            ),
                            paddingVerticalGlobal(),
                            SectionArticleTernaireWidget(
                              articlesModel:
                                  homeUtilisateurBloc.articlePolitiques[1],
                              sizeTags: size.width >= 1440 ? 14 : 10,
                              sizeTitle: size.width >= 1440 ? 14 : 12,
                            ),
                            paddingVerticalGlobal(),
                            SectionArticleTernaireWidget(
                              articlesModel:
                                  homeUtilisateurBloc.articlePolitiques[2],
                              sizeTags: size.width >= 1440 ? 14 : 10,
                              sizeTitle: size.width >= 1440 ? 14 : 12,
                            ),
                            paddingVerticalGlobal(),
                            SectionArticleTernaireWidget(
                              articlesModel:
                                  homeUtilisateurBloc.articlePolitiques[3],
                              sizeTags: size.width >= 1440 ? 14 : 10,
                              sizeTitle: size.width >= 1440 ? 14 : 12,
                            ),
                          ],
                        )),
                ],
              )),
              paddingHorizontalGlobal(size.width * .1),
            ],
          )),
          paddingVerticalGlobal(32),
        ],
      ),
    );
  }
}
