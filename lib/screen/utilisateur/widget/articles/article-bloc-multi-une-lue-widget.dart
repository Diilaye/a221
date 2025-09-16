import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/htm-to-string-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArticleBlocMultiUneLueWidget extends StatelessWidget {
  final double card;
  final Color color;
  final ArticlesModel? article;
  const ArticleBlocMultiUneLueWidget(
      {super.key,
      this.card = 0,
      this.color = Colors.black,
      this.article = null});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Expanded(
        flex: 4,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Card(
            elevation: card,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        homeUtilisateurBloc.setAticle(article!);
                        js.context.callMethod('open', [
                          'https://a221.net/article/${article!.slug!}',
                          '_self'
                        ]);
                      },
                      child: (article?.imageArticle?.url != null && article?.imageArticle?.url != '')
                        ? Image.network(
                            BASE_URL_ASSET + article!.imageArticle!.url!,
                            fit: BoxFit.fill,
                            height: 300,
                            width: 300,
                          )
                        : Image.network(
                            'https://cdn.vectorstock.com/i/500p/81/79/no-photo-icon-default-placeholder-vector-41468179.jpg',
                            fit: BoxFit.fill,
                            height: 300,
                            width: 300,
                          ),
                    )),
                Expanded(
                  child: Column(
                    children: [
                      paddingVerticalGlobal(4),
                      Row(
                        children: [
                          paddingHorizontalGlobal(8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.go('/tag/${article!.tags!.slug!}');
                              },
                              child: Text(article!.tags!.titre!,
                                  style: fontFammilyDii(
                                      context,
                                      12,
                                      color,
                                      FontWeight.bold,
                                      FontStyle.normal)),
                            ),
                          ),
                          paddingHorizontalGlobal(8),
                        ],
                      ),
                      paddingVerticalGlobal(4),
                      Row(
                        children: [
                          paddingHorizontalGlobal(8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                homeUtilisateurBloc.setAticle(article!);
                                js.context.callMethod('open', [
                                  'https://a221.net/article/${article!.slug!}',
                                  '_self'
                                ]);
                              },
                              child: HtmlWidget(
                                article!.titre!,
                                customStylesBuilder: (element) {

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
                                  return  { 'fontSize': '12px', 'text-align': 'justify' , 'line-height': '1.5','word-wrap': 'break-word', 'font-weigth':'700'};
                                },
                                textStyle: TextStyle(fontSize: 12, color: noir),
                              ) ,


                            ),
                          ),
                          paddingHorizontalGlobal(8),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
