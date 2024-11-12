import 'package:actu/screen/utilisateur/widget/articles/article-images-block.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SectionImageFull extends StatelessWidget {
  final String title;
  const SectionImageFull({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      color: rouge,
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
                      fontSize: 16, color: blanc, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              paddingHorizontalGlobal(32),
              Container(
                height: 25,
                width: 20,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: blanc.withOpacity(.3), width: .5)),
                child: Center(
                  child: Icon(
                    CupertinoIcons.chevron_left,
                    size: 12,
                    color: blanc.withOpacity(.3),
                  ),
                ),
              ),
              paddingHorizontalGlobal(8),
              Container(
                height: 25,
                width: 20,
                decoration:
                    BoxDecoration(border: Border.all(color: blanc, width: .5)),
                child: Center(
                  child: Icon(
                    CupertinoIcons.chevron_right,
                    size: 12,
                    color: blanc,
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
                      paddingHorizontalGlobal(4),
                      Expanded(
                          child: Container(
                        color: blanc,
                      )),
                      Expanded(
                          flex: 4,
                          child: Container(
                            color: blanc,
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
              paddingHorizontalGlobal(4),
              const Expanded(
                  child: Column(
                children: [
                  ArticleImageBlock(
                      tagS: "à la une",
                      img: "assets/images/imagea1.jpeg",
                      desc:
                          "La Basketteuse, Sokhna Bintou Lo recouvre la nationalité sportive sénégalaise La Basketteuse, Sokhna Bintou Lo recouvre la nationalité sportive sénégalaise ")
                ],
              )),
              paddingHorizontalGlobal(8),
              Expanded(
                  child: Column(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      ArticleImageBlock(
                          tagS: "Sports",
                          tag: false,
                          img: "assets/images/imagea5.jpeg",
                          size: 10,
                          desc:
                              "La Basketteuse, Sokhna Bintou Lo recouvre la nationalité sportive sénégalaise "),
                      paddingHorizontalGlobal(8),
                      ArticleImageBlock(
                          tagS: "Sports",
                          tag: false,
                          img: "assets/images/imagea4.jpeg",
                          size: 10,
                          desc:
                              "La Basketteuse, Sokhna Bintou Lo recouvre la nationalité sportive sénégalaise "),
                    ],
                  )),
                  paddingVerticalGlobal(8),
                  Expanded(
                      child: Row(
                    children: [
                      ArticleImageBlock(
                          tagS: "Sports",
                          tag: false,
                          img: "assets/images/imagea3.jpeg",
                          size: 10,
                          desc:
                              "La Basketteuse, Sokhna Bintou Lo recouvre la nationalité sportive sénégalaise "),
                      paddingHorizontalGlobal(8),
                      ArticleImageBlock(
                          tagS: "Sports",
                          tag: false,
                          img: "assets/images/imagea2.jpeg",
                          size: 10,
                          desc:
                              "La Basketteuse, Sokhna Bintou Lo recouvre la nationalité sportive sénégalaise "),
                    ],
                  )),
                ],
              )),
              paddingHorizontalGlobal(4),
            ],
          )),
          paddingVerticalGlobal(8),
        ],
      ),
    );
  }
}
