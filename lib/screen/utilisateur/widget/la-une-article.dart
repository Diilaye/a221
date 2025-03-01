import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:actu/utils/widgets/triangle-end.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class LaUneArticle extends StatelessWidget {
  final String rubrique, date, titre;
  final Color color;
  final bool isActif;
  final int i;
  const LaUneArticle(
      {super.key,
      required this.rubrique,
      required this.date,
      required this.titre,
      required this.color,
      required this.isActif,
      required this.i});

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 85,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                homeUtilisateurBloc.setTopClick(i);
                homeUtilisateurBloc.setAticle(homeUtilisateurBloc.uneArticle!);

                // context.go('/article/${homeUtilisateurBloc.uneArticle!.slug!}');
              },
              child: Container(
                decoration: BoxDecoration(color: blanc, boxShadow: [
                  BoxShadow(
                      blurRadius: isActif ? 10 : .3, color: noir.withOpacity(.3))
                ]),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              RotatedBox(
                                quarterTurns: -3,
                                child: CustomPaint(
                                  size: const Size(10, 10),
                                  painter: TrianglePainter(color: color),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              paddingHorizontalGlobal(),
                              SizedBox(
                                height: 15,
                                child: Center(
                                  child: Text(
                                    rubrique.toUpperCase(),
                                    style: fontFammilyDii(context, 10, rouge,
                                        FontWeight.bold, FontStyle.normal),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                date,
                                style: fontFammilyDii(context, 10, noir,
                                    FontWeight.w300, FontStyle.normal),
                              ),
                              paddingHorizontalGlobal(),
                            ],
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  titre.toUpperCase(),
                                  overflow: TextOverflow.clip,
                                  style: fontFammilyDii(
                                      context,
                                      12,
                                      noir,
                                      FontWeight.w600,
                                      FontStyle.normal),
                                ),
                              ))
                        ],
                      ),
                    ),
                    if (isActif)
                      Container(
                        width: 5,
                        color: color,
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
        paddingVerticalGlobal(8),
      ],
    );
  }
}
