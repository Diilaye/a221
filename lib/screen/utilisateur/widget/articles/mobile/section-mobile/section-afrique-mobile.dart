import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/screen/utilisateur/widget/articles/mobile/article-economique-secondaire.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class SectionAfriqueMobile extends StatelessWidget {
  const SectionAfriqueMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);

    return SizedBox(
      // height: 475,
      child: Column(
        children: [
          paddingVerticalGlobal(),
          Row(
            children: [
              paddingHorizontalGlobal(),
              Text(
                'Afrique'.toUpperCase(),
                style: fontFammilyDii(
                    context, 22, rouge, FontWeight.bold, FontStyle.normal),
              ),
            ],
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                homeUtilisateurBloc.setAticle(homeUtilisateurBloc.articleAfriques.first);
                js.context.callMethod('open', [
                  'https://a221.net/article/${homeUtilisateurBloc.articleAfriques.first.slug!}',
                  '_self'
                ]);
              },
              child: Card(
                elevation: 0,
                shadowColor: blanc,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2)),
                child: Column(
                  children: [
                    paddingVerticalGlobal(4),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: Image.network(
                        BASE_URL_ASSET +
                            homeUtilisateurBloc.articleAfriques.first.imageArticle!.url!,
                        height: 300,
                        width: size.width * .92,
                        fit: BoxFit.cover,
                      ),
                    ),
                    paddingVerticalGlobal(4),
                    Row(
                      children: [
                        paddingHorizontalGlobal(12),
                        Text(
                            homeUtilisateurBloc.articleAfriques.first.tags!.titre!
                                .toUpperCase(),
                            style: fontFammilyDii(context, 14, rouge,
                                FontWeight.bold, FontStyle.normal)),
                      ],
                    ),
                    paddingVerticalGlobal(4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Icon(Icons.article,
                                    size: 20.0, color: noir),
                              ),
                            ),
                            TextSpan(
                              text: homeUtilisateurBloc.articleAfriques.first.titre!,
                              style: fontFammilyDii(context, 20, noir,
                                  FontWeight.w500, FontStyle.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    paddingVerticalGlobal(),
                    Column(
                      children: homeUtilisateurBloc.articleAfriques
                          .sublist(1, 5)
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: ArticleEconomiqueSecondaire(
                                  article: e,
                                ),
                              ))
                          .toList(),
                    ),
                    paddingVerticalGlobal(),
                    Container(
                      height: 1,
                      color: noir,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
