import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-bloc-multi-une-lue-widget.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-les-plus-lue.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-les-plus-une-widget.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SectionInvestigationtWidget extends StatelessWidget {
  const SectionInvestigationtWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return homeUtilisateurBloc.articles.isEmpty
        ? const SizedBox()
        : Container(
            height: 600,
            width: 1024,
            color: rouge,
            child: Column(
              children: [
                paddingVerticalGlobal(32),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Text(
                              'Révélation'.toUpperCase(),
                              style: fontFammilyDii(
                                  context,
                                  24,
                                  blanc,
                                  FontWeight.bold,
                                  FontStyle.normal),
                            ),
                            const Spacer(),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () async {
                                  await homeUtilisateurBloc.setCatMenu(
                                      homeUtilisateurBloc.categories.firstWhere(
                                          (e) => e.titre! == "INVESTIGATION"));
                                  await homeUtilisateurBloc.setCategorieMenu();
                                  context.go(
                                      '/categorie/${homeUtilisateurBloc.categories.firstWhere((e) => e.titre! == "INVESTIGATION").slug!.toLowerCase().replaceAll("é", "e")}');
                                },
                                child: Text(
                                  'voir +'.toUpperCase(),
                                  style: fontFammilyDii(
                                      context,
                                      10,
                                      blanc,
                                      FontWeight.bold,
                                      FontStyle.normal),
                                ),
                              ),
                            ),
                            paddingHorizontalGlobal(size.width * .02),
                          ],
                        )),
                    Expanded(flex: 1, child: SizedBox()),
                  ],
                ),
                paddingVerticalGlobal(16),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                  if( homeUtilisateurBloc.uneInvestigations != null)  ArticleLesPlusLueUneWidget(
                                      article:
                                          homeUtilisateurBloc.uneInvestigations,
                                    ),
                                    paddingVerticalGlobal(),
                                   if(homeUtilisateurBloc
                                       .articleInvestigations.isNotEmpty) Expanded(
                                        flex: 3,
                                        child: Row(
                                          children: homeUtilisateurBloc
                                              .articleInvestigations
                                              .sublist(0, 3)
                                              .map(
                                                (e) => Expanded(
                                                    child:
                                                        ArticleBlocMultiUneLueWidget(
                                                  card: 0,
                                                  color: rouge,
                                                  article: e,
                                                )),
                                              )
                                              .toList(),
                                        )),
                                  ],
                                )),
                          if(homeUtilisateurBloc.articleActualites.isNotEmpty)  Expanded(
                                flex: 1,
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  child: Column(
                                    children: [
                                      paddingVerticalGlobal(),
                                      Row(
                                        children: [
                                          paddingHorizontalGlobal(),
                                          Text(
                                            'Les plus lues'.toUpperCase(),
                                            style: fontFammilyDii(
                                                context,
                                                14,
                                                noir,
                                                FontWeight.w600,
                                                FontStyle.normal),
                                          ),
                                        ],
                                      ),
                                      ...homeUtilisateurBloc.articleActualites
                                          .sublist(0, 5)
                                          .map((e) => ArticleLesPlusLue(
                                                nombre: homeUtilisateurBloc
                                                        .articleActualites
                                                        .indexOf(e) +
                                                    1,
                                                article: e,
                                              ))
                                          .toList(),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                paddingVerticalGlobal(32),
              ],
            ),
          );
  }
}
