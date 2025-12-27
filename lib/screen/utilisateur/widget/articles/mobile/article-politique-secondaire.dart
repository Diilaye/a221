import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:provider/provider.dart';
import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'dart:js' as js;

class ArticlePolitiqueSecondaireMobile extends StatelessWidget {
  final ArticlesModel article;
  const ArticlePolitiqueSecondaireMobile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return GestureDetector(
      onTap: () {
        homeUtilisateurBloc.setAticle(article);
        js.context.callMethod('open',
            ['https://a221.net/article/${article.slug!}', '_self']);
      },
      child: Container(
        decoration: BoxDecoration(
          color: blanc,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image à gauche
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
              child: (article.imageArticle?.url != null && article.imageArticle!.url!.isNotEmpty)
                  ? Image.network(
                      BASE_URL_ASSET + article.imageArticle!.url!,
                      height: 110,
                      width: 110,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 110,
                      width: 110,
                      color: Colors.grey.shade300,
                      child: Icon(
                        CupertinoIcons.photo,
                        size: 40,
                        color: Colors.grey.shade400,
                      ),
                    ),
            ),
            
            // Contenu à droite
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge catégorie
                    if (article.tags?.titre != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: rouge.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: rouge.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          article.tags!.titre!.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: rouge,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    SizedBox(height: 8),
                    
                    // Titre
                    Text(
                      article.titre!,
                      style: fontFammilyDii(
                          context, 15, noir, FontWeight.w800, FontStyle.normal),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            
            // Flèche à droite
            Padding(
              padding: EdgeInsets.only(right: 12, top: 45),
              child: Icon(
                CupertinoIcons.chevron_right,
                color: rouge,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
