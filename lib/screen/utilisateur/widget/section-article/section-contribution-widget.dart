import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/bloc/utilisateur/posts-digiteaux.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-article-quatrenaire-widget.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-article-ternaire.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SectionContributionWidget extends StatelessWidget {
  const SectionContributionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final postsDigiteauxUserBloc = Provider.of<PostsDigiteauxUserBloc>(context);
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Center(
      child: homeUtilisateurBloc.articleContributions.isEmpty
          ? SizedBox()
          : SizedBox(
              height: 650,
              width: 1024,
              child: Column(
                children: [
                  paddingVerticalGlobal(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Text(
                              'Contribution & analyse'.toUpperCase(),
                              style: fontFammilyDii(
                                  context,
                                  24,
                                  noir,
                                  FontWeight.bold,
                                  FontStyle.normal),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () async {
                                await homeUtilisateurBloc.setCatMenu(homeUtilisateurBloc
                                    .categories
                                    .firstWhere((e) => e.titre! == "CONTRIBUTION & ANALYSE"));

                                context.go(
                                  '/categorie/${homeUtilisateurBloc.articleContributions.first.categorie!.slug!.toLowerCase()}',
                                );
                                await homeUtilisateurBloc.setCategorieMenu();
                              } ,
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
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                postsDigiteauxUserBloc.listePosts
                                    .lastWhere((e) => e.type == "commercial" && e.statusOnline =="on")
                                    .titre!
                                    .toUpperCase(),
                                style: fontFammilyDii(
                                    context,
                                   14,
                                    noir,
                                    FontWeight.bold,
                                    FontStyle.normal),
                              ),
                            ],
                          )),
                    ],
                  ),
                  paddingVerticalGlobal(),
                  SizedBox(
                    height: 550,
                    width: 1024,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 345,
                            height: 550,
                            child: Column(
                              children: [
                                SectionArticleQuatrenaireWidget(
                                  article: homeUtilisateurBloc
                                      .articleContributions[0],
                                ),
                                paddingVerticalGlobal(8),
                                Container(
                                  height: .5,
                                  color: noir,
                                ),
                                paddingVerticalGlobal(8),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        SectionArticleTernaireWidget(
                                            sizeTags: 10,
                                            sizeTitle: 12,
                                            articlesModel: homeUtilisateurBloc
                                                .articleContributions[2]),
                                        paddingVerticalGlobal(8),
                                        Container(
                                          height: .5,
                                          color: noir,
                                        ),
                                        paddingVerticalGlobal(8),
                                        SectionArticleTernaireWidget(
                                            sizeTags: 10,
                                            sizeTitle: 12,
                                            articlesModel: homeUtilisateurBloc
                                                .articleContributions[3]),

                                      ],
                                    ))
                              ],
                            )),
                        paddingHorizontalGlobal(),
                        SizedBox(
                            width: 345,
                            height: 550,
                            child: Column(
                              children: [
                                SectionArticleQuatrenaireWidget(
                                  article: homeUtilisateurBloc
                                      .articleContributions[1],
                                ),
                                paddingVerticalGlobal(8),
                                Container(
                                  height: .5,
                                  color: noir,
                                ),
                                paddingVerticalGlobal(8),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        SectionArticleTernaireWidget(
                                            sizeTags: 10,
                                            sizeTitle: 12,
                                            articlesModel: homeUtilisateurBloc
                                                .articleContributions[5]),
                                        paddingVerticalGlobal(8),
                                        Container(
                                          height: .5,
                                          color: noir,
                                        ),
                                        paddingVerticalGlobal(8),
                                        SectionArticleTernaireWidget(
                                            sizeTags: 10,
                                            sizeTitle: 12,
                                            articlesModel: homeUtilisateurBloc
                                                .articleContributions[6]),

                                      ],
                                    ))
                              ],
                            )),
                        paddingHorizontalGlobal(),

                        Expanded(
                            flex: 1,
                            child: Container(
                              color: blanc,
                              height: 600,
                              width: 340,
                              child: Image.network(
                                BASE_URL_ASSET +
                                    postsDigiteauxUserBloc.listePosts
                                        .lastWhere(
                                            (e) => e.type == "commercial")
                                        .image!
                                        .url!,
                                fit: BoxFit.fitHeight,
                              ),
                            ))
                      ],
                    ),
                  ),
                  paddingVerticalGlobal(),
                ],
              ),
            ),
    );
  }
}
