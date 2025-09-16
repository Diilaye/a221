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

class ArticleLesPlusLueUneWidget extends StatelessWidget {
  final ArticlesModel? article;
  const ArticleLesPlusLueUneWidget({super.key, this.article = null});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Expanded(
        flex: 2,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  homeUtilisateurBloc.setAticle(article!);
                  js.context.callMethod('open',
                      ['https://a221.net/article/${article!.slug!}', '_self']);
                },
                child: SizedBox(
                  child: (article?.imageArticle?.url != null && article?.imageArticle?.url != '' )
                    ? Image.network(BASE_URL_ASSET + article!.imageArticle!.url!, height: 300, width: 500, fit: BoxFit.cover)
                    : Image.network('https://cdn.vectorstock.com/i/500p/81/79/no-photo-icon-default-placeholder-vector-41468179.jpg', height: 300, width: 500, fit: BoxFit.cover),
                ),
              )),
              paddingHorizontalGlobal(8),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  paddingVerticalGlobal(0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.go('/tag/${article!.tags!.slug!}');
                        },
                        child: Container(
                          height: 30,
                          color: blanc,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(6),

                              Text(
                                article!.tags!.titre!,
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
                              paddingHorizontalGlobal(6),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(6),
                  GestureDetector(
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
                        return  { 'fontSize': '16px', 'text-align': 'justify' , 'line-height': '1.5','word-wrap': 'break-word', 'font-weigth':'bolder'};
                      },
                      textStyle: TextStyle(fontSize: 16, color: blanc),
                    ) ,
                  ),
                  paddingVerticalGlobal(4),
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
                        extractFirstTwoSentences(
                            article!.description!, 1),
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
                          return  { 'fontSize': '12px', 'text-align': 'justify' , 'line-height': '1.5','word-wrap': 'break-word'};
                        },
                        textStyle: TextStyle(fontSize: 12, color: blanc),
                      ),
                    ),
                  ),
                  paddingVerticalGlobal(6),

                ],
              )),
              paddingHorizontalGlobal(8),
            ],
          ),
        ));
  }
}
