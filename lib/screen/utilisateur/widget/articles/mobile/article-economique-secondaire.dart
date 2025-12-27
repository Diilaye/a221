import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:js' as js;

class ArticleEconomiqueSecondaire extends StatelessWidget {
  final ArticlesModel article;
  final Color color;
  const ArticleEconomiqueSecondaire({
    super.key,
    required this.article,
    this.color = const Color(0xff059669),
  });

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          homeUtilisateurBloc.setAticle(article);
          js.context.callMethod(
              'open', ['https://a221.net/article/${article.slug!}', '_self']);
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff0a4d3c).withOpacity(0.95),
                Color(0xff0d6e58).withOpacity(0.97),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Color(0xff10b981).withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: noir.withOpacity(.2),
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icône dans un cercle à gauche
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff10b981),
                      Color(0xff059669),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff10b981).withOpacity(0.4),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Icon(
                  CupertinoIcons.chart_bar_square_fill,
                  color: blanc,
                  size: 22,
                ),
              ),
              SizedBox(width: 14),
              
              // Contenu
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge catégorie
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xff10b981).withOpacity(0.25),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Color(0xff10b981).withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        article.tags!.titre!.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: fontFammilyDii(
                          context,
                          11,
                          Color(0xff10b981),
                          FontWeight.w800,
                          FontStyle.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    
                    // Titre
                    Text(
                      article.titre!,
                      style: fontFammilyDii(
                        context,
                        16,
                        blanc,
                        FontWeight.w700,
                        FontStyle.normal,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: 10),
              
              // Chevron à droite
              Padding(
                padding: EdgeInsets.only(top: 18),
                child: Icon(
                  CupertinoIcons.chevron_right,
                  color: Color(0xff10b981),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
