import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/une-centrale-mobile-modern.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/une-centrale-secondaire-modern.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionUneCentraleMobile extends StatelessWidget {
  const SectionUneCentraleMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;

    if (homeUtilisateurBloc.articleUnes.isEmpty || homeUtilisateurBloc.uneArticleMobile == null) {
      return SizedBox();
    }

    return Container(
      width: size.width,
      color: blanc,
      child: Column(
        children: [
          // Article principal moderne
          const UneCentraleMobileModern(),
          
          paddingVerticalGlobal(20),

          // Scroll horizontal des articles secondaires
          Container(
            height: 254,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: homeUtilisateurBloc.articleUnes.length,
              itemBuilder: (context, i) {
                if (homeUtilisateurBloc.articleUnes[i].id == homeUtilisateurBloc.uneArticleMobile!.id) {
                  return SizedBox();
                }
                return UneCentraleSecondaireModern(
                  article: homeUtilisateurBloc.articleUnes[i],
                );
              },
            ),
          ),

          paddingVerticalGlobal(16),

          // Séparateur
          Container(
            width: size.width * 0.94,
            height: 1,
            color: Colors.grey.shade300,
          ),

          paddingVerticalGlobal(16),
        ],
      ),
    );
  }
}
