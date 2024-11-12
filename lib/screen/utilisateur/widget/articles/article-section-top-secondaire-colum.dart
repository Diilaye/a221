import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';

class ArticleSectionTopSecondaireColumWidget extends StatelessWidget {
  final Color color;
  const ArticleSectionTopSecondaireColumWidget(
      {super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/imagea3.jpeg"),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Row(
                  children: [
                    Container(
                      height: 25,
                      color: color,
                      child: Row(
                        children: [
                          paddingHorizontalGlobal(8),
                          Text(
                            'santé'.toUpperCase(),
                            style: fontFammilyDii(context, 8, blanc,
                                FontWeight.bold, FontStyle.normal),
                          ),
                          paddingHorizontalGlobal(8),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              paddingVerticalGlobal(4),
              Text(
                "C'EST CE QUE SONKO DEVRAIT FAIRE D'ABORD AVANT DE DEMANDER AUX ENTREPRISES DE PRESSE DE..., BABACAR BITEYE",
                overflow: TextOverflow.clip,
                style: fontFammilyDii(
                    context, 12, noir, FontWeight.bold, FontStyle.normal),
              ),
              paddingVerticalGlobal(4),
              Text(
                "C'EST CE QUE SONKO DEVRAIT FAIRE D'ABORD AVANT DE DEMANDER AUX ENTREPRISES DE PRESSE DE..., BABACAR BITEYE C'EST CE QUE SONKO DEVRAIT FAIRE D'ABORD AVANT DE DEMANDER AUX ENTREPRISES DE PRESSE DE...",
                overflow: TextOverflow.clip,
                style: fontFammilyDii(
                    context, 10, noir, FontWeight.w400, FontStyle.normal),
              ),
              paddingVerticalGlobal(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 25,
                    color: color,
                    child: Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Text(
                          'lire la suite'.toUpperCase(),
                          style: fontFammilyDii(context, 12, blanc,
                              FontWeight.w400, FontStyle.normal),
                        ),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
