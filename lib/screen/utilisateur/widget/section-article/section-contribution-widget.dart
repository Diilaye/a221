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
      child: homeUtilisateurBloc.articles.isEmpty
          ? SizedBox()
          : SizedBox(
              height: 650,
              width: size.width * .8,
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
                            GestureDetector(
                              onTap: () => context.go(
                                '/categorie/${homeUtilisateurBloc.articleContributions.first.categorie!.slug!.toLowerCase()}',
                              ),
                              child: Text(
                                'voir +'.toUpperCase(),
                                style: fontFammilyDii(
                                    context,
                                    size.width >= 1440
                                        ? 20
                                        : size.width >= 1024 &&
                                                size.width < 1440
                                            ? 14
                                            : 10,
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
                                    .lastWhere((e) => e.type == "commercial")
                                    .titre!
                                    .toUpperCase(),
                                style: fontFammilyDii(
                                    context,
                                    size.width >= 1440
                                        ? 20
                                        : size.width >= 1024 &&
                                                size.width < 1440
                                            ? 14
                                            : 10,
                                    noir,
                                    FontWeight.bold,
                                    FontStyle.normal),
                              ),
                            ],
                          )),
                    ],
                  ),
                  paddingVerticalGlobal(),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Expanded(
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
                                            sizeTags: 12,
                                            sizeTitle: 14,
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
                                                .articleContributions[4]),
                                      ],
                                    ))
                              ],
                            )),
                            paddingHorizontalGlobal(),
                            Expanded(
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
                                        paddingVerticalGlobal(8),
                                        Container(
                                          height: .5,
                                          color: noir,
                                        ),
                                        paddingVerticalGlobal(8),
                                        SectionArticleTernaireWidget(
                                            sizeTags: 10,
                                            sizeTitle: 10,
                                            articlesModel: homeUtilisateurBloc
                                                .articleContributions[7]),
                                      ],
                                    ))
                              ],
                            )),
                            paddingHorizontalGlobal(),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  color: blanc,
                                  height: 650,
                                  width: 300,
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
                        )),
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
