import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/utilisateur/categorie-menu-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class ArticleCategorieMobile extends StatelessWidget {
  final Articles article;
  const ArticleCategorieMobile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return SizedBox(
      height: 200,
      width: 210,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            homeUtilisateurBloc.setAticle(homeUtilisateurBloc.articles
                .lastWhere((e) => e.id! == article.id!));
            js.context.callMethod(
                'open', ['https://a221.net/article/${article.slug!}', '_self']);
          },
          child: Column(
            children: [
              (article.imageArticle?.url != null && article.imageArticle!.url!.isNotEmpty)
                ? Image.network(
                    BASE_URL_ASSET + article.imageArticle!.url!,
                    height: 150,
                    width: 180,
                    fit: BoxFit.fill,
                  )
                : Image.network(
                    'https://cdn.vectorstock.com/i/500p/81/79/no-photo-icon-default-placeholder-vector-41468179.jpg',
                    height: 150,
                    width: 180,
                    fit: BoxFit.fill,
                  ),
              SizedBox(
                width: 180,
                height: 50,
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Icon(Icons.article, size: 20.0, color: rouge),
                        ),
                      ),
                      TextSpan(
                        text: article.titre!,
                        style: fontFammilyDii(
                            context, 12, noir, FontWeight.bold, FontStyle.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
