import 'package:actu/screen/utilisateur/widget/articles/article-section-secondaire-without-bg.dart';
import 'package:actu/screen/utilisateur/widget/articles/article-section-top-secondaire-row.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionArticleWithBG extends StatelessWidget {
  final String title;
  final String tag;
  final Color bg;
  final Color colorT;
  final Color color;
  const SectionArticleWithBG(
      {super.key,
      required this.title,
      this.bg = const Color(0xff1F2024),
      this.colorT = const Color(0xff00A950),
      this.color = const Color.fromARGB(255, 255, 255, 255),
      required this.tag});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Container(
          color: bg,
          child: Column(
            children: [
              paddingVerticalGlobal(8),
              Row(
                children: [
                  paddingHorizontalGlobal(4),
                  SizedBox(
                    height: 25,
                    child: Text(
                      title.toUpperCase(),
                      style: TextStyle(
                          fontSize: 16,
                          color: colorT,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 25,
                    color: colorT,
                    child: Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Text(
                          'voir +'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 12,
                              color: noir,
                              fontWeight: FontWeight.bold),
                        ),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                  ),
                  paddingHorizontalGlobal(32),
                  Container(
                    height: 25,
                    width: 20,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: colorT.withOpacity(.3), width: .5)),
                    child: Center(
                      child: Icon(
                        CupertinoIcons.chevron_left,
                        size: 12,
                        color: colorT.withOpacity(.3),
                      ),
                    ),
                  ),
                  paddingHorizontalGlobal(8),
                  Container(
                    height: 25,
                    width: 20,
                    decoration: BoxDecoration(
                        border: Border.all(color: colorT, width: .5)),
                    child: Center(
                      child: Icon(
                        CupertinoIcons.chevron_right,
                        size: 12,
                        color: colorT,
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
                    child: SizedBox(
                      height: 2,
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            color: colorT,
                          )),
                          Expanded(
                              flex: 4,
                              child: Container(
                                color: Colors.grey,
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
                  child: Column(
                children: [
                  ArticleSectionTopSecondaireRowWidget(
                    colorT: colorT,
                    color: color,
                    tag: tag,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      paddingVerticalGlobal(8),
                      Expanded(
                          child: Row(
                        children: [
                          paddingVerticalGlobal(8),
                          ArticleSectionSecondaireWithoutBG(
                            color: color,
                          ),
                          paddingVerticalGlobal(8),
                          ArticleSectionSecondaireWithoutBG(
                            color: color,
                          ),
                        ],
                      )),
                      paddingVerticalGlobal(8),
                      Expanded(
                          child: Row(
                        children: [
                          paddingVerticalGlobal(8),
                          ArticleSectionSecondaireWithoutBG(
                            color: color,
                          ),
                          paddingVerticalGlobal(8),
                          ArticleSectionSecondaireWithoutBG(
                            color: color,
                          ),
                        ],
                      )),
                    ],
                  )),
                ],
              ))
            ],
          ),
        ));
  }
}
