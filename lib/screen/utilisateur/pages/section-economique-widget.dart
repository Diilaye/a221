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
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return homeUtilisateurBloc.articleEconomies.isEmpty
        ? const SizedBox()
        : Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            margin: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade50,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                paddingVerticalGlobal(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey.shade200)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: rouge.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.trending_up, color: rouge, size: 24),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'économie'.toUpperCase(),
                        style: fontFammilyDii(
                          context,
                          28,
                          noir,
                          FontWeight.bold,
                          FontStyle.normal,
                        ),
                      ),
                      const Spacer(),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () async {
                              await homeUtilisateurBloc.setCatMenu(
                                  homeUtilisateurBloc.categories.firstWhere(
                                      (e) => e.titre! == "ECONOMIE"));
                              if (!context.mounted) return;
                              context.go(
                                '/categorie/${homeUtilisateurBloc.articleEconomies.first.categorie!.slug!.toLowerCase()}',
                              );
                              await homeUtilisateurBloc.setCategorieMenu();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: rouge.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'voir plus'.toUpperCase(),
                                    style: fontFammilyDii(
                                      context,
                                      14,
                                      rouge,
                                      FontWeight.bold,
                                      FontStyle.normal,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.arrow_forward,
                                      color: rouge, size: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                paddingVerticalGlobal(),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        homeUtilisateurBloc.articleEconomies.isEmpty
                            ? const SizedBox()
                            : Expanded(
                                child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      SectionArticleTernaireWidget(
                                        articlesModel: homeUtilisateurBloc
                                            .articleEconomies[0],
                                        sizeTags: 13,
                                        sizeTitle: 15,
                                      ),
                                      paddingVerticalGlobal(),
                                      SectionArticleTernaireWidget(
                                        articlesModel: homeUtilisateurBloc
                                            .articleEconomies[1],
                                        sizeTags: 13,
                                        sizeTitle: 15,
                                      ),
                                      paddingVerticalGlobal(),
                                      SectionArticleTernaireWidget(
                                        articlesModel: homeUtilisateurBloc
                                            .articleEconomies[3],
                                        sizeTags: 13,
                                        sizeTitle: 15,
                                      ),
                                      paddingVerticalGlobal(),
                                      SectionArticleTernaireWidget(
                                        articlesModel: homeUtilisateurBloc
                                            .articleEconomies[4],
                                        sizeTags: 13,
                                        sizeTitle: 15,
                                      ),
                                    ],
                                  )),
                                  paddingHorizontalGlobal(),
                                  homeUtilisateurBloc.uneEconomie == null
                                      ? SizedBox()
                                      : SectionUneTernaireWidget(
                                          article:
                                              homeUtilisateurBloc.uneEconomie!,
                                        ),
                                ],
                              )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
  }
}
