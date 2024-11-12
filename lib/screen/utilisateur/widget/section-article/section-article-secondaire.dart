import 'package:actu/screen/utilisateur/widget/articles/article-section-secondaire.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-section-top-secondaire-colum.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionArticleSecondaire extends StatelessWidget {
  final String title;
  final int nombreArticle;
  final Color color;
  const SectionArticleSecondaire(
      {super.key,
      required this.title,
      required this.nombreArticle,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: blanc, boxShadow: [
                BoxShadow(blurRadius: 5, color: noir.withOpacity(.8))
              ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: 25,
                        child: Center(
                          child: Text(
                            title.toUpperCase(),
                            style: fontFammilyDii(context, 24, color,
                                FontWeight.bold, FontStyle.normal),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  paddingVerticalGlobal(8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          color: noir.withOpacity(.2),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                color: color,
                              )),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    color: noir.withOpacity(.2),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      flex: nombreArticle <= 2 ? 3 : 1,
                      child: ArticleSectionTopSecondaireColumWidget(
                        color: color,
                      )),
                  Expanded(
                      flex: nombreArticle <= 2 ? 2 : 1,
                      child: Column(
                        children: List.generate(
                            nombreArticle,
                            (index) => index == (nombreArticle - 1)
                                ? const Expanded(
                                    child: Column(
                                      children: [
                                        const ArticleSectionSecondaire(
                                          noShadow: true,
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Column(
                                      children: [
                                        const ArticleSectionSecondaire(
                                          noShadow: true,
                                        ),
                                        paddingVerticalGlobal(8),
                                      ],
                                    ),
                                  )).toList(),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
