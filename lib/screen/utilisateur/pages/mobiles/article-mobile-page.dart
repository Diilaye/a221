import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-bloc-multi-widget-Article.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/footer-mobile.dart';
import 'package:actu/screen/utilisateur/widget/menu/menu-mobile.dart';
import 'package:actu/screen/utilisateur/widget/menu/top-bar-menu.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/htm-to-string-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ArticlMobileScreen extends StatelessWidget {
  const ArticlMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
            color: blanc,
            height: size.height,
            width: size.width,
            child: ListView(
              children: [
                paddingVerticalGlobal(60),
                Center(
                  child: Container(
                    width: size.width,
                    color: blanc,
                    child: Column(
                      children: [
                        paddingVerticalGlobal(),
                        Row(
                          children: [
                            paddingHorizontalGlobal(),
                            Text(
                              homeUtilisateurBloc.articleSlug!.tags!.titre!
                                  .toUpperCase(),
                              style: fontFammilyDii(context, 16, rouge,
                                  FontWeight.w500, FontStyle.normal),
                            ),
                          ],
                        ),
                        paddingVerticalGlobal(8),
                        Row(
                          children: [
                            paddingHorizontalGlobal(),
                            Expanded(
                              child: Text(
                                homeUtilisateurBloc.articleSlug!.titre!,
                                style: fontFammilyDii(context, 28, noir,
                                    FontWeight.w400, FontStyle.normal),
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
                        //         textStyle: fontFammilyDii(context, 16, noir,
                        //             FontWeight.w400, FontStyle.normal),
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
                              "Par ${homeUtilisateurBloc.articleSlug!.author!.prenom} ${homeUtilisateurBloc.articleSlug!.author!.nom}",
                              style: fontFammilyDii(context, 12, noir,
                                  FontWeight.w400, FontStyle.normal),
                            )),
                            paddingHorizontalGlobal(),
                          ],
                        ),
                        paddingVerticalGlobal(),
                        SizedBox(
                          // height: 500,
                          width: size.width,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(),
                              Container(
                                // height: 500,
                                width: (size.width) - 32,
                                child: Image.network(
                                  BASE_URL_ASSET +
                                      homeUtilisateurBloc
                                          .articleSlug!.imageArticle!.url!,
                                  // height: 500,
                                  width: (size.width) - 32,
                                  fit: BoxFit.contain,
                                ),
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
                                homeUtilisateurBloc.articleSlug!.description!,
                                textStyle: fontFammilyDii(context, 14, noir,
                                    FontWeight.w400, FontStyle.normal),
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
                                      'https://jeunespace.com/article/${homeUtilisateurBloc.articleSlug!.slug!}');
                                  final result = await Share.share(
                                      "https://a221.net/article/${homeUtilisateurBloc.articleSlug!.slug!}");

                                  if (result.status ==
                                      ShareResultStatus.success) {
                                    print('Thank you for sharing my website!');
                                  }
                                  print('Thank you for sharing my website!');
                                },
                                child: Text("Partage l'article".toUpperCase()))
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
                    height: 200,
                    color: jaune,
                    width: size.width,
                    child: Center(
                      child: Text('Espace Pub'),
                    ),
                  ),
                ),
                paddingVerticalGlobal(),
                Center(
                  child: Container(
                    color: blanc,
                    width: size.width * .95,
                    child: Column(
                      children: [
                        paddingVerticalGlobal(),
                        Row(
                          children: [
                            paddingHorizontalGlobal(),
                            Text(
                              'Les articles simillaires'.toUpperCase(),
                              style: fontFammilyDii(context, 16, noir,
                                  FontWeight.bold, FontStyle.normal),
                            )
                          ],
                        ),
                        paddingVerticalGlobal(),
                        SizedBox(
                          height: 300,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: homeUtilisateurBloc.articles
                                  .where((el) =>
                                      (el.categorie!.id! ==
                                          homeUtilisateurBloc
                                              .articleSlug!.categorie!.id) &&
                                      el.id! !=
                                          homeUtilisateurBloc.articleSlug!.id!)
                                  .map((e) => Row(
                                        children: [
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
                const FooterMobile(),
              ],
            ),
          )),
          if (homeUtilisateurBloc.showMenuMobile == 1)
            const Positioned(top: 60, child: MenuMobile()),
          const Positioned(child: TopBarMenu()),
        ],
      ),
    );
  }
}
