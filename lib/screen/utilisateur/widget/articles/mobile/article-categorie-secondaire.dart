import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/utilisateur/categorie-menu-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArticleCategorieSecondaire extends StatelessWidget {
  final Articles article;
  const ArticleCategorieSecondaire({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          homeUtilisateurBloc.setAticle(homeUtilisateurBloc.articles
              .lastWhere((e) => e.id! == article.id!));
          js.context.callMethod(
              'open', ['https://a221.net/article/${article.slug!}', '_self']);
        },
        child: Card(
          elevation: 0,
          child: Container(
            // height: 90,
            width: size.width,
            decoration: BoxDecoration(color: blanc, boxShadow: [
              BoxShadow(blurRadius: 1, color: noir.withOpacity(.5))
            ]),
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
                        style: fontFammilyDii(context, 16, rouge,
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
                            padding: EdgeInsets.only(right: 4.0),
                            child:
                                Icon(Icons.article, size: 20.0, color: rouge),
                          ),
                        ),
                        TextSpan(
                          text: article.titre!,
                          style: fontFammilyDii(context, 16, noir,
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
