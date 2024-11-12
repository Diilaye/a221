import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/utilisateur/tag-menu-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ArticleTagBlocMultiWidget extends StatelessWidget {
  final double card;
  final Articles? article;
  const ArticleTagBlocMultiWidget(
      {super.key, this.card = 0, this.article = null});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          homeUtilisateurBloc.setAticle(homeUtilisateurBloc.articles
              .lastWhere((e) => e.id! == article!.id!));
          js.context.callMethod(
              'open', ['https://a221.net/article/${article!.slug!}', '_self']);
        },
        child: Stack(
          children: [
            Card(
              elevation: card,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.network(
                      BASE_URL_ASSET + article!.image!.url!,
                      height: 200,
                      width: 500,
                      fit: BoxFit.fill,
                    ),
                  ),
                  paddingVerticalGlobal(2),
                  Container(
                    color: rouge,
                    height: 30,
                    child: Row(
                      children: [
                        paddingHorizontalGlobal(6),
                        Text(article!.tags!.titre!,
                            overflow: TextOverflow.ellipsis,
                            style: fontFammilyDii(context, 14, blanc,
                                FontWeight.bold, FontStyle.normal)),
                        paddingHorizontalGlobal(6),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        paddingVerticalGlobal(4),
                        paddingVerticalGlobal(4),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Text(article!.titre!,
                                overflow: TextOverflow.fade,
                                style: fontFammilyDii(context, 12, noir,
                                    FontWeight.w300, FontStyle.normal)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  paddingVerticalGlobal(4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
