import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArticleTopBarWidget extends StatelessWidget {
  final ArticlesModel articlesModel;
  const ArticleTopBarWidget({super.key, required this.articlesModel});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Expanded(
        child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          homeUtilisateurBloc.setAticle(articlesModel);
          js.context.callMethod('open',
              ['https://a221.net/article/${articlesModel.slug!}', '_self']);
        },
        child: Container(
          decoration: BoxDecoration(color: blanc, boxShadow: [
            BoxShadow(blurRadius: 10, color: noir.withOpacity(1))
          ]),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      Container(
                        height: 1000,
                        width: 1000,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(BASE_URL_ASSET +
                                    articlesModel.imageArticle!.url!),
                                fit: BoxFit.contain)),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Container(
                        height: 15,
                        color: rouge,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              articlesModel.tags!.titre!.toUpperCase(),
                              style: fontFammilyDii(context, 10, blanc,
                                  FontWeight.bold, FontStyle.normal),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            paddingVerticalGlobal(4),
                            Expanded(
                              child: Row(
                                children: [
                                  paddingHorizontalGlobal(4),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        articlesModel.titre!.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                        style: fontFammilyDii(
                                            context,
                                            10.5,
                                            noir,
                                            FontWeight.w700,
                                            FontStyle.normal),
                                      ),
                                    ),
                                  ),
                                  paddingHorizontalGlobal(4),
                                ],
                              ),
                            ),
                            paddingVerticalGlobal(4),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 15,
                            color: noir,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'à lire'.toUpperCase(),
                                  style: fontFammilyDii(context, 12, blanc,
                                      FontWeight.bold, FontStyle.normal),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
