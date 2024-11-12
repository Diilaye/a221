import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/article-politique-secondaire.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/une-article-politique.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionPolitiqueMobile extends StatelessWidget {
  const SectionPolitiqueMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Column(
      children: [
        Container(
          height: 45,
          color: blanc,
          child: Row(
            children: [
              paddingHorizontalGlobal(),
              Text(
                'Politique'.toUpperCase(),
                style: fontFammilyDii(
                    context, 22, rouge, FontWeight.bold, FontStyle.normal),
              ),
            ],
          ),
        ),
        UneArticlePolitique(
          article: homeUtilisateurBloc.unePolitique!,
        ),
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
        SizedBox(
          height: 200,
          child: Row(
            children: [
              paddingHorizontalGlobal(8),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: homeUtilisateurBloc.articlePolitiques
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ArticlePolitiqueSecondaireMobile(
                              article: e,
                            ),
                          ))
                      .toList(),
                ),
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
