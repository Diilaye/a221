import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/htm-to-string-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class ArticleBlocMultiTextWidget extends StatelessWidget {
  final ArticlesModel? article;
  const ArticleBlocMultiTextWidget({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: 100,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              homeUtilisateurBloc.setAticle(article!);
              js.context.callMethod('open',
                  ['https://a221.net/article/${article!.slug!}', '_self']);
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                children: [
                  paddingVerticalGlobal(4),
                  Row(
                    children: [
                      paddingHorizontalGlobal(8),
                      Expanded(
                        child: Text(article!.titre!,
                            style: fontFammilyDii(
                                context,
                               12
                                    ,
                                noir,
                                FontWeight.bold,
                                FontStyle.normal)),
                      ),
                      paddingHorizontalGlobal(8),
                    ],
                  ),
                  paddingVerticalGlobal(4),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          return  { 'fontSize': '10px', 'text-align': 'justify' , 'line-height': '1.5','word-wrap': 'break-word'};
                        },
                        textStyle: TextStyle(fontSize: 10, color: noir),
                      ),
                    ),
                  ),
                  paddingVerticalGlobal(4),
                ],
              ),
            ),
          ),
        ));
  }
}
