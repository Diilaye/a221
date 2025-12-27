import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/article-politique-secondaire.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/une-article-politique.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionPolitiqueMobile extends StatelessWidget {
  const SectionPolitiqueMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Container(
      color: Colors.grey.shade50,
      child: Column(
        children: [
          // Header moderne style magazine
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: blanc,
              border: Border(
                bottom: BorderSide(color: rouge, width: 3),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [rouge, rouge.withOpacity(0.8)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    CupertinoIcons.building_2_fill,
                    color: blanc,
                    size: 24,
                  ),
                ),
                SizedBox(width: 14),
                Text(
                  'POLITIQUE',
                  style: fontFammilyDii(
                      context, 26, rouge, FontWeight.w900, FontStyle.normal),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: rouge.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'À LA UNE',
                    style: fontFammilyDii(
                        context, 11, rouge, FontWeight.w800, FontStyle.normal),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          
          // Article principal
          UneArticlePolitique(
            article: homeUtilisateurBloc.unePolitique!,
          ),
          
          SizedBox(height: 24),
          
          // Titre des articles secondaires
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: rouge,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'AUTRES ARTICLES POLITIQUE',
                  style: fontFammilyDii(
                      context, 16, noir, FontWeight.w800, FontStyle.normal),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16),
          
          // Articles secondaires en liste verticale
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: homeUtilisateurBloc.articlePolitiques
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: ArticlePolitiqueSecondaireMobile(
                          article: e,
                        ),
                      ))
                  .toList(),
            ),
          ),
          
          SizedBox(height: 24),
          
          // Séparateur
          Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
