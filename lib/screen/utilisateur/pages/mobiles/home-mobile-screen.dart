import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/bloc/utilisateur/posts-digiteaux.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/footer-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-choix-de-la-redeaction-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-contribution-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-economique-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-edition-du-jour.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-essentiel-du-jour.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-investigations-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-politique-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-post-commercial.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-category-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-une-centrale-mobile.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-bar.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-mobile.dart';
import 'package:actu/screen/utilisateur/widget/menu/top-bar-menu.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/articles/mobile/section-mobile/section-actualite-mobile.dart';
import '../../widget/articles/mobile/section-mobile/section-video-mobile.dart';

class HomeMobileScreen extends StatelessWidget {
  const HomeMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    Size size = MediaQuery.of(context).size;
    final postsDigiteauxUserBloc = Provider.of<PostsDigiteauxUserBloc>(context);

    return Scaffold(
        backgroundColor: gris,
        appBar: AppBar(
          elevation: .0,
          toolbarHeight: .0,
        ),
        body: homeUtilisateurBloc.articleUnes.isEmpty
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
                                ),
                              ),
                        const SectionUneCentraleMobile(),
                        const SectionActualiteMobile(),
                        const SectionEditionDuJour(),
                        const SectionPolitiqueMobile(),
                        const SectionContributionMobile(),
                        postsDigiteauxUserBloc.listePosts.isEmpty
                            ? const SizedBox()
                            : SectionPostCommercialDuJour(
                          post: postsDigiteauxUserBloc.listePosts
                              .lastWhere((e) => e.type == "commercial" && e.statusOnline=="on"),
                        ),
                        const SectionInvestigationMobile(),
                        const SectionEconomiqueMobile(),
                          postsDigiteauxUserBloc.listePosts.isEmpty
                            ? const SizedBox()
                            : SectionEssentielDuJour(
                                posts: postsDigiteauxUserBloc.listePosts
                                    .where((e) => e.type == "essentiel" && e.statusOnline =="on")
                                    .toList()),
                        const SectionChoixDeLaRedactionMobile(),
                        const SectionVideoMobile(),
                        SectionCategoryMobile(
                          articles: homeUtilisateurBloc.articleSport,
                          title: 'Sport',
                          icon: CupertinoIcons.sportscourt,
                          primaryColor: Color(0xFFE31E24),
                        ),
                        SectionCategoryMobile(
                          articles: homeUtilisateurBloc.articleCultures,
                          title: 'Culture & Art',
                          icon: CupertinoIcons.paintbrush,
                          primaryColor: Color(0xFF9C27B0),
                        ),
                        SectionCategoryMobile(
                          articles: homeUtilisateurBloc.articleAfriques,
                          title: 'Afrique',
                          icon: CupertinoIcons.globe,
                          primaryColor: Color(0xFF00BCD4),
                        ),
                        SectionCategoryMobile(
                          articles: homeUtilisateurBloc.articleInternationals,
                          title: 'International',
                          icon: CupertinoIcons.airplane,
                          primaryColor: Color(0xFF2196F3),
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
              ));
  }
}
