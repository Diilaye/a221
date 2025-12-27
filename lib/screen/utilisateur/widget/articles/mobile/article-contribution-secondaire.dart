import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArticlecontributionSecondaire extends StatelessWidget {
  final ArticlesModel article;
  const ArticlecontributionSecondaire({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return GestureDetector(
      onTap: () {
        homeUtilisateurBloc.setAticle(article);
        js.context.callMethod(
            'open', ['https://a221.net/article/${article.slug!}', '_self']);
      },
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1f4068),
              Color(0xFF1a3555),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFFe94560).withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icône gauche
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFe94560), Color(0xFFd63447)],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe94560).withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(
                CupertinoIcons.doc_text_fill,
                color: blanc,
                size: 20,
              ),
            ),
            
            SizedBox(width: 14),
            
            // Contenu
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Catégorie
                  if (article.tags?.titre != null)
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Color(0xFFe94560),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          article.tags!.titre!.toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFe94560),
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 6),
                  
                  // Titre
                  Text(
                    article.titre!,
                    style: fontFammilyDii(
                        context, 15, blanc, FontWeight.w700, FontStyle.normal),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            SizedBox(width: 10),
            
            // Flèche droite
            Icon(
              CupertinoIcons.chevron_right,
              color: Color(0xFFe94560),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
