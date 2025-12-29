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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: noir,
            ),
            child: Row(
              children: [
                // Badge "EXCLUSIF"
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFFffd93d),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'EXCLUSIF',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: noir,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(width: 14),
                
                // Icône et titre
                Icon(
                  CupertinoIcons.search_circle_fill,
                  color: Color(0xFFffd93d),
                  size: 20,
                ),
                SizedBox(width: 12),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RÉVÉLATION',
                        style: fontFammilyDii(
                            context, 20, Color(0xFFffd93d), FontWeight.w800, FontStyle.normal),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Enquêtes & investigations',
                        style: TextStyle(
                          fontSize: 10,
                          color: blanc.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          // Sous-titre avec ligne
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: noir.withOpacity(0.2),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'NOS ENQUÊTES',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: noir,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: noir.withOpacity(0.2),
                  ),
                  ),
                
              ],
            ),
          ),
          
  
        ],
      ),
    );
  }
}
