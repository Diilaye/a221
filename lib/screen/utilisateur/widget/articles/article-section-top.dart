import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';

class ArticleSectionTopWidget extends StatelessWidget {
  const ArticleSectionTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 6,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/imagea3.jpeg"),
                      fit: BoxFit.cover)),
            ),
            Container(
              color: noir.withOpacity(.3),
            ),
            Positioned(
              bottom: 45,
              left: 4,
              child: SizedBox(
                // height: 100,
                width: 300,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 25,
                          color: rouge,
                          child: Row(
                            children: [
                              paddingHorizontalGlobal(8),
                              Text(
                                'à la une'.toUpperCase(),
                                style: fontFammilyDii(context, 12, blanc,
                                    FontWeight.bold, FontStyle.normal),
                              ),
                              paddingHorizontalGlobal(8),
                            ],
                          ),
                        ),
                      ],
                    ),
                    paddingVerticalGlobal(8),
                    SizedBox(
                      height: 80,
                      child: Row(
                        children: [
                          paddingHorizontalGlobal(15),
                          Expanded(
                            child: Center(
                              child: Text(
                                "C'EST CE QUE SONKO DEVRAIT FAIRE D'ABORD AVANT DE DEMANDER AUX ENTREPRISES DE PRESSE DE..., BABACAR BITEYE",
                                textAlign: TextAlign.center,
                                style: fontFammilyDii(context, 14, blanc,
                                    FontWeight.bold, FontStyle.normal),
                              ),
                            ),
                          ),
                          paddingHorizontalGlobal(15),
                        ],
                      ),
                    ),
                    paddingVerticalGlobal(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Mardi 28 mai 2024 . by samsedine',
                            style: fontFammilyDii(context, 10, blanc,
                                FontWeight.w300, FontStyle.normal)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
