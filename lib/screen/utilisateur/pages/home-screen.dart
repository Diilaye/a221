import 'package:actu/bloc/utilisateur/emission-user-bloc.dart';
import 'package:actu/bloc/utilisateur/flash-news-bloc.dart';
import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/bloc/utilisateur/papier-journal-bloc.dart';
import 'package:actu/bloc/utilisateur/posts-digiteaux.dart';
import 'package:actu/screen/utilisateur/pages/mobiles/home-mobile-screen.dart';
import 'package:actu/screen/utilisateur/widget/emissions/article-top-bar.dart';
import 'package:actu/screen/utilisateur/widget/emissions/emission-top-bar.dart';
import 'package:actu/screen/utilisateur/widget/flash-info/flash-news-widget.dart';
import 'package:actu/screen/utilisateur/widget/footer/section-footer.dart';
import 'package:actu/screen/utilisateur/widget/menu/exit-menu-rubrique.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-bar.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-rubrique.dart';
import 'package:actu/screen/utilisateur/widget/menu/top-bar-menu.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-actualite-widget.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-choix-redec.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-contribution-widget.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-economique-widget.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-edition-widget.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-etientiel-jour.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-investigation-widget.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-politique-widget.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-sport-widget.dart';
import 'package:actu/screen/utilisateur/widget/section-article/section-une-widget.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeUtilisateurScreen extends StatelessWidget {
  const HomeUtilisateurScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    final flashNewsUserBloc = Provider.of<FlashNewsUserBloc>(context);
    final postsDigiteauxUserBloc = Provider.of<PostsDigiteauxUserBloc>(context);
    final papierJournalUserBloc = Provider.of<PapierJournalUserBloc>(context);
    final emissionUserBloc = Provider.of<EmissionUserBloc>(context);

    return deviceName(size) == ScreenType.Mobile
        ? const HomeMobileScreen()
        : homeUtilisateurBloc.articles.isEmpty
            ? const SizedBox()
            : Scaffold(
                backgroundColor: gris,
                appBar: AppBar(
                  elevation: .0,
                  toolbarHeight: .0,
                ),
                body: Stack(
                  children: [
                    Container(
                      color: blanc,
                    ),
                    Container(
                      height: size.height,
                      width: size.width,
                      color: blanc,
                      child: ListView(
                        controller: homeUtilisateurBloc.controllerListHome,
                        children: [
                          homeUtilisateurBloc.showMenu == 0
                              ? paddingVerticalGlobal(220)
                              : paddingVerticalGlobal(220),
                          Center(
                            child: SizedBox(
                              height: 45,
                              width: size.width * .8,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                          height: 45,
                                          color: noir,
                                          child: flashNewsUserBloc
                                                      .flashNews.length ==
                                                  0
                                              ? CircularProgressIndicator()
                                              : FlashNewsWidget(
                                                  flashNews: flashNewsUserBloc
                                                      .flashNews,
                                                  havespace: false,
                                                ))),
                                ],
                              ),
                            ),
                          ),
                          SectionUneWidget(),
                          paddingVerticalGlobal(8),
                          SizedBox(
                            height: 500,
                            width: size.width,
                            child: Row(
                              children: [
                                paddingHorizontalGlobal(size.width * .1),
                                Expanded(
                                    child: Row(
                                  children: [
                                    homeUtilisateurBloc.articles.isNotEmpty
                                        ? SectionActualiteWidget(
                                            articles: homeUtilisateurBloc
                                                .articleActualites,
                                          )
                                        : SizedBox(),
                                    papierJournalUserBloc.papierJournals.isEmpty
                                        ? SizedBox()
                                        : SectionEditionWidget(
                                            journalModel: papierJournalUserBloc
                                                .papierJournals.last,
                                          ),
                                  ],
                                )),
                                paddingHorizontalGlobal(size.width * .1),
                              ],
                            ),
                          ),
                          paddingVerticalGlobal(32),
                          const SectionPolitiqueWidget(),
                          const SectionEconomiqueWidget(),
                          const SectionInvestigationtWidget(),
                          postsDigiteauxUserBloc.listePosts.isEmpty
                              ? SizedBox()
                              : SectionEtientielJourWidget(
                                  posts: postsDigiteauxUserBloc.listePosts
                                      .where((e) => e.type == "essentiel")
                                      .toList()
                                      .reversed
                                      .toList(),
                                ),
                          const SectionChoixRedacWidget(),
                          paddingVerticalGlobal(32),
                          const SectionContributionWidget(),
                          paddingVerticalGlobal(32),
                          Container(
                            height: 700,
                            width: size.width,
                            child: Row(
                              children: [
                                paddingHorizontalGlobal(size.width * .1),
                                SectionMultiWidget(title: "Sport"),
                                paddingHorizontalGlobal(),
                                SectionMultiWidget(title: "CULTURE & ART"),
                                paddingHorizontalGlobal(),
                                SectionMultiWidget(title: "Afrique"),
                                paddingHorizontalGlobal(),
                                SectionMultiWidget(title: "International"),
                                paddingHorizontalGlobal(),
                                paddingHorizontalGlobal(size.width * .1),
                              ],
                            ),
                          ),
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
                        child: SizedBox(
                          height: 75,
                          width: size.width,
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width * .1,
                              ),
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
                              SizedBox(
                                width: size.width * .1,
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                        top: 20,
                        left: size.width * .1,
                        right: size.width * .1,
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
                    if (!homeUtilisateurBloc.showFlashInfo)
                      Positioned(
                        bottom: 0,
                        child: Container(
                            height: 45,
                            width: size.width,
                            color: noir,
                            child: flashNewsUserBloc.flashNews.length == 0
                                ? CircularProgressIndicator()
                                : FlashNewsWidget(
                                    flashNews: flashNewsUserBloc.flashNews,
                                  )),
                      ),
                  ],
                ),
              );
  }
}
