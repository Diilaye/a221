import 'package:actu/screen/utilisateur/widget/articles/article-section-secondaire.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-section-top.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionArticlePrincipal extends StatelessWidget {
  final int numberArticle;
  final String titre;
  final Color color;
  final bool withEmission;
  const SectionArticlePrincipal(
      {super.key,
      required this.numberArticle,
      required this.titre,
      required this.color,
      this.withEmission = true});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 25,
                  child: Text(
                    titre.toUpperCase(),
                    style: fontFammilyDii(
                        context, 24, color, FontWeight.bold, FontStyle.normal),
                  ),
                ),

                const Spacer(),
                // Container(
                //   height: 25,
                //   color: noir,
                //   child: Row(
                //     children: [
                //       paddingHorizontalGlobal(8),
                //       Text(
                //         'voir +'.toUpperCase(),
                //         style: TextStyle(
                //             fontSize: 12,
                //             color: blanc,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       paddingHorizontalGlobal(8),
                //     ],
                //   ),
                // ),
                paddingHorizontalGlobal(32),
                Container(
                  height: 25,
                  width: 20,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: noir.withOpacity(.3), width: .5)),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.chevron_left,
                      size: 12,
                      color: noir.withOpacity(.3),
                    ),
                  ),
                ),
                paddingHorizontalGlobal(8),
                Container(
                  height: 25,
                  width: 20,
                  decoration:
                      BoxDecoration(border: Border.all(color: noir, width: .5)),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.chevron_right,
                      size: 12,
                    ),
                  ),
                ),
                paddingHorizontalGlobal(),
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
                paddingHorizontalGlobal(),
              ],
            ),
            paddingVerticalGlobal(8),
            Expanded(
                child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        const ArticleSectionTopWidget(),
                      ],
                    )),
                paddingHorizontalGlobal(8),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: List.generate(
                          numberArticle,
                          (index) => index == (numberArticle - 1)
                              ? const Expanded(
                                  child: Column(
                                    children: [
                                      ArticleSectionSecondaire(),
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: Column(
                                    children: [
                                      const ArticleSectionSecondaire(),
                                      paddingVerticalGlobal(8),
                                    ],
                                  ),
                                )).toList(),
                    )),
                paddingHorizontalGlobal(8),
              ],
            ))
          ],
        ));
  }
}
