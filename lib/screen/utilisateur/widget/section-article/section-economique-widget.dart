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

class SectionEconomiqueWidget extends StatelessWidget {
  const SectionEconomiqueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return homeUtilisateurBloc.articleEconomies.isEmpty
        ? SizedBox()
        : SizedBox(
            height: 550,
            width: 1024,
            child: Column(
              children: [
                paddingVerticalGlobal(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'économie'.toUpperCase(),
                      style: fontFammilyDii(
                          context,
                          24,
                          noir,
                          FontWeight.bold,
                          FontStyle.normal),
                    ),
                    const Spacer(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => context.go(
                          '/categorie/${homeUtilisateurBloc.articleEconomies.first.categorie!.slug!.toLowerCase()}',
                        ),
                        child: Text(
                          'voir +'.toUpperCase(),
                          style: fontFammilyDii(
                              context,
                               10,
                              rouge,
                              FontWeight.bold,
                              FontStyle.normal),
                        ),
                      ),
                    ),
                  ],
                ),
                paddingVerticalGlobal(),
                Expanded(
                    child: Row(
                  children: [
                    homeUtilisateurBloc.articleEconomies.isEmpty
                        ? const SizedBox()
                        : Expanded(
                            child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  SectionArticleTernaireWidget(
                                    articlesModel:
                                        homeUtilisateurBloc.articleEconomies[0],
                                    sizeTags:  10,
                                    sizeTitle:  12,
                                  ),
                                  paddingVerticalGlobal(),
                                  SectionArticleTernaireWidget(
                                    articlesModel:
                                        homeUtilisateurBloc.articleEconomies[1],
                                    sizeTags:  10,
                                    sizeTitle:  12,
                                  ),
                                  paddingVerticalGlobal(),
                                  SectionArticleTernaireWidget(
                                    articlesModel:
                                        homeUtilisateurBloc.articleEconomies[3],
                                    sizeTags:  10,
                                    sizeTitle:  12,
                                  ),
                                  paddingVerticalGlobal(),
                                  SectionArticleTernaireWidget(
                                    articlesModel:
                                        homeUtilisateurBloc.articleEconomies[4],
                                    sizeTags:  10,
                                    sizeTitle:  12,
                                  ),
                                ],
                              )),
                              paddingHorizontalGlobal(),
                              homeUtilisateurBloc.uneEconomie == null
                                  ? SizedBox()
                                  : SectionUneTernaireWidget(
                                      article: homeUtilisateurBloc.uneEconomie!,
                                    ),
                            ],
                          )),
                  ],
                )),
                paddingVerticalGlobal(32),
              ],
            ),
          );
  }
}
