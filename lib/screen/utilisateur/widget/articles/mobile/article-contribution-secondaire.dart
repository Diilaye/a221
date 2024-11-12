import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class ArticlecontributionSecondaire extends StatelessWidget {
  final ArticlesModel article;
  const ArticlecontributionSecondaire({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            homeUtilisateurBloc.setAticle(article);
            js.context.callMethod(
                'open', ['https://a221.net/article/${article.slug!}', '_self']);
          },
          child: Card(
            elevation: 0,
            color: noir,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        article.tags!.titre!,
                        overflow: TextOverflow.ellipsis,
                        style: fontFammilyDii(context, 16, blanc,
                            FontWeight.w600, FontStyle.normal),
                      ),
                    ],
                  ),
                  paddingVerticalGlobal(4),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child:
                                Icon(Icons.article, size: 20.0, color: blanc),
                          ),
                        ),
                        TextSpan(
                          text: article.titre!,
                          style: fontFammilyDii(context, 16, blanc,
                              FontWeight.w500, FontStyle.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
