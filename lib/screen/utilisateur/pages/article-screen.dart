import 'package:actu/bloc/utilisateur/emission-user-bloc.dart';
import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/pages/mobiles/article-mobile-page.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-bloc-multi-widget-Article.dart';
import 'package:actu/screen/utilisateur/widget/emissions/article-top-bar.dart';
import 'package:actu/screen/utilisateur/widget/emissions/emission-top-bar.dart';
import 'package:actu/screen/utilisateur/widget/footer/section-footer.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-bar.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-rubrique.dart';
import 'package:actu/screen/utilisateur/widget/menu/top-bar-menu.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/date-showing-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/htm-to-string-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../bloc/administrateur/post-digiteaux-bloc.dart';
import '../widget/menu/exit-menu-rubrique.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    final emissionUserBloc = Provider.of<EmissionUserBloc>(context);
    final postsDigiteauxBloc = Provider.of<PostsDigiteauxBloc>(context);

    return homeUtilisateurBloc.articleSlug == null
        ? const SizedBox()
        : deviceName(size) == ScreenType.Mobile
            ? const ArticlMobileScreen()
            : Scaffold(
                backgroundColor: gris,
                appBar: AppBar(
                  toolbarHeight: .0,
                  elevation: 0,
                ),
                body: Stack(
                  children: [
                    Container(
                      color: blanc,
                    ),
                    Positioned(
                        child: Container(
                      color: gris,
                      height: size.height,
                      width: size.width,
                      child: ListView(
                        children: [
                          paddingVerticalGlobal(220),
                          Center(
                            child: Container(
                              width: 1024,
                              color: blanc,
                              child: Column(
                                children: [
                                  if(postsDigiteauxBloc.posts.isNotEmpty)  Center(
                                    child: SizedBox(
                                      height: 200,
                                      width: 1024,
                                      child:Image.network(BASE_URL_ASSET+postsDigiteauxBloc.posts.where((e) => e.statusOnline =="on" && e.type =="article-top").first.image!.url! ,fit: BoxFit.fill,),
                                    ),
                                  ),
                                  paddingVerticalGlobal(),

                                  Row(
                                    children: [
                                      paddingHorizontalGlobal(),
                                      Text(
                                        homeUtilisateurBloc
                                            .articleSlug!.tags!.titre!
                                            .toUpperCase(),
                                        style: fontFammilyDii(
                                            context,
                                            24,
                                            rouge,
                                            FontWeight.w500,
                                            FontStyle.normal),
                                      ),
                                    ],
                                  ),
                                  paddingVerticalGlobal(8),
                                  Row(
                                    children: [
                                      paddingHorizontalGlobal(),
                                      Expanded(
                                        child: Text(
                                          homeUtilisateurBloc
                                              .articleSlug!.titre!,
                                          style: fontFammilyDii(
                                              context,
                                              28,
                                              noir,
                                              FontWeight.w400,
                                              FontStyle.normal),
                                        ),
                                      ),
                                      paddingHorizontalGlobal(),
                                    ],
                                  ),
                                  // paddingVerticalGlobal(8),
                                  // Row(
                                  //   children: [
                                  //     paddingHorizontalGlobal(),
                                  //     Expanded(
                                  //       child: HtmlWidget(
                                  //         extractFirstTwoSentences(
                                  //             homeUtilisateurBloc
                                  //                 .articleSlug!.description!,
                                  //             1),
                                  //         textStyle: fontFammilyDii(
                                  //             context,
                                  //             20,
                                  //             noir,
                                  //             FontWeight.w400,
                                  //             FontStyle.normal),
                                  //       ),
                                  //     ),
                                  //     paddingHorizontalGlobal(),
                                  //   ],
                                  // ),

                                  paddingVerticalGlobal(8),
                                  Row(
                                    children: [
                                      paddingHorizontalGlobal(),
                                      Expanded(
                                          child: Text(
                                        "Par ${homeUtilisateurBloc.articleSlug!.author!.prenom} ${homeUtilisateurBloc.articleSlug!.author!.nom}, Le ${showDate(homeUtilisateurBloc.articleSlug!.date!)}",
                                        style: fontFammilyDii(context, 12, noir,
                                            FontWeight.w400, FontStyle.normal),
                                      )),
                                      paddingHorizontalGlobal(),
                                    ],
                                  ),
                                  paddingVerticalGlobal(),
                                  SizedBox(
                                    // height: 500,
                                    width: 1024,
                                    child: Row(
                                      children: [
                                        paddingHorizontalGlobal(),
                                        Container(
                                          // height: 500,
                                          width: 650,
                                          child: Image.network(
                                            BASE_URL_ASSET +
                                                homeUtilisateurBloc.articleSlug!
                                                    .imageArticle!.url!,
                                            // height: 500,
                                            width: 650,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        paddingHorizontalGlobal(8),
                                        if(postsDigiteauxBloc.posts.isNotEmpty)  Container(
                                          height: 500,
                                          width: 320,
                                          child: Image.network(BASE_URL_ASSET+postsDigiteauxBloc.posts.where((e) => e.statusOnline =="on" && e.type =="article-right").first.image!.url! , fit: BoxFit.fill,),
                                        ),
                                        paddingHorizontalGlobal(),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      paddingHorizontalGlobal(),
                                      Expanded(
                                        child: HtmlWidget(
                                          homeUtilisateurBloc
                                              .articleSlug!.description!,
                                          customStylesBuilder: (element) {
                                            if (element.classes.contains('ql-size-large')) {
                                              return {
                                                'font-size': '32px',
                                                'font-weight': 'bold',
                                                'color': 'rgb(192, 57, 43)',
                                              };
                                            }
                                            if (element.classes.contains('ql-align-center')) {
                                              return {
                                                'text-align': 'center',
                                              };
                                            }
                                            if (element.classes.contains('ql-align-justify')) {
                                              return {
                                                'text-align': 'justify',
                                              };
                                            }
                                            return  { 'fontSize': '16px', 'text-align': 'justify' , 'line-height': '1.5','word-wrap': 'break-word'};
                                          },
                                          textStyle: TextStyle(fontSize: 16, color: Colors.black),

                                        ),
                                      ),
                                      paddingHorizontalGlobal(),
                                    ],
                                  ),
                                  paddingVerticalGlobal(),
                                  Row(
                                    children: [
                                      paddingHorizontalGlobal(),
                                      GestureDetector(
                                          onTap: () async {
                                            print(
                                                'https://a221.net/article/${homeUtilisateurBloc.articleSlug!.slug!}');
                                            final result = await Share.shareXFiles(
                                                [],
                                                text:
                                                    "https://a221.net/article/${homeUtilisateurBloc.articleSlug!.slug!}");

                                            if (result.status ==
                                                ShareResultStatus.success) {
                                              print(
                                                  'Thank you for sharing my website!');
                                            }
                                            print(
                                                'Thank you for sharing my website!');
                                            // final url = Uri.parse(
                                            //     BASE_URL_ASSET +
                                            //         homeUtilisateurBloc
                                            //             .articleSlug!
                                            //             .imageArticle!
                                            //             .url!);
                                            // final response =
                                            //     await http.get(url);

                                            // final temp =
                                            //     await getTemporaryDirectory();
                                            // final path =
                                            //     '${temp.path}/image.jpg';
                                            // File f = File(path);
                                            // f.writeAsBytesSync(
                                            //     response.bodyBytes);
                                            // XFile file = new XFile(f.path);
                                            // await Share.shareXFiles(
                                            //   [file],
                                            //   text: 'Great picture',
                                            // );

                                            // final http.Response responseData =
                                            //     await http.get(Uri.parse(
                                            //         BASE_URL_ASSET +
                                            //             homeUtilisateurBloc
                                            //                 .articleSlug!
                                            //                 .imageArticle!
                                            //                 .url!));

                                            // Uint8List bytes =
                                            //     responseData.bodyBytes;

                                            // var file = XFile.fromData(bytes,
                                            //     mimeType: 'image/png',
                                            //     name: "MyPic.png");

                                            // await Share.shareXFiles([file],
                                            //     text: 'Hello',
                                            //     subject:
                                            //         'Check out this image');

                                            // final result = await Share.share(
                                            //     'check out my website https://example.com');

                                            // if (result.status ==
                                            //     ShareResultStatus.success) {
                                            //   print(
                                            //       'Thank you for sharing my website!');
                                            // }
                                          },
                                          child: Text("Partage l'article"
                                              .toUpperCase()))
                                    ],
                                  ),
                                  paddingVerticalGlobal(),
                                ],
                              ),
                            ),
                          ),

                          paddingVerticalGlobal(),
                          Center(
                            child: Container(
                              color: blanc,
                              width: 1024,
                              child: Column(
                                children: [
                                  paddingVerticalGlobal(),
                                  Row(
                                    children: [
                                      paddingHorizontalGlobal(),
                                      Text(
                                        'Les articles simillaires'
                                            .toUpperCase(),
                                        style: fontFammilyDii(context, 16, noir,
                                            FontWeight.bold, FontStyle.normal),
                                      )
                                    ],
                                  ),
                                  paddingVerticalGlobal(),
                                  if(homeUtilisateurBloc.articles.isNotEmpty)  SizedBox(
                                    height: 300,
                                    child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: homeUtilisateurBloc.articles
                                            .where((el) =>
                                                (el.tags!.id! ==
                                                    homeUtilisateurBloc
                                                        .articleSlug!
                                                        .tags!
                                                        .id) &&
                                                el.id! !=
                                                    homeUtilisateurBloc
                                                        .articleSlug!.id!)
                                            .map((e) => Row(
                                                  children: [
                                                    paddingHorizontalGlobal(),
                                                    ArticleScreenMultiWidget(
                                                      article: e,
                                                    ),
                                                    paddingHorizontalGlobal()
                                                  ],
                                                ))
                                            .toList()),
                                  ),
                                  paddingVerticalGlobal(),
                                ],
                              ),
                            ),
                          ),
                          paddingVerticalGlobal(),
                          const SectionFooter(),
                          paddingVerticalGlobal(2),
                        ],
                      ),
                    )),
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
