import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/article-categorie-screen.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/article-categorie-secondaire.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/footer-mobile.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-bar.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-mobile.dart';
import 'package:actu/screen/utilisateur/widget/menu/top-bar-menu.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorieMobileScreen extends StatelessWidget {
  const CategorieMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    return homeUtilisateurBloc.categorieMenuModel == null
        ? SizedBox()
        : Scaffold(
            appBar: AppBar(
              toolbarHeight: .0,
              elevation: .0,
            ),
            body: Stack(
              children: [
                Container(
                  color: blanc,
                ),
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: ListView(
                    children: [
                      paddingVerticalGlobal(64),
                      homeUtilisateurBloc.categories.isEmpty
                          ? const SizedBox()
                          : Container(
                              width: size.width,
                              height: 70,
                              decoration:
                                  BoxDecoration(color: blanc, boxShadow: [
                                BoxShadow(
                                    color: noir.withOpacity(.1),
                                    offset: const Offset(0, 2),
                                    blurRadius: .1),
                                BoxShadow(
                                  color: blanc,
                                  offset: const Offset(-2, 0),
                                ),
                                BoxShadow(
                                  color: blanc,
                                  offset: const Offset(2, 0),
                                ),
                              ]),
                              child: MenuBarArticle(
                                categories: homeUtilisateurBloc.categories
                                    .where((e) => e.showMenu == "1")
                                    .toList(),
                                home: 0,
                              ),
                            ),
                      paddingVerticalGlobal(),
                      Row(
                        children: [
                          paddingHorizontalGlobal(),
                          Text(
                            homeUtilisateurBloc
                                .categorieMenuModel!.categorie!.titre!
                                .toUpperCase(),
                            style: fontFammilyDii(context, 26, bleuMarine,
                                FontWeight.w800, FontStyle.normal),
                          )
                        ],
                      ),
                      paddingVerticalGlobal(),

                      Container(
                        height: 1,
                        color: noir,
                      ),
                      paddingVerticalGlobal(),
                      Column(
                        children: [
                          Container(
                            height: 200,
                            color: blanc,
                            width: size.width,
                            child: Row(
                              children: [
                                const Spacer(),
                                ArticleCategorieMobile(
                                  article: homeUtilisateurBloc
                                      .categorieMenuModel!.articles![0],
                                ),
                                paddingHorizontalGlobal(0),
                                ArticleCategorieMobile(
                                  article: homeUtilisateurBloc
                                      .categorieMenuModel!.articles![1],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          paddingVerticalGlobal(),
                          SizedBox(
                            height: 200,
                            width: size.width,
                            child: Row(
                              children: [
                                const Spacer(),
                                ArticleCategorieMobile(
                                  article: homeUtilisateurBloc
                                      .categorieMenuModel!.articles![2],
                                ),
                                ArticleCategorieMobile(
                                  article: homeUtilisateurBloc
                                      .categorieMenuModel!.articles![3],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      paddingVerticalGlobal(),
                      Column(
                        children: [
                          SizedBox(
                            height: 200,
                            width: size.width,
                            child: Row(
                              children: [
                                const Spacer(),
                                ArticleCategorieMobile(
                                  article: homeUtilisateurBloc
                                      .categorieMenuModel!.articles![4],
                                ),
                                ArticleCategorieMobile(
                                  article: homeUtilisateurBloc
                                      .categorieMenuModel!.articles![5],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          paddingVerticalGlobal(8),
                          SizedBox(
                            height: 200,
                            width: size.width,
                            child: Row(
                              children: [
                                const Spacer(),
                                ArticleCategorieMobile(
                                  article: homeUtilisateurBloc
                                      .categorieMenuModel!.articles![6],
                                ),
                                ArticleCategorieMobile(
                                  article: homeUtilisateurBloc
                                      .categorieMenuModel!.articles![7],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),


                      paddingVerticalGlobal(),
                      Container(
                        height: 1,
                        color: noir,
                      ),
                      paddingVerticalGlobal(),
                      Column(
                        children: homeUtilisateurBloc
                            .categorieMenuModel!.articles!
                            .sublist(0, 5)
                            .map((e) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: ArticleCategorieSecondaire(
                                    article: e,
                                  ),
                                ))
                            .toList(),
                      ),
                      paddingVerticalGlobal(),
                      Container(
                        height: 45,
                        color: noir,
                        child: Center(
                          child: Text(
                            'Voir plus',
                            style: fontFammilyDii(context, 14, blanc,
                                FontWeight.w600, FontStyle.normal),
                          ),
                        ),
                      ),
                      const FooterMobile(),
                    ],
                  ),
                ),
                if (homeUtilisateurBloc.showMenuMobile == 1)
                  const Positioned(top: 60, child: MenuMobile()),
                const Positioned(
                    top: 0,
                    child: TopBarMenu())
              ],
            ),
          );
  }
}
