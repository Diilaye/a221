import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/une-centrale-mobile.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/une-centrale-secondaire.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
// import 'package:actu/utils/widgets/htm-to-string-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class SectionUneCentraleMobile extends StatelessWidget {
  const SectionUneCentraleMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    return Column(
      children: [
        Container(
          height: 45,
          color: noir,
          child: Row(
            children: [
              paddingHorizontalGlobal(12),
              Text(
                'À LA UNE'.toUpperCase(),
                style: fontFammilyDii(
                    context, 22, blanc, FontWeight.bold, FontStyle.normal),
              ),
            ],
          ),
        ),
        paddingVerticalGlobal(4),
        const UneCentraleMobile(),
        paddingVerticalGlobal(),
        Row(
          children: [
            const Spacer(),
            Icon(
              Icons.arrow_forward,
              color: rouge,
            ),
            paddingHorizontalGlobal(),
          ],
        ),
        Container(
          height: 200,
          color: blanc,
          child: Row(
            children: [
              paddingHorizontalGlobal(8),
              Expanded(
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeUtilisateurBloc.articleUnes.length  ,
                itemBuilder: (context , i) => homeUtilisateurBloc.articleUnes[i].id !=homeUtilisateurBloc.uneArticleMobile!.id! ?  Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: UneCentraleSecondaire(
                    article: homeUtilisateurBloc.articleUnes[i],
                    index: i,
                  ),
                ) :const  SizedBox()),

        ),
              paddingHorizontalGlobal(8),
            ],
          ),
        ),
        paddingVerticalGlobal(),
        Container(
          height: 1,
          color: noir,
        ),
      ],
    );
  }
}
