import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/article-contribution-secondaire.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class SectionContributionMobile extends StatelessWidget {
  const SectionContributionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1a1a2e),
            Color(0xFF16213e),
            Color(0xFF0f3460),
          ],
        ),
      ),
      child: Column(
        children: [
          // Header premium avec icône et sous-titre
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFe94560).withOpacity(0.3),
                  width: 2,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFe94560).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        CupertinoIcons.pencil_circle_fill,
                        color: Color(0xFFe94560),
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CONTRIBUTION & ANALYSE',
                          style: fontFammilyDii(
                              context, 20, Color(0xFFe94560), FontWeight.w900, FontStyle.normal),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Analyses approfondies',
                          style: TextStyle(
                            fontSize: 12,
                            color: blanc.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: 20),
          
          // Article principal premium
          GestureDetector(
            onTap: () {
              homeUtilisateurBloc
                  .setAticle(homeUtilisateurBloc.articleContributions.first);
              js.context.callMethod('open', [
                'https://a221.net/article/${homeUtilisateurBloc.articleContributions.first.slug!}',
                '_self'
              ]);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFF1f4068),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 30,
                    offset: Offset(0, 15),
                  ),
                ],
                border: Border.all(
                  color: Color(0xFFe94560).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image avec overlay spécial
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    child: Stack(
                      children: [
                        (homeUtilisateurBloc.articleContributions.first.imageArticle?.url != null)
                            ? Image.network(
                                BASE_URL_ASSET +
                                    homeUtilisateurBloc.articleContributions.first.imageArticle!.url!,
                                height: 220,
                                width: size.width,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                height: 220,
                                color: Color(0xFF162447),
                                child: Icon(
                                  CupertinoIcons.photo,
                                  size: 60,
                                  color: blanc.withOpacity(0.3),
                                ),
                              ),
                        // Overlay gradient unique
                        Container(
                          height: 220,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Color(0xFF1f4068).withOpacity(0.9),
                              ],
                              stops: [0.5, 1.0],
                            ),
                          ),
                        ),
                        // Badge "ANALYSE" en haut
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFe94560), Color(0xFFd63447)],
                              ),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFe94560).withOpacity(0.5),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  CupertinoIcons.eye_fill,
                                  color: blanc,
                                  size: 14,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'ANALYSE',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: blanc,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Contenu premium
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Catégorie avec icône
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.tag_fill,
                              color: Color(0xFFe94560),
                              size: 14,
                            ),
                            SizedBox(width: 6),
                            Text(
                              homeUtilisateurBloc.articleContributions.first.tags?.titre?.toUpperCase() ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFe94560),
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        
                        // Titre
                        Text(
                          homeUtilisateurBloc.articleContributions.first.titre!,
                          style: fontFammilyDii(
                              context, 19, blanc, FontWeight.w900, FontStyle.normal),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Bouton "Lire l'analyse" premium
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFe94560), Color(0xFFd63447)],
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFe94560).withOpacity(0.4),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Lire l\'analyse',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: blanc,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                CupertinoIcons.arrow_right,
                                color: blanc,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 28),
          
          // Titre des autres analyses
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.square_grid_2x2_fill,
                  color: Color(0xFFe94560),
                  size: 18,
                ),
                SizedBox(width: 10),
                Text(
                  'AUTRES ANALYSES',
                  style: fontFammilyDii(
                      context, 16, blanc, FontWeight.w800, FontStyle.normal),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16),
          
          // Articles secondaires en liste
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: homeUtilisateurBloc.articleContributions
                  .sublist(1, 6)
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ArticlecontributionSecondaire(
                          article: e,
                        ),
                      ))
                  .toList(),
            ),
          ),
          
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
