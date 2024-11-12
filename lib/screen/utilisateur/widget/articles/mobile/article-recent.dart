import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/article-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ArticleRecentWidget extends StatelessWidget {
  final ArticlesModel article;
  const ArticleRecentWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            homeUtilisateurBloc.setAticle(article);
            context.go('/article/${article.slug!}');
          },
          child: Card(
            elevation: 0,
            child: Container(
              // height: 90,
              width: size.width,
              decoration: BoxDecoration(
                color: blanc,
                //  boxShadow: [
                //   BoxShadow(blurRadius: 1, color: noir.withOpacity(.5))
                // ]
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
                child: Column(
                  children: [
                    paddingVerticalGlobal(8),
                    Row(
                      children: [
                        Text(
                          article.tags!.titre!,
                          overflow: TextOverflow.ellipsis,
                          style: fontFammilyDii(context, 16, rouge,
                              FontWeight.w600, FontStyle.normal),
                        ),
                      ],
                    ),
                    paddingVerticalGlobal(4),
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child:
                                  Icon(Icons.article, size: 20.0, color: noir),
                            ),
                          ),
                          TextSpan(
                            text: article.titre!,
                            style: fontFammilyDii(context, 14, noir,
                                FontWeight.w400, FontStyle.normal),
                          ),
                        ],
                      ),
                    ),
                    paddingVerticalGlobal(8),
                    Container(
                      height: .5,
                      color: noir,
                    ),
                    paddingVerticalGlobal(8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
