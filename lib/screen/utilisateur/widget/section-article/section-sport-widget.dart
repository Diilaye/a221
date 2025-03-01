import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-bloc-multi-home-widget.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-bloc-multi-text-widget.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionMultiWidget extends StatelessWidget {
  final String title;
  final List<ArticlesModel> article ;
  const SectionMultiWidget({super.key, required this.title, required this.article});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: 244,
        height: 650,
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
                  18,
                  noir,
                  FontWeight.bold,
                  FontStyle.normal),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward,
              size: 10,
              color: rouge,
            ),
            paddingHorizontalGlobal()
          ],
        ),
        ArticleBlocMultiHomeWidget(
          article: article[0],
        ),
        ArticleBlocMultiTextWidget(
          article: article[1],
        ),
        ArticleBlocMultiTextWidget(
          article: article[2],
        ),
        ArticleBlocMultiTextWidget(
          article: article[3],
        ),
        paddingVerticalGlobal(32),
      ],
    ));
  }
}
