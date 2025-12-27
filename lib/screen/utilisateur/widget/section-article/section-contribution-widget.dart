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
    final postsDigiteauxUserBloc = Provider.of<PostsDigiteauxUserBloc>(context);
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    if (homeUtilisateurBloc.articleContributions.isEmpty) {
      return const SizedBox();
    }

    // Trouver la pub commerciale active de façon sécurisée
    final commercialPost = postsDigiteauxUserBloc.listePosts
        .where((e) => e.type == "commercial" && e.statusOnline == "on")
        .lastOrNull;

    return Center(
      child: SizedBox(
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
                      InkWell( // Remplace GestureDetector pour un meilleur feedback visuel
                        onTap: () async {
                          try {
                            final cat = homeUtilisateurBloc.categories
                                .firstWhere((e) => e.titre == "CONTRIBUTION & ANALYSE",
                                    orElse: () => throw "Catégorie non trouvée");
                            
                            final article = homeUtilisateurBloc.articleContributions.first;
                            if (article.categorie?.slug == null) return;

                            await homeUtilisateurBloc.setCatMenu(cat);
                            context.go('/categorie/${article.categorie!.slug!.toLowerCase()}');
                            await homeUtilisateurBloc.setCategorieMenu();
                          } catch (e) {
                            // Silencieux en prod, mais idéalement loguer l'erreur
                          }
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
                    ],
                  ),
                ),
                if (commercialPost?.titre != null)
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            commercialPost!.titre!.toUpperCase(),
                            style: fontFammilyDii(
                                context,
                                14,
                                noir,
                                FontWeight.bold,
                                FontStyle.normal),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                            child: Builder(
                              builder: (context) {
                                final commercial = postsDigiteauxUserBloc.listePosts
                                    .where((e) => e.type == "commercial" && e.statusOnline == "on")
                                    .lastOrNull;
                                    
                                if (commercial?.image?.url == null) {
                                  return const SizedBox();
                                }

                                return Image.network(
                                  BASE_URL_ASSET + commercial!.image!.url!,
                                  fit: BoxFit.fitHeight,
                                  errorBuilder: (context, _, __) => const SizedBox(),
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / 
                                              loadingProgress.expectedTotalBytes!
                                            : null,
                                        strokeWidth: 2,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        )
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