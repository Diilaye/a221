import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/article-recent.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/footer-mobile.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-bar.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-mobile.dart';
import 'package:actu/screen/utilisateur/widget/menu/top-bar-menu.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleRecentScreen extends StatelessWidget {
  const ArticleRecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    Size size = MediaQuery.of(context).size;
    // final postsDigiteauxUserBloc = Provider.of<PostsDigiteauxUserBloc>(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: .0,
          elevation: .0,
        ),
        body: homeUtilisateurBloc.articles.isEmpty
            ? const SizedBox()
            : Stack(
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
                                  home: -2,
                                ),
                              ),
                        paddingVerticalGlobal(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "L'actualité en continu",
                            style: fontFammilyDii(context, 20, noir,
                                FontWeight.w800, FontStyle.normal),
                          ),
                        ),
                        paddingVerticalGlobal(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Retrouvez toute l'actualité en direct, locale, politique, sociale, economique, sportive et culturelle avec notre rédaction",
                            style: fontFammilyDii(context, 14, noir,
                                FontWeight.w300, FontStyle.normal),
                          ),
                        ),
                        paddingVerticalGlobal(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            height: .5,
                            color: noir,
                          ),
                        ),
                        paddingVerticalGlobal(),
                        Column(
                          children: homeUtilisateurBloc.articles
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: ArticleRecentWidget(
                                      article: e,
                                    ),
                                  ))
                              .toList(),
                        ),
                        paddingVerticalGlobal(),
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
              ));
  }
}
