import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/bloc/utilisateur/posts-digiteaux.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/footer-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-afrique-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-choix-de-la-redeaction-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-contribution-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-culture-art-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-economique-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-edition-du-jour.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-essentiel-du-jour.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-international-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-investigations-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-politique-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-post-commercial.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-sport-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/section-mobile/section-une-centrale-mobile.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-bar.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-mobile.dart';
import 'package:actu/screen/utilisateur/widget/menu/top-bar-menu.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:actu/utils/yWebUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                        const SectionPolitiqueMobile(),
                        const SectionEditionDuJour(),
                        const SectionEconomiqueMobile(),
                        const SectionInvestigationMobile(),
                        postsDigiteauxUserBloc.listePosts.isEmpty
                            ? const SizedBox()
                            : SectionEssentielDuJour(
                                posts: postsDigiteauxUserBloc.listePosts
                                    .where((e) => e.type == "essentiel" && e.statusOnline =="on")
                                    .toList()
                                    .reversed
                                    .toList()),

                        const SectionChoixDeLaRedactionMobile(),

                        const SectionContributionMobile(),
                       postsDigiteauxUserBloc.listePosts.isEmpty
                            ? const SizedBox()
                            : SectionPostCommercialDuJour(
                                post: postsDigiteauxUserBloc.listePosts
                                    .lastWhere((e) => e.type == "commercial" && e.statusOnline=="on"),
                              ),

                        if(homeUtilisateurBloc.videos.isNotEmpty) Container(
                          height: 350,
                          width: size.width,
                          color: bleuMarine,
                          child: Column(
                            children: [
                              paddingVerticalGlobal(),
                              Row(
                                children: [
                                 const Spacer(),
                                  Text('Vidéo',style: fontFammilyDii(
                                      context,
                                      24,
                                      blanc,
                                      FontWeight.bold,
                                      FontStyle.normal), ),
                                  const Spacer(),
                                ],
                              ),
                              Container(
                                height: 300,
                                width: size.width,
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

                        const SectionSportMobile(),
                         const SectionCultureArtMobile(),
                        const SectionAfriqueMobile(),
                        const SectionInternationalMobile(),
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
