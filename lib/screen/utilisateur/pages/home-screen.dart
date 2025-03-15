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
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:actu/utils/yWebUtils.dart';
import 'package:flutter/cupertino.dart';
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
                    Center(
                      child: Container(
                        height: size.height,
                        width: 1024,
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
                                width: 1024,
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
                            paddingVerticalGlobal(4),
                            SectionUneWidget(),
                            paddingVerticalGlobal(8),
                            Center(
                              child: SizedBox(
                                height: 500,
                                width: 1024,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        homeUtilisateurBloc.articleActualites.isNotEmpty
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
                                  ],
                                ),
                              ),
                            ),
                            paddingVerticalGlobal(32),
                            const SectionPolitiqueWidget(),
                            paddingVerticalGlobal(32),
                            const SectionContributionWidget(),
                            paddingVerticalGlobal(32),
                            const SectionInvestigationtWidget(),
                            paddingVerticalGlobal(32),
                            const SectionEconomiqueWidget(),
                            paddingVerticalGlobal(32),
                            postsDigiteauxUserBloc.listePosts.isEmpty
                                ? SizedBox()
                                : SectionEtientielJourWidget(
                                    posts: postsDigiteauxUserBloc.listePosts
                                        .where((e) => e.type == "essentiel" && e.statusOnline =="on")
                                        .toList()
                                        .reversed
                                        .toList(),
                                  ),
                            paddingVerticalGlobal(32),
                            const SectionChoixRedacWidget(),
                            paddingVerticalGlobal(32),
                           if(homeUtilisateurBloc.videos.isNotEmpty) Container(
                              height: 350,
                              width: 1024,
                              color: bleuMarine,
                              child: Column(
                                children: [
                                  paddingVerticalGlobal(),
                                  Row(
                                    children: [
                                      paddingHorizontalGlobal(),
                                      Text('Vidéo',style: fontFammilyDii(
                                      context,
                                      24,
                                      blanc,
                                      FontWeight.bold,
                                      FontStyle.normal), ),
                                      const Spacer(),
                                      Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          border: Border.all(color: blanc  , width: .5)
                                        ),
                                        child: Center(
                                          child: Icon(CupertinoIcons.arrow_left , color: blanc, size: 12,),
                                        ),
                                      ),
                                      paddingHorizontalGlobal(8),
                                      Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            border: Border.all(color: blanc  , width: .5)
                                        ),
                                        child: Center(
                                          child: Icon(CupertinoIcons.arrow_right , color: blanc, size: 12,),
                                        ),
                                      ),
                                      paddingHorizontalGlobal(),
                                    ],
                                  ),
                                  paddingVerticalGlobal(4),
                                  Container(
                                    height: 294,
                                    width: 1024,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: homeUtilisateurBloc.videos.where((e) => e.statusOnline == "on" && e.isLive =="off" ).map((el) => Row(
                                        children: [
                                          paddingHorizontalGlobal(8),
                                          GestureDetector(
                                            onTap: () => showDialog(
                                              context: context,
                                              builder: (c) {
                                                return AlertDialog(
                                                  backgroundColor: noir,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(0.0))),
                                                  contentPadding: EdgeInsets.only(top: 0.0),
                                                  title: Text(el.titre!, style: fontFammilyDii(context, 24, blanc, FontWeight.w400, FontStyle.normal),),
                                                  content:YoutubeHtmlWidget(urlY: el.url!,),
                                                );
                                              }
                                            ),
                                            child: Container(
                                              width: 325,
                                              height: 294,
                                              child: Stack(
                                                children: [
                                                  Image.network(BASE_URL_ASSET+el.imageFile!.url! , height: 190,width: 325, fit: BoxFit.fill,),
                                                  Positioned(
                                                      top: 85,
                                                      left: 140,
                                                      child: Icon(Icons.play_circle_fill_outlined , color: blanc, size: 45,)),
                                                  Positioned(
                                                      top: 190,
                                                      child: SizedBox(
                                                        width: 325,
                                                        height: 89,
                                                        child: Column(
                                                          children: [
                                                            paddingVerticalGlobal(8),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                    width: 325,
                                                                    child: Text(el.emission!  , style: fontFammilyDii(context, 16, rouge, FontWeight.w600, FontStyle.normal),)),
                                                              ],
                                                            ),
                                                            paddingVerticalGlobal(4),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                    width: 325,
                                                                    child: Text(el.titre!, style: fontFammilyDii(context, 14, blanc, FontWeight.w400, FontStyle.normal),)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )).toList(),
                                    ),
                                  ),
                                  paddingVerticalGlobal(4),

                                ],
                              ),
                            ),
                            paddingVerticalGlobal(32),
                            Container(
                              height: 650,
                              width: 1024,
                              child: Row(
                                children: [
                                if(homeUtilisateurBloc.articleSport.isNotEmpty)  SectionMultiWidget(title: "Sport" , article: homeUtilisateurBloc.articleSport,),
                                  paddingHorizontalGlobal(),
                                  if(homeUtilisateurBloc.articleCultures.isNotEmpty)   SectionMultiWidget(title: "CULTURE & ART" , article: homeUtilisateurBloc.articleCultures,),
                                  paddingHorizontalGlobal(),
                                  if(homeUtilisateurBloc.articleAfriques.isNotEmpty) SectionMultiWidget(title: "Afrique" , article: homeUtilisateurBloc.articleAfriques,),
                                  paddingHorizontalGlobal(),
                                  if(homeUtilisateurBloc.articleInternationals.isNotEmpty) SectionMultiWidget(title: "International" , article: homeUtilisateurBloc.articleInternationals,),

                                ],
                              ),
                            ),
                            const SectionFooter(),
                            paddingVerticalGlobal(46)
                          ],
                        ),
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
                        left: (size.width - 1024) / 2,
                        right: (size.width - 1024) / 2,
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
                        )),
                   Positioned(
                        top: 20,
                       left: (size.width - 1024) / 2,
                       right: (size.width - 1024) / 2,
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
                        bottom: 0, // Place le widget en bas de l'écran
                        left: (size.width - 1024) / 2,
                        right: (size.width - 1024) / 2, // Permet d'étendre sur toute la largeur
                        child: SizedBox(
                          height: 45,
                          width: 1024,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 45,
                                  color: noir,
                                  child: flashNewsUserBloc.flashNews.isEmpty
                                      ? CircularProgressIndicator()
                                      : FlashNewsWidget(
                                    flashNews: flashNewsUserBloc.flashNews,
                                    havespace: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    if(homeUtilisateurBloc.showLiveYoutube) Positioned(
                      top: 70,
                      left: (size.width - 1024) / 2,
                      right: (size.width - 1024) / 2,
                      child: Container(
                        color: noir,
                          width: 1024,
                          child: Center(

                              child: SizedBox(
                                  width: 1024,
                                  child: YoutubeHtmlWidget(urlY: homeUtilisateurBloc.videos.where((e) => e.isLive == "on").first.url!)))),)
                  ],
                ),
              );
  }
}
