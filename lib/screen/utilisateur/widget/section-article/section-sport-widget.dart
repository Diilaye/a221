import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-bloc-multi-home-widget.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-bloc-multi-text-widget.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionMultiWidget extends StatelessWidget {
  final String title;
  const SectionMultiWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;

    return Expanded(
        child: Column(
      children: [
        paddingVerticalGlobal(32),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '$title'.toUpperCase(),
              style: fontFammilyDii(
                  context,
                  size.width >= 1440
                      ? 18
                      : size.width >= 1024 && size.width < 1440
                          ? 14
                          : 10,
                  noir,
                  FontWeight.bold,
                  FontStyle.normal),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward,
              size: size.width >= 1440
                  ? 18
                  : size.width >= 1024 && size.width < 1440
                      ? 14
                      : 10,
              color: rouge,
            ),
            paddingHorizontalGlobal()
          ],
        ),
        paddingVerticalGlobal(),
        Expanded(
            child: Column(
          children: [
            ArticleBlocMultiHomeWidget(
              article: title == "Sport"
                  ? homeUtilisateurBloc.articleSport[0]
                  : title == "CULTURE & ART"
                      ? homeUtilisateurBloc.articleCultures[0]
                      : title == "Afrique"
                          ? homeUtilisateurBloc.articleAfriques[0]
                          : title == "International"
                              ? homeUtilisateurBloc.articleInternationals[0]
                              : null,
            ),
            ArticleBlocMultiTextWidget(
              article: title == "Sport"
                  ? homeUtilisateurBloc.articleSport[1]
                  : title == "CULTURE & ART"
                      ? homeUtilisateurBloc.articleCultures[1]
                      : title == "Afrique"
                          ? homeUtilisateurBloc.articleAfriques[1]
                          : title == "International"
                              ? homeUtilisateurBloc.articleInternationals[1]
                              : null,
            ),
            ArticleBlocMultiTextWidget(
              article: title == "Sport"
                  ? homeUtilisateurBloc.articleSport[2]
                  : title == "CULTURE & ART"
                      ? homeUtilisateurBloc.articleCultures[2]
                      : title == "Afrique"
                          ? homeUtilisateurBloc.articleAfriques[2]
                          : title == "International"
                              ? homeUtilisateurBloc.articleInternationals[2]
                              : null,
            ),
            ArticleBlocMultiTextWidget(
              article: title == "Sport"
                  ? homeUtilisateurBloc.articleSport[3]
                  : title == "CULTURE & ART"
                      ? homeUtilisateurBloc.articleCultures[3]
                      : title == "Afrique"
                          ? homeUtilisateurBloc.articleAfriques[3]
                          : title == "International"
                              ? homeUtilisateurBloc.articleInternationals[3]
                              : null,
            ),
          ],
        )),
        paddingVerticalGlobal(32),
      ],
    ));
  }
}
