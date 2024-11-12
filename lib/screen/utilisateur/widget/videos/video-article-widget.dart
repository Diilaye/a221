import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoArticleWidget extends StatelessWidget {
  const VideoArticleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: bleuMarine.withOpacity(.7),
                boxShadow: [
                  BoxShadow(color: noir.withOpacity(.5), blurRadius: .3)
                ]),
            child: Column(
              children: [
                Expanded(
                    child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/imagea1.jpeg"),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                        bottom: 5,
                        left: 5,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: rouge,
                              radius: 15,
                              child: Center(
                                child: Icon(
                                  CupertinoIcons.play_fill,
                                  color: blanc,
                                  size: 12,
                                ),
                              ),
                            ),
                          ],
                        )),
                    Positioned(
                      bottom: 10,
                      right: 5,
                      child: Container(
                        height: 20,
                        width: 40,
                        color: noir.withOpacity(.8),
                        child: Center(
                          child: Text(
                            "9:30",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: blanc),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
                Expanded(
                  child: Column(
                    children: [
                      paddingVerticalGlobal(),
                      Row(
                        children: [
                          paddingHorizontalGlobal(4),
                          Text(
                            "Sous rubrique 2".toUpperCase(),
                            style: fontFammilyDii(context, 14, blanc,
                                FontWeight.bold, FontStyle.normal),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            paddingHorizontalGlobal(4),
                            Expanded(
                              child: Text(
                                "C'EST CE QUE SONKO DEVRAIT FAIRE D'ABORD AVANT DE DEMANDER AUX ENTREPRISES DE PRESSE DE..., BABACAR BITEYE",
                                style: fontFammilyDii(context, 12, blanc,
                                    FontWeight.bold, FontStyle.normal),
                              ),
                            ),
                            paddingHorizontalGlobal(4),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
