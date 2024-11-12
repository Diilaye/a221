import 'package:actu/bloc/utilisateur/emission-user-bloc.dart';
import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/bloc/utilisateur/papier-journal-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/footer-mobile.dart';
import 'package:actu/screen/utilisateur/widget/emissions/article-top-bar.dart';
import 'package:actu/screen/utilisateur/widget/emissions/emission-top-bar.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-mobile-item.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MenuMobile extends StatelessWidget {
  const MenuMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final emissionUserBloc = Provider.of<EmissionUserBloc>(context);
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    final papierJournalUserBloc = Provider.of<PapierJournalUserBloc>(context);

    return Container(
      height: size.height - 60,
      width: size.width,
      color: blanc,
      child: ListView(
        children: [
          Container(
            height: 120,
            color: noir,
            child: Row(
              children: [
                Expanded(
                    child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => context.go('/login'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.person_alt_circle,
                          color: blanc,
                          size: 32,
                        ),
                        paddingVerticalGlobal(6),
                        Text(
                          'Se connecter',
                          style: fontFammilyDii(context, 16, blanc,
                              FontWeight.w400, FontStyle.normal),
                        )
                      ],
                    ),
                  ),
                )),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.search,
                      color: blanc,
                      size: 32,
                    ),
                    paddingVerticalGlobal(6),
                    Text(
                      'Rechercher',
                      style: fontFammilyDii(context, 16, blanc, FontWeight.w400,
                          FontStyle.normal),
                    )
                  ],
                )),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.arrow_counterclockwise,
                      color: blanc,
                      size: 32,
                    ),
                    paddingVerticalGlobal(6),
                    Text(
                      "Fil d'info",
                      style: fontFammilyDii(context, 16, blanc, FontWeight.w300,
                          FontStyle.normal),
                    )
                  ],
                )),
              ],
            ),
          ),
          paddingVerticalGlobal(4),
          emissionUserBloc.emissions.length == 0
              ? const SizedBox()
              : SizedBox(
                  height: 90,
                  width: size.width,
                  child: Column(
                    children: [
                      EmissionTopBarWidget(
                        emissionModel: emissionUserBloc.suivreEmission!,
                      ),
                    ],
                  ),
                ),
          paddingVerticalGlobal(4),
          homeUtilisateurBloc.topArticle == null
              ? const SizedBox()
              : SizedBox(
                  height: 90,
                  width: size.width,
                  child: Column(
                    children: [
                      ArticleTopBarWidget(
                          articlesModel: homeUtilisateurBloc.topArticle!),
                    ],
                  ),
                ),
          paddingVerticalGlobal(4),
          emissionUserBloc.emissions.length == 0
              ? const SizedBox()
              : SizedBox(
                  height: 90,
                  width: size.width,
                  child: Column(
                    children: [
                      EmissionTopBarWidget(
                        emissionModel: emissionUserBloc.inviteEmission!,
                      ),
                    ],
                  ),
                ),
          paddingVerticalGlobal(4),
          Column(
              children: homeUtilisateurBloc.categories
                  .map((e) => MenuMobileItem(
                        categorie: e,
                      ))
                  .toList()),
          paddingVerticalGlobal(4),
          Container(
            height: 120,
            width: size.width,
            color: gris,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  height: 110,
                  width: size.width * .5,
                  child: Image.network(BASE_URL_ASSET +
                      papierJournalUserBloc.papierJournals.last.image!.url!),
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 40,
                        color: noir,
                        child: Row(
                          children: [
                            paddingHorizontalGlobal(8),
                            Text(
                              'Lire le journal',
                              style: fontFammilyDii(context, 12, blanc,
                                  FontWeight.w400, FontStyle.normal),
                            ),
                            paddingHorizontalGlobal(8),
                          ],
                        ))
                  ],
                ))
              ],
            ),
          ),
          paddingVerticalGlobal(4),
          const FooterMobile()
        ],
      ),
    );
  }
}
