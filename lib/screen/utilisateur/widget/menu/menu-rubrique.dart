import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-item-section-rubrique.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-rubrique-article.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuRubrique extends StatelessWidget {
  final int number;

  const MenuRubrique({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    return Positioned(
      top: 210,
      child: homeUtilisateurBloc.categorieMenuModel == null
          ? SizedBox()
          : Container(
              height: 800,
              width: size.width,
              color: gris,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .1),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      color: gris,
                      child: Column(
                        children: [
                          paddingVerticalGlobal(32),
                          MenuItemSectionRubrique(
                              titre: homeUtilisateurBloc.catMenu!.titre!),
                          paddingVerticalGlobal(32),
                          Expanded(
                              child: Column(
                            children: homeUtilisateurBloc
                                .categorieMenuModel!.sousRubrique!
                                .map((e) => Column(
                                      children: [
                                        MenuItemSectionRubrique(
                                          titre: e.titre!,
                                          sub: 1,
                                        ),
                                        paddingVerticalGlobal(32),
                                      ],
                                    ))
                                .toList(),
                          )),
                        ],
                      ),
                    )),
                    paddingHorizontalGlobal(32),
                    Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            paddingVerticalGlobal(32),
                            if (homeUtilisateurBloc
                                    .categorieMenuModel!.articles!.length >=
                                4)
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                          children: homeUtilisateurBloc
                                              .categorieMenuModel!.articles!
                                              .sublist(0, 4)
                                              .toList()
                                              .reversed
                                              .map(
                                                (e) => Expanded(
                                                  child: Row(
                                                    children: [
                                                      paddingHorizontalGlobal(
                                                          8),
                                                      Expanded(
                                                          child:
                                                              MenuArticleRubrique(
                                                        article: e,
                                                      )),
                                                      paddingHorizontalGlobal(
                                                          8),
                                                    ],
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                    paddingVerticalGlobal(),
                                    Expanded(
                                      child: Row(
                                          children: homeUtilisateurBloc
                                              .categorieMenuModel!.articles!
                                              .sublist(0, 4)
                                              .toList()
                                              .reversed
                                              .map(
                                                (e) => Expanded(
                                                  child: Row(
                                                    children: [
                                                      paddingHorizontalGlobal(
                                                          8),
                                                      Expanded(
                                                          child:
                                                              MenuArticleRubrique(
                                                        article: e,
                                                      )),
                                                      paddingHorizontalGlobal(
                                                          8),
                                                    ],
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                    paddingVerticalGlobal(150),
                                  ],
                                ),
                              ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
    );
  }
}
