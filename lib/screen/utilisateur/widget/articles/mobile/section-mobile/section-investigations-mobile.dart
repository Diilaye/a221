import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/article-investigation.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionInvestigationMobile extends StatelessWidget {
  const SectionInvestigationMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFffd93d),
            Color(0xFFffb830),
            Color(0xFFf9a825),
          ],
        ),
      ),
      child: Column(
        children: [
          // Header style investigation
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: noir,
              boxShadow: [
                BoxShadow(
                  color: noir.withOpacity(0.3),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                // Badge "EXCLUSIF"
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFffd93d), Color(0xFFffb830)],
                    ),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFffd93d).withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Text(
                    'EXCLUSIF',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: noir,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                
                // Icône et titre
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFffd93d).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    CupertinoIcons.search_circle_fill,
                    color: Color(0xFFffd93d),
                    size: 22,
                  ),
                ),
                SizedBox(width: 10),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RÉVÉLATION',
                        style: fontFammilyDii(
                            context, 22, Color(0xFFffd93d), FontWeight.w900, FontStyle.normal),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Enquêtes & investigations',
                        style: TextStyle(
                          fontSize: 11,
                          color: blanc.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 20),
          
          // Sous-titre avec ligne
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, noir.withOpacity(0.3)],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'NOS ENQUÊTES',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: noir,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [noir.withOpacity(0.3), Colors.transparent],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 20),
          
          // Scroll horizontal des articles
          SizedBox(
            height: 420,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: homeUtilisateurBloc.articleInvestigations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: ArtilceInvestiogationMobile(
                    article: homeUtilisateurBloc.articleInvestigations[index],
                  ),
                );
              },
            ),
          ),
          
          SizedBox(height: 24),
          
          // Footer avec icône
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.arrow_right_circle_fill,
                  color: noir,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  'Voir toutes nos enquêtes',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: noir,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
