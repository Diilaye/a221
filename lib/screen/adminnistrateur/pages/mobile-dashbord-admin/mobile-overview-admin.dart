import 'package:actu/screen/adminnistrateur/widgets/dashbord/activity-emission.dart';
import 'package:actu/screen/adminnistrateur/widgets/dashbord/statistoque-card.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileOverViewAdmin extends StatelessWidget {
  const MobileOverViewAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView(
      children: [
        paddingVerticalGlobal(8),
        SizedBox(
          height: 500,
          child: Column(
            children: [
              paddingVerticalGlobal(8),
              Expanded(
                child: StatCard(
                  title: "Visites",
                  total: 4000,
                  percentage: 50,
                  desc: "Nombre de visites journaliere",
                  label: "Nouvelles Visites",
                  increase: 7,
                  color: bleuMarine,
                ),
              ),
              paddingHorizontalGlobal(8),
              Expanded(
                child: StatCard(
                  title: "Journal Papier",
                  total: 30,
                  percentage: 75,
                  desc: "Nombre de lecture journaliere",
                  label: "Lecteur en moins",
                  increase: -17,
                  color: rouge,
                ),
              ),
              paddingHorizontalGlobal(8),
              Expanded(
                child: StatCard(
                  title: "Posts digitaux",
                  total: 300,
                  percentage: 90,
                  desc: "Nombre de réaction journaliere sur les pots",
                  label: "Nouvelles internautes",
                  increase: 20,
                  color: vertSport,
                ),
              ),
              paddingHorizontalGlobal(8),
            ],
          ),
        ),
        paddingVerticalGlobal(),
        SizedBox(
          height: 900,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Activité de lecture journal papier',
                              style: fontFammilyDii(context, 14, noir,
                                  FontWeight.bold, FontStyle.normal),
                            ),
                            const Spacer(),
                            Text(
                              '12 derniers mois',
                              style: fontFammilyDii(context, 10, noir,
                                  FontWeight.w300, FontStyle.normal),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                            child: Row(
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            const Expanded(
                                child: Column(
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Expanded(
                                    child: Text('+ M ',
                                        style: TextStyle(fontSize: 10))),
                                Expanded(
                                    child: Text('8 M ',
                                        style: TextStyle(fontSize: 10))),
                                Expanded(
                                    child: Text('6 M ',
                                        style: TextStyle(fontSize: 10))),
                                Expanded(
                                    child: Text('4 M ',
                                        style: TextStyle(fontSize: 10))),
                                Expanded(
                                    child: Text('2 M ',
                                        style: TextStyle(fontSize: 10))),
                                Expanded(
                                    child: Text('0 M ',
                                        style: TextStyle(fontSize: 10))),
                              ],
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Column(
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          color: noir.withOpacity(.5)),
                                    )),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  'Jan',
                                  style: TextStyle(fontSize: 10),
                                ),
                                const SizedBox(
                                  height: 4,
                                )
                              ],
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            color: noir.withOpacity(.5)),
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text('Fev',
                                      style: TextStyle(fontSize: 10)),
                                  const SizedBox(
                                    height: 4,
                                  )
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            color: noir.withOpacity(.5)),
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text('Mar',
                                      style: TextStyle(fontSize: 10)),
                                  const SizedBox(
                                    height: 4,
                                  )
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            color: noir.withOpacity(.5)),
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text('Avr',
                                      style: TextStyle(fontSize: 10)),
                                  const SizedBox(
                                    height: 4,
                                  )
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            color: noir.withOpacity(.5)),
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text('Mai',
                                      style: TextStyle(fontSize: 10)),
                                  const SizedBox(
                                    height: 4,
                                  )
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            color: noir.withOpacity(.5)),
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text('Jui',
                                      style: TextStyle(fontSize: 10)),
                                  const SizedBox(
                                    height: 4,
                                  )
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            color: noir.withOpacity(.5)),
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text('Jul',
                                      style: TextStyle(fontSize: 10)),
                                  const SizedBox(
                                    height: 4,
                                  )
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            color: noir.withOpacity(.5)),
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text('Aou',
                                      style: TextStyle(fontSize: 10)),
                                  const SizedBox(
                                    height: 4,
                                  )
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            color: noir.withOpacity(.5)),
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text('Sep',
                                      style: TextStyle(fontSize: 10)),
                                  const SizedBox(
                                    height: 4,
                                  )
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            color: noir.withOpacity(.5)),
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text('Oct',
                                      style: TextStyle(fontSize: 10)),
                                  const SizedBox(
                                    height: 4,
                                  )
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            color: noir.withOpacity(.5)),
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text('Nov',
                                      style: TextStyle(fontSize: 10)),
                                  const SizedBox(
                                    height: 4,
                                  )
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            color: noir.withOpacity(.5)),
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text('Dec',
                                      style: TextStyle(fontSize: 10)),
                                  const SizedBox(
                                    height: 4,
                                  )
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                          ],
                        )),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: ActivyEmission(
                        title: "${"é".toUpperCase()}mission suivis",
                        pourcentages: [55, 60, 80],
                        labels: const ["Complete", "In progess", "Taches"],
                        colors: [rouge, vertSport, bleuMarine],
                        // legendes: const ["Complete", "In progess", "Taches"],
                      )),
                ],
              )),
            ],
          ),
        ),
        paddingVerticalGlobal(),
      ],
    );
  }
}
