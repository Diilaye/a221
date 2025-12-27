import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class UneArticlePolitique extends StatelessWidget {
  final ArticlesModel article;
  const UneArticlePolitique({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return GestureDetector(
      onTap: () {
        homeUtilisateurBloc.setAticle(article);
        js.context.callMethod(
            'open', ['https://a221.net/article/${article.slug!}', '_self']);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: blanc,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: noir.withOpacity(0.15),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image avec overlay et badge
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                children: [
                  (article.imageArticle?.url != null && article.imageArticle!.url!.isNotEmpty)
                      ? Image.network(
                          BASE_URL_ASSET + article.imageArticle!.url!,
                          height: 280,
                          width: size.width,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 280,
                          width: size.width,
                          color: Colors.grey.shade300,
                          child: Icon(
                            CupertinoIcons.photo,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                        ),
                  // Gradient overlay léger
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          noir.withOpacity(0.4),
                        ],
                        stops: [0.6, 1.0],
                      ),
                    ),
                  ),
                  // Badge POLITIQUE en haut à droite
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: blanc,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: noir.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.building_2_fill,
                            color: rouge,
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'POLITIQUE',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: rouge,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Contenu textuel
            Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Catégorie/tag
                  if (article.tags?.titre != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: rouge.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        article.tags!.titre!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: rouge,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  SizedBox(height: 14),
                  
                  // Titre
                  Text(
                    article.titre!,
                    style: fontFammilyDii(
                        context, 20, noir, FontWeight.w900, FontStyle.normal),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  SizedBox(height: 14),
                  
                  // Bouton lire l'article
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.arrow_right_circle_fill,
                        color: rouge,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Lire l\'article complet',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: rouge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
