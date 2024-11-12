import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/material.dart';
import 'package:actu/models/administrateur/article-model.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:actu/bloc/utilisateur/home-bloc.dart';

import 'dart:js' as js;

class ArticlePolitiqueSecondaireMobile extends StatelessWidget {
  final ArticlesModel article;
  const ArticlePolitiqueSecondaireMobile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: () {
              homeUtilisateurBloc.setAticle(article);
              js.context.callMethod('open',
                  ['https://a221.net/article/${article.slug!}', '_self']);
            },
            child: Column(
              children: [
                Image.network(
                  BASE_URL_ASSET + article.imageArticle!.url!,
                  height: 150,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child:
                                Icon(Icons.article, size: 20.0, color: rouge),
                          ),
                        ),
                        TextSpan(
                          text: article.titre!,
                          style: fontFammilyDii(context, 12, noir,
                              FontWeight.bold, FontStyle.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
