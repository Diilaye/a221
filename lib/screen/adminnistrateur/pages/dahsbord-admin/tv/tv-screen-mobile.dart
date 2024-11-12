import 'package:actu/bloc/administrateur/emission-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/tv/add-emission-mobile.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/tv/add-emission.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/tv/update-emission-mobile.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/tv/update-emission.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:actu/utils/requette-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvScreenMobile extends StatelessWidget {
  const TvScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final emissionBloc = Provider.of<EmissionBloc>(context);

    return Stack(
      children: [
        ListView(
          children: [
            paddingVerticalGlobal(size.height * .02),
            Row(
              children: [
                paddingHorizontalGlobal(),
                Text(
                  'Emission'.toUpperCase(),
                  style: fontFammilyDii(
                      context, 14, noir, FontWeight.bold, FontStyle.normal),
                )
              ],
            ),
            paddingVerticalGlobal(size.height * .02),
            Row(
              children: [
                paddingHorizontalGlobal(),
                Icon(
                  CupertinoIcons.home,
                  color: noir.withOpacity(.6),
                  size: 12,
                ),
                paddingHorizontalGlobal(6),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: noir.withOpacity(.6),
                  size: 10,
                ),
                paddingHorizontalGlobal(6),
                Text(
                  'Emission',
                  style: fontFammilyDii(context, 10, noir.withOpacity(.6),
                      FontWeight.w300, FontStyle.normal),
                ),
                paddingHorizontalGlobal(6),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: noir.withOpacity(.6),
                  size: 12,
                ),
                paddingHorizontalGlobal(6),
                Text(
                  'Dashbord',
                  style: fontFammilyDii(
                      context, 8, noir, FontWeight.w300, FontStyle.normal),
                ),
              ],
            ),
            paddingVerticalGlobal(),
            Row(
              children: [
                paddingHorizontalGlobal(),
                Text(
                  'Show',
                  style: fontFammilyDii(context, 10, noir.withOpacity(.6),
                      FontWeight.w300, FontStyle.normal),
                ),
                paddingHorizontalGlobal(8),
                // Card(
                //   elevation: 2,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(4),
                //   ),
                //   child: SizedBox(
                //     height: 30,
                //     child: Row(
                //       children: [
                //         paddingHorizontalGlobal(8),
                //         DropdownButton(
                //             items: ['10', '15', '20', '25', '50']
                //                 .map((e) =>
                //                     DropdownMenuItem(value: e, child: Text(e)))
                //                 .toList(),
                //             value: '10',
                //             iconSize: 0.0,
                //             elevation: 1,
                //             focusColor: Colors.transparent,
                //             underline: const SizedBox(),
                //             padding: const EdgeInsets.all(0),
                //             onChanged: (v) {}),
                //         paddingHorizontalGlobal(8),
                //       ],
                //     ),
                //   ),
                // ),
                paddingHorizontalGlobal(),
                // Card(
                //   elevation: 2,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(4),
                //   ),
                //   child: SizedBox(
                //     height: 30,
                //     child: Row(
                //       children: [
                //         paddingHorizontalGlobal(8),
                //         DropdownButton(
                //             items: ['Tous les status', '15', '20', '25', '50']
                //                 .map((e) =>
                //                     DropdownMenuItem(value: e, child: Text(e)))
                //                 .toList(),
                //             value: 'Tous les status',
                //             iconSize: 0.0,
                //             elevation: 1,
                //             focusColor: Colors.transparent,
                //             underline: const SizedBox(),
                //             padding: const EdgeInsets.all(0),
                //             onChanged: (v) {}),
                //         paddingHorizontalGlobal(8),
                //       ],
                //     ),
                //   ),
                // ),
                const Spacer(),

                paddingHorizontalGlobal(),
                GestureDetector(
                  onTap: () => menuAdminBloc.setEmission(1),
                  child: CircleAvatar(
                      backgroundColor: bleuMarine,
                      radius: 12,
                      child: Icon(
                        CupertinoIcons.add,
                        color: blanc,
                        size: 12,
                      )),
                ),
                paddingHorizontalGlobal(),
              ],
            ),
            paddingVerticalGlobal(),
            Center(
              child: SizedBox(
                height: 45,
                width: size.width,
                child: Row(
                  children: [
                    paddingHorizontalGlobal(8),
                    Expanded(
                      child: TextField(
                        // controller: connectionBloc.email,
                        decoration: InputDecoration(
                          hintText: "RECHERCHER UNe émission".toUpperCase(),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    paddingHorizontalGlobal(8),
                  ],
                ),
              ),
            ),
            paddingVerticalGlobal(),
            SizedBox(
                height: 700,
                width: size.width,
                child: GridView.count(
                    crossAxisCount: 1,
                    padding: EdgeInsets.all(2),
                    children: emissionBloc.emissions
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Card(
                                elevation: 2,
                                child: Column(
                                  children: [
                                    paddingVerticalGlobal(2),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          paddingHorizontalGlobal(6),
                                          Expanded(
                                            child: Image.network(
                                              BASE_URL_ASSET +
                                                  e.photoCouverture!.url!,
                                              height: 2000,
                                              width: 2000,
                                            ),
                                          ),
                                          paddingHorizontalGlobal(6),
                                        ],
                                      ),
                                    ),
                                    paddingVerticalGlobal(4),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              paddingHorizontalGlobal(6),
                                              Expanded(
                                                child: Text(
                                                  e.titre!.toUpperCase(),
                                                  overflow: TextOverflow.clip,
                                                  style: fontFammilyDii(
                                                      context,
                                                      18,
                                                      rouge,
                                                      FontWeight.bold,
                                                      FontStyle.normal),
                                                ),
                                              ),
                                              paddingHorizontalGlobal(6),
                                            ],
                                          ),
                                          paddingVerticalGlobal(4),
                                          Row(
                                            children: [
                                              paddingHorizontalGlobal(6),
                                              Expanded(
                                                child: Text(
                                                  e.date!
                                                      .split("T")[0]
                                                      .split("-")
                                                      .reversed
                                                      .join('/'),
                                                  overflow: TextOverflow.clip,
                                                  style: fontFammilyDii(
                                                      context,
                                                      12,
                                                      noir,
                                                      FontWeight.w300,
                                                      FontStyle.normal),
                                                ),
                                              ),
                                              const Spacer(),
                                              Icon(
                                                CupertinoIcons.square_fill,
                                                color: e.type! == "invite"
                                                    ? vert
                                                    : rouge,
                                                size: 12,
                                              ),
                                              paddingHorizontalGlobal(4),
                                              Text(
                                                e.type! == "invite"
                                                    ? 'Invité'
                                                    : 'à suivre',
                                                overflow: TextOverflow.clip,
                                                style: fontFammilyDii(
                                                    context,
                                                    12,
                                                    noir,
                                                    FontWeight.w800,
                                                    FontStyle.normal),
                                              ),
                                              paddingHorizontalGlobal(6),
                                            ],
                                          ),
                                          paddingVerticalGlobal(4),
                                          Row(
                                            children: [
                                              paddingHorizontalGlobal(6),
                                              Icon(
                                                CupertinoIcons.square_fill,
                                                color: e.statusOnline! == "on"
                                                    ? vert
                                                    : rouge,
                                                size: 12,
                                              ),
                                              paddingHorizontalGlobal(4),
                                              Text(
                                                e.statusOnline! == "on"
                                                    ? 'En ligne'
                                                    : 'Broullions',
                                                overflow: TextOverflow.clip,
                                                style: fontFammilyDii(
                                                    context,
                                                    12,
                                                    noir,
                                                    FontWeight.w800,
                                                    FontStyle.normal),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                  onPressed: () {
                                                    emissionBloc.setEmission(e);
                                                    emissionBloc
                                                        .setShowUpdate(1);
                                                  },
                                                  tooltip: "Modifier posts",
                                                  icon: const Icon(
                                                      CupertinoIcons.pen)),
                                              paddingHorizontalGlobal(6),
                                              IconButton(
                                                  onPressed: () async =>
                                                      dialogRequest(
                                                              title:
                                                                  'Vous êtes sur de vouloir suprimer ce posts',
                                                              context: context)
                                                          .then((value) async {
                                                        if (value) {
                                                          emissionBloc
                                                              .setEmission(e);
                                                          emissionBloc
                                                              .activeEmission();
                                                        }
                                                      }),
                                                  tooltip:
                                                      e.statusOnline! == "on"
                                                          ? "Suprimer posts"
                                                          : "Réintégrer posts",
                                                  icon: Icon(e.statusOnline! ==
                                                          "on"
                                                      ? CupertinoIcons.delete
                                                      : Icons.publish)),
                                              paddingHorizontalGlobal(8),
                                              paddingHorizontalGlobal(6),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList())),
            paddingVerticalGlobal(),
            Row(
              children: [
                paddingHorizontalGlobal(8),
                Text(
                  "Affichage de 1 à 10 sur 50 émissions",
                  style: fontFammilyDii(context, 10, noir.withOpacity(.7),
                      FontWeight.w700, FontStyle.normal),
                ),
                const Spacer(),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Center(
                          child: Icon(
                        CupertinoIcons.chevron_left,
                        size: 12,
                        color: noir,
                      ))),
                ),
                paddingHorizontalGlobal(8),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Center(
                          child: Icon(
                        CupertinoIcons.chevron_right,
                        size: 12,
                        color: noir,
                      ))),
                ),
                paddingHorizontalGlobal(),
              ],
            )
          ],
        ),
        if (menuAdminBloc.addEmission == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: const AddEmissionScreenMobile(),
              )),
        if (emissionBloc.showUpdate == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: const UpdateEmissionScreenMobile(),
              )),
      ],
    );
  }
}
