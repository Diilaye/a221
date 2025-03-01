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
      height: 550,
      width: 1024,
      child: Column(
        children: [
          paddingVerticalGlobal(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Politique'.toUpperCase(),
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
                        14,
                        rouge,
                        FontWeight.bold,
                        FontStyle.normal),
                  ),
                ),
              ),
            ],
          ),
          paddingVerticalGlobal(),
          SizedBox(
            height: 450,
              width: 1024,
                child: Row(
            children: [
              if(homeUtilisateurBloc.unePolitique != null)  SectionUneTernaireWidget(
                article: homeUtilisateurBloc.unePolitique!,
              ),
              paddingHorizontalGlobal(),

              if(homeUtilisateurBloc.articlePolitiques.isNotEmpty)  Expanded(
                  child: Column(
                    children: [
                      SectionArticleTernaireWidget(
                        articlesModel:
                        homeUtilisateurBloc.articlePolitiques[0],
                        sizeTags:  10,
                        sizeTitle:  12,
                      ),
                      paddingVerticalGlobal(),
                      SectionArticleTernaireWidget(
                        articlesModel:
                        homeUtilisateurBloc.articlePolitiques[1],
                        sizeTags:  10,
                        sizeTitle:  12,
                      ),
                      paddingVerticalGlobal(),
                      SectionArticleTernaireWidget(
                        articlesModel:
                        homeUtilisateurBloc.articlePolitiques[2],
                        sizeTags:  10,
                        sizeTitle:  12,
                      ),
                      paddingVerticalGlobal(),
                      SectionArticleTernaireWidget(
                        articlesModel:
                        homeUtilisateurBloc.articlePolitiques[3],
                        sizeTags:  10,
                        sizeTitle:  12,
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
