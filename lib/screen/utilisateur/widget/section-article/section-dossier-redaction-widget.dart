import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/htm-to-string-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class SectionDossierRedactionWidget extends StatelessWidget {
  final ArticlesModel? articles;
  const SectionDossierRedactionWidget({super.key, this.articles = null});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Expanded(
        flex: 1,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Column(
            children: [
              Expanded(
                  child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: blanc,
                        border: Border.all(color: noir, width: .5),
                        boxShadow: [BoxShadow(blurRadius: .5, color: noir)]),
                  ),
                  Positioned(
                      top: 1,
                      right: 1,
                      left: 1,
                      child: GestureDetector(
                        onTap: () {
                          homeUtilisateurBloc.setAticle(articles!);
                          js.context.callMethod('open', [
                            'https://a221.net/article/${articles!.slug!}',
                            '_self'
                          ]);
                        },
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(BASE_URL_ASSET +
                                      articles!.imageArticle!.url!),
                                  fit: BoxFit.fill)),
                        ),
                      )),
                  Positioned(
                      top: 175,
                      left: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          context.go('/tag/${articles!.tags!.slug!}');
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(color: blanc, boxShadow: [
                            BoxShadow(blurRadius: 1, color: noir)
                          ]),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  articles!.tags!.titre!.toUpperCase(),
                                  style: fontFammilyDii(
                                      context,
                                      size.width >= 1440
                                          ? 14
                                          : size.width >= 1024 &&
                                                  size.width < 1440
                                              ? 12
                                              : 10,
                                      rouge,
                                      FontWeight.bold,
                                      FontStyle.normal),
                                ),
                              ]),
                        ),
                      )),
                  Positioned(
                      top: 230,
                      left: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          homeUtilisateurBloc.setAticle(articles!);
                          js.context.callMethod('open', [
                            'https://a221.net/article/${articles!.slug!}',
                            '_self'
                          ]);
                        },
                        child: Column(
                          children: [
                            Text(articles!.titre!,
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.justify,
                                style: fontFammilyDii(
                                    context,
                                    size.width >= 1440
                                        ? 22
                                        : size.width >= 1024 &&
                                                size.width < 1440
                                            ? 14
                                            : 10,
                                    noir,
                                    FontWeight.bold,
                                    FontStyle.normal)),
                            paddingVerticalGlobal(8),
                            HtmlWidget(
                              extractFirstTwoSentences(
                                  articles!.description!, 1),
                              textStyle: TextStyle(color: noir, fontSize: 20),
                            ),
                            paddingVerticalGlobal(8),
                            // Center(
                            //   child: Container(
                            //     height: 25,
                            //     width: 150,
                            //     color: noir,
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         paddingHorizontalGlobal(8),
                            //         Text(
                            //           'lire la suite'.toUpperCase(),
                            //           style: fontFammilyDii(context, 12, blanc,
                            //               FontWeight.w300, FontStyle.normal),
                            //         ),
                            //         paddingHorizontalGlobal(8),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ))
                ],
              ))
            ],
          ),
        ));
  }
}
