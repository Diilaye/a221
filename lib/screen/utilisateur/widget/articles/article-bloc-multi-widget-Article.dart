import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/responsive-ui.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ArticleScreenMultiWidget extends StatelessWidget {
  final double card;
  final ArticlesModel? article;
  const ArticleScreenMultiWidget(
      {super.key, this.card = 0, required this.article});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 250,
      width: deviceName(size) == ScreenType.Mobile
          ? size.width * .8
          : size.width * .25,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            homeUtilisateurBloc.setAticle(homeUtilisateurBloc.articles
                .lastWhere((e) => e.id! == article!.id!));
            context.go('/article/${article!.slug!}');
          },
          child: Stack(
            children: [
              Image.network(
                BASE_URL_ASSET + article!.imageArticle!.url!,
                height: 250,
                width: deviceName(size) == ScreenType.Mobile
                    ? size.width * .8
                    : size.width * .25,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 150,
                child: Row(
                  children: [
                    paddingHorizontalGlobal(0),
                    Container(
                      color: rouge,
                      height: 30,
                      child: Row(
                        children: [
                          paddingHorizontalGlobal(6),
                          Text(article!.tags!.titre!,
                              style: fontFammilyDii(context, 14, blanc,
                                  FontWeight.bold, FontStyle.normal)),
                          paddingHorizontalGlobal(6),
                        ],
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    height: 70,
                    width: deviceName(size) == ScreenType.Mobile
                        ? size.width * .8
                        : size.width * .25,
                    color: noir.withOpacity(.5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(article!.titre!,
                              overflow: TextOverflow.fade,
                              style: fontFammilyDii(context, 14, blanc,
                                  FontWeight.w600, FontStyle.normal)),
                        ),
                        paddingHorizontalGlobal(),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
