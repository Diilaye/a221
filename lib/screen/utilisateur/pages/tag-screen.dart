import 'package:actu/bloc/utilisateur/emission-user-bloc.dart';
import 'package:actu/bloc/utilisateur/flash-news-bloc.dart';
import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/pages/mobiles/categorie-mobile-screen.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-bloc-multi-widget.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-les-plus-lue.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-tag-bloc-multi-widget.dart';
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

import '../../../bloc/administrateur/post-digiteaux-bloc.dart';
import '../../../utils/requette-by-dii.dart';

class TagHomeScreen extends StatelessWidget {
  const TagHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    final flashNewsUserBloc = Provider.of<FlashNewsUserBloc>(context);
    final postsDigiteauxBloc = Provider.of<PostsDigiteauxBloc>(context);
    final emissionUserBloc = Provider.of<EmissionUserBloc>(context);

    return deviceName(size) == ScreenType.Mobile
        ? const CategorieMobileScreen()
        : Scaffold(
            appBar: AppBar(
              elevation: .0,
              toolbarHeight: .0,
              backgroundColor: blanc,
            ),
            body: homeUtilisateurBloc.tagMenuModel == null
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
                            if(postsDigiteauxBloc.posts.isNotEmpty)  Center(
                              child: SizedBox(
                                height: 200,
                                width: 1024,
                                child: Image.network(BASE_URL_ASSET+postsDigiteauxBloc.posts.where((e) => e.statusOnline =="on" && e.type =="article-top").first.image!.url! ,fit: BoxFit.fill,),
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
                                                .tagMenuModel!.tag!.titre!
                                                .toUpperCase(),
                                            style: fontFammilyDii(
                                                context,
                                                24,
                                                noir,
                                                FontWeight.w600,
                                                FontStyle.normal),
                                          ),
                                        ],
                                      ),
                                      paddingVerticalGlobal(),
                                      Container(
                                        height: 2,
                                        decoration: BoxDecoration(
                                            color: bleuMarine,
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                      ),
                                      paddingVerticalGlobal(),
                                      GridView.count(
                                        crossAxisCount: 3,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: homeUtilisateurBloc
                                            .tagMenuModel!.articles!
                                            .map(
                                              (e) => ArticleTagBlocMultiWidget(
                                                article: e,
                                              ),
                                            )
                                            .toList(),
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
