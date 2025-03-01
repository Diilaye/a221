import 'package:actu/bloc/utilisateur/emission-user-bloc.dart';
import 'package:actu/bloc/utilisateur/flash-news-bloc.dart';
import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/pages/mobiles/categorie-mobile-screen.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-bloc-multi-widget.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-les-plus-lue.dart';
import 'package:actu/screen/utilisateur/widget/categorie/article-categorie-row-widget.dart';
import 'package:actu/screen/utilisateur/widget/emissions/article-top-bar.dart';
import 'package:actu/screen/utilisateur/widget/emissions/emission-top-bar.dart';
import 'package:actu/screen/utilisateur/widget/flash-info/flash-news-widget.dart';
// import 'package:actu/screen/utilisateur/widget/footer/lien-footer.dart';
import 'package:actu/screen/utilisateur/widget/footer/section-footer.dart';
// import 'package:actu/screen/utilisateur/widget/footer/titre-top-footer.dart';
import 'package:actu/screen/utilisateur/widget/menu/exit-menu-rubrique.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-bar.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-rubrique.dart';
import 'package:actu/screen/utilisateur/widget/menu/top-bar-menu.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-article-ternaire.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:meta_seo/meta_seo.dart';
import 'package:provider/provider.dart';

class CategorieHome extends StatelessWidget {
  const CategorieHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    final flashNewsUserBloc = Provider.of<FlashNewsUserBloc>(context);

    final emissionUserBloc = Provider.of<EmissionUserBloc>(context);

    return deviceName(size) == ScreenType.Mobile
        ? const CategorieMobileScreen()
        : Scaffold(
            appBar: AppBar(
              elevation: .0,
              toolbarHeight: .0,
              backgroundColor: blanc,
            ),
            body: homeUtilisateurBloc.categorieMenuModel == null
                ? SizedBox()
                : Stack(
                    children: [
                      Container(
                        color: blanc,
                      ),
                      Container(
                        height: size.height,
                        width: size.width,
                        color: gris,
                        child: ListView(
                          controller: homeUtilisateurBloc.controllerListHome,
                          children: [
                            homeUtilisateurBloc.showMenu == 0
                                ? paddingVerticalGlobal(220)
                                : paddingVerticalGlobal(220),
                            paddingVerticalGlobal(),
                            Center(
                              child: Container(
                                height: 200,
                                width: size.width * .6,
                                color: jaune,
                                child: Center(
                                  child: Text('Espace Pub'),
                                ),
                              ),
                            ),
                            paddingVerticalGlobal(),
                            Center(
                              child: Card(
                                elevation: .4,
                                child: Container(
                                  width: size.width * .6,
                                  color: blanc,
                                  child: Column(
                                    children: [
                                      paddingVerticalGlobal(),
                                      Row(
                                        children: [
                                          paddingHorizontalGlobal(),
                                          Text(
                                            homeUtilisateurBloc
                                                .categorieMenuModel!
                                                .categorie!
                                                .titre!
                                                .toUpperCase(),
                                            style: fontFammilyDii(
                                                context,
                                                42,
                                                noir,
                                                FontWeight.w600,
                                                FontStyle.normal),
                                          ),
                                        ],
                                      ),
                                      paddingVerticalGlobal(),
                                      Container(
                                        height: 2,
                                        width: size.width * .8,
                                        decoration: BoxDecoration(
                                            color: bleuMarine,
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                      ),
                                      paddingVerticalGlobal(),
                                      SizedBox(
                                        width: size.width * .8,
                                        height: (homeUtilisateurBloc
                                                        .categorieMenuModel!
                                                        .articles!
                                                        .length /
                                                    3)
                                                .ceil() *
                                            300,
                                        child: Row(
                                          children: [
                                            paddingHorizontalGlobal(32),
                                            Expanded(
                                              flex: 2,
                                              child: GridView.count(
                                                crossAxisCount: 3,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                children: homeUtilisateurBloc
                                                    .categorieMenuModel!
                                                    .articles!
                                                    .map(
                                                      (e) => SizedBox(
                                                        height: 300,
                                                        child:
                                                            ArticleBlocMultiWidget(
                                                          article: e,
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                            // paddingHorizontalGlobal(32),
                                            // Expanded(
                                            //     child: Column(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.start,
                                            //   children: [
                                            //     SizedBox(
                                            //       height: 100,
                                            //       child: SectionArticleTernaireWidget(
                                            //           tagShowRigth: 0,
                                            //           showRigth: 0,
                                            //           sizeTags: 12,
                                            //           sizeTitle: 12,
                                            //           articlesModel: homeUtilisateurBloc
                                            //               .articles
                                            //               .lastWhere((e) =>
                                            //                   (e.categorie!
                                            //                           .id! ==
                                            //                       homeUtilisateurBloc
                                            //                           .categorieMenuModel!
                                            //                           .categorie!
                                            //                           .id!) &&
                                            //                   e.typeUne! ==
                                            //                       "rubrique")),
                                            //     ),
                                            //     paddingVerticalGlobal(32),
                                            //     Container(
                                            //       height: 500,
                                            //       decoration: const BoxDecoration(
                                            //           image: DecorationImage(
                                            //               image: NetworkImage(
                                            //                   "https://tpc.googlesyndication.com/simgad/1642461998111929762"),
                                            //               fit: BoxFit.cover)),
                                            //     ),
                                            //     paddingVerticalGlobal(32),
                                            //     Container(
                                            //       height: 650,
                                            //       decoration: BoxDecoration(
                                            //           border: Border(
                                            //               top: BorderSide(
                                            //                   width: 5,
                                            //                   color: noir))),
                                            //       child: Column(
                                            //         children: [
                                            //           paddingVerticalGlobal(),
                                            //           Row(
                                            //             children: [
                                            //               paddingHorizontalGlobal(),
                                            //               Text(
                                            //                 'Les plus lus'
                                            //                     .toUpperCase(),
                                            //                 style:
                                            //                     fontFammilyDii(
                                            //                         context,
                                            //                         18,
                                            //                         noir,
                                            //                         FontWeight
                                            //                             .w600,
                                            //                         FontStyle
                                            //                             .normal),
                                            //               ),
                                            //             ],
                                            //           ),
                                            //           Expanded(
                                            //             child: Column(
                                            //               children:
                                            //                   homeUtilisateurBloc
                                            //                       .articles
                                            //                       .sublist(1, 6)
                                            //                       .map(
                                            //                         (e) =>
                                            //                             ArticleLesPlusLue(
                                            //                           nombre: homeUtilisateurBloc
                                            //                               .articles
                                            //                               .indexOf(
                                            //                                   e),
                                            //                           article:
                                            //                               e,
                                            //                         ),
                                            //                       )
                                            //                       .toList(),
                                            //             ),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //     paddingVerticalGlobal(32),
                                            //     Container(
                                            //       height: 500,
                                            //       decoration: BoxDecoration(
                                            //           color: gris,
                                            //           border: Border(
                                            //               top: BorderSide(
                                            //                   width: 5,
                                            //                   color: noir))),
                                            //       child: Column(
                                            //         children: [
                                            //           paddingVerticalGlobal(),
                                            //           Row(
                                            //             children: [
                                            //               paddingHorizontalGlobal(),
                                            //               Text(
                                            //                 "édition du jour"
                                            //                     .toUpperCase(),
                                            //                 style:
                                            //                     fontFammilyDii(
                                            //                         context,
                                            //                         16,
                                            //                         noir,
                                            //                         FontWeight
                                            //                             .w900,
                                            //                         FontStyle
                                            //                             .normal),
                                            //               )
                                            //             ],
                                            //           ),
                                            //           paddingVerticalGlobal(4),
                                            //           Row(
                                            //             children: [
                                            //               paddingHorizontalGlobal(),
                                            //               Text(
                                            //                 "Daté du mercredi 24 juillet 2024"
                                            //                     .toUpperCase(),
                                            //                 style:
                                            //                     fontFammilyDii(
                                            //                         context,
                                            //                         10,
                                            //                         noir,
                                            //                         FontWeight
                                            //                             .w300,
                                            //                         FontStyle
                                            //                             .normal),
                                            //               )
                                            //             ],
                                            //           ),
                                            //           paddingVerticalGlobal(),
                                            //           Expanded(
                                            //               child: Image.asset(
                                            //             "assets/images/unejournal2.jpg",
                                            //             fit: BoxFit.contain,
                                            //           )),
                                            //           paddingVerticalGlobal(),
                                            //           Row(
                                            //             children: [
                                            //               paddingHorizontalGlobal(),
                                            //               Expanded(
                                            //                 child: Container(
                                            //                   height: 45,
                                            //                   color: noir,
                                            //                   child: Center(
                                            //                     child: Text(
                                            //                       'Lire le journal numérique',
                                            //                       style: fontFammilyDii(
                                            //                           context,
                                            //                           14,
                                            //                           blanc,
                                            //                           FontWeight
                                            //                               .bold,
                                            //                           FontStyle
                                            //                               .normal),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //               paddingHorizontalGlobal(),
                                            //             ],
                                            //           ),
                                            //           paddingVerticalGlobal(),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //     paddingVerticalGlobal(),
                                            //     Container(
                                            //       height: 300,
                                            //       color: jaune,
                                            //     ),
                                            //     paddingVerticalGlobal(),
                                            //   ],
                                            // )),
                                            paddingHorizontalGlobal(32),
                                          ],
                                        ),
                                      ),
                                      paddingVerticalGlobal(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            paddingVerticalGlobal(),
                            const SectionFooter(),
                            paddingVerticalGlobal(46)
                          ],
                        ),
                      ),
                      Positioned(
                          top: 0,
                          child: Container(
                            height: 215,
                            width: size.width,
                            color: rouge,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 5,
                                  color: blanc,
                                )
                              ],
                            ),
                          )),
                      Positioned(
                          top: 84,
                          right: 0,
                          left: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 75,
                              width: 1024,
                              child: Row(
                                children: [

                                  Expanded(
                                      child: Container(
                                        height: 120,
                                        color: blanc,
                                        child: Row(
                                          children: [
                                            emissionUserBloc.emissions.length == 0
                                                ? SizedBox()
                                                : EmissionTopBarWidget(
                                              emissionModel: emissionUserBloc
                                                  .suivreEmission!,
                                            ),
                                            Container(
                                              width: 2,
                                              color: rouge,
                                            ),
                                            paddingHorizontalGlobal(8),
                                            homeUtilisateurBloc.topArticle == null
                                                ? SizedBox()
                                                : ArticleTopBarWidget(
                                                articlesModel: homeUtilisateurBloc
                                                    .topArticle!),
                                            Container(
                                              width: 2,
                                              color: rouge,
                                            ),
                                            paddingHorizontalGlobal(8),
                                            emissionUserBloc.emissions.length == 0
                                                ? SizedBox()
                                                : EmissionTopBarWidget(
                                              emissionModel: emissionUserBloc
                                                  .inviteEmission!,
                                            ),
                                          ],
                                        ),
                                      )),

                                ],
                              ),
                            ),
                          )),
                      Positioned(
                          top: 20,
                          left: 0,   // Permet d'étendre sur toute la largeur
                          right: 0,
                          child: const TopBarMenu()),


                      MenuBarArticle(
                        categories: homeUtilisateurBloc.categories
                            .where((e) => e.showMenu == "1")
                            .toList(),
                      ),


                      if (homeUtilisateurBloc.hoverMenuClick != 0)
                        MenuRubrique(
                          number: homeUtilisateurBloc.hoverMenuClick,
                        ),
                      if (homeUtilisateurBloc.hoverMenuClick != 0)
                        const ExitMenuRubrique(),
                    ],
                  ),
          );
  }
}
