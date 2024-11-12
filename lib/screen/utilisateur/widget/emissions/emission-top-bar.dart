import 'package:actu/models/administrateur/emission-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/material.dart';

class EmissionTopBarWidget extends StatelessWidget {
  final EmissionModel emissionModel;
  const EmissionTopBarWidget({super.key, required this.emissionModel});

  @override
  Widget build(BuildContext context) {
    return emissionModel.type == "suivre"
        ? Expanded(
            child: Container(
            decoration: BoxDecoration(color: blanc, boxShadow: [
              BoxShadow(blurRadius: 3, color: noir.withOpacity(.2))
            ]),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(BASE_URL_ASSET +
                                      emissionModel.photoCouverture!.url!),
                                  fit: BoxFit.scaleDown)),
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              color: rouge,
                              width: 50,
                              height: 18,
                              child: RotatedBox(
                                quarterTurns: -4,
                                child: Center(
                                  child: Text(
                                    "direct".toUpperCase(),
                                    style: fontFammilyDii(context, 10, blanc,
                                        FontWeight.bold, FontStyle.normal),
                                  ),
                                ),
                              ),
                            )),
                        Positioned(
                            top: 0,
                            left: 0,
                            bottom: 0,
                            child: Container(
                              color: noir.withOpacity(1),
                              width: 20,
                              child: RotatedBox(
                                quarterTurns: -1,
                                child: Center(
                                  child: Text(
                                    "à suivre".toUpperCase(),
                                    style: fontFammilyDii(context, 10, blanc,
                                        FontWeight.bold, FontStyle.normal),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    )),
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Expanded(
                            child: Container(
                          color: noir,
                          child: Row(
                            children: [
                              Container(
                                color: noir,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      emissionModel.heure!,
                                      style: fontFammilyDii(context, 12, blanc,
                                          FontWeight.bold, FontStyle.normal),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                color: rouge,
                                child: Center(
                                  child: Text(
                                    emissionModel.titre!,
                                    style: fontFammilyDii(context, 13, blanc,
                                        FontWeight.bold, FontStyle.normal),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        )),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              paddingVerticalGlobal(4),
                              Expanded(
                                child: Row(
                                  children: [
                                    paddingHorizontalGlobal(4),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          emissionModel.description!
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: fontFammilyDii(
                                              context,
                                              10.5,
                                              noir,
                                              FontWeight.w700,
                                              FontStyle.normal),
                                        ),
                                      ),
                                    ),
                                    paddingHorizontalGlobal(4),
                                  ],
                                ),
                              ),
                              paddingVerticalGlobal(4),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ))
        : Expanded(
            child: Container(
            decoration: BoxDecoration(color: blanc, boxShadow: [
              BoxShadow(blurRadius: 10, color: noir.withOpacity(1))
            ]),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Expanded(
                            child: Container(
                          color: noir,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                color: rouge,
                                child: Center(
                                  child: Text(
                                    emissionModel.titre!.toUpperCase(),
                                    style: fontFammilyDii(context, 13, blanc,
                                        FontWeight.bold, FontStyle.normal),
                                  ),
                                ),
                              )),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    emissionModel.heure!,
                                    style: fontFammilyDii(context, 12, blanc,
                                        FontWeight.bold, FontStyle.normal),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              paddingVerticalGlobal(4),
                              Expanded(
                                child: Row(
                                  children: [
                                    paddingHorizontalGlobal(4),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          emissionModel.description!
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: fontFammilyDii(
                                              context,
                                              10.5,
                                              noir,
                                              FontWeight.w700,
                                              FontStyle.normal),
                                        ),
                                      ),
                                    ),
                                    paddingHorizontalGlobal(4),
                                  ],
                                ),
                              ),
                              paddingVerticalGlobal(4),
                            ],
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(BASE_URL_ASSET +
                                      emissionModel.photoCouverture!.url!),
                                  fit: BoxFit.scaleDown)),
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              color: rouge,
                              width: 20,
                              child: RotatedBox(
                                quarterTurns: -3,
                                child: Center(
                                  child: Text(
                                    "L'invité".toUpperCase(),
                                    style: fontFammilyDii(context, 10, blanc,
                                        FontWeight.bold, FontStyle.normal),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    )),
              ],
            ),
          ));
  }
}
