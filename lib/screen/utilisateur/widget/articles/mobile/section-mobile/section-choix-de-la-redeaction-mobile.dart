import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/article-avenir-secondaire.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/une-article-avenir.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionChoixDeLaRedactionMobile extends StatelessWidget {
  const SectionChoixDeLaRedactionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff1e3a5f), // Bleu marine profond
            Color(0xff2c5282), // Bleu marine
            Color(0xff2b6cb0), // Bleu professionnel
          ],
        ),
      ),
      child: Column(
        children: [
          // Header moderne avec icône
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Icône avec effet glow
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff06b6d4), // Cyan
                            Color(0xff0891b2), // Cyan foncé
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff06b6d4).withOpacity(0.4),
                            blurRadius: 16,
                            spreadRadius: 2,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Icon(
                        CupertinoIcons.clock_fill,
                        color: blanc,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'À VENIR',
                            style: fontFammilyDii(
                              context,
                              24,
                              blanc,
                              FontWeight.w900,
                              FontStyle.normal,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Choix de la rédaction',
                            style: fontFammilyDii(
                              context,
                              14,
                              Color(0xff06b6d4),
                              FontWeight.w600,
                              FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Article principal
          UneArticleAvenir(
            article: homeUtilisateurBloc.articleChoixRedac[0],
          ),

          // Séparateur avec texte
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Color(0xff06b6d4).withOpacity(0.5),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        'PROCHAINEMENT',
                        style: fontFammilyDii(
                          context,
                          12,
                          Color(0xff06b6d4),
                          FontWeight.w800,
                          FontStyle.normal,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        CupertinoIcons.arrow_right,
                        color: Color(0xff06b6d4),
                        size: 16,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff06b6d4).withOpacity(0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Articles secondaires en scroll horizontal
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemCount: homeUtilisateurBloc.articleChoixRedac.length - 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: ArticleAvenirSecondaire(
                    article: homeUtilisateurBloc.articleChoixRedac[index + 1],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
