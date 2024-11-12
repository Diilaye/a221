import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/bloc/administrateur/sous-categorie-bloc.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/sous-categorie/add-sous-categorie-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/sous-categorie/update-sous-categorie-screen.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SousCategorieScreen extends StatelessWidget {
  const SousCategorieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final sousCategorieBloc = Provider.of<SousCategorieBloc>(context);

    return Stack(
      children: [
        ListView(
          children: [
            paddingVerticalGlobal(),
            Row(
              children: [
                paddingHorizontalGlobal(),
                Text(
                  'Sous Catégories'.toUpperCase(),
                  style: fontFammilyDii(
                      context, 20, noir, FontWeight.bold, FontStyle.normal),
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
                  size: 14,
                ),
                paddingHorizontalGlobal(6),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: noir.withOpacity(.6),
                  size: 12,
                ),
                paddingHorizontalGlobal(6),
                Text(
                  'Catégorie',
                  style: fontFammilyDii(context, 14, noir.withOpacity(.6),
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
                      context, 12, noir, FontWeight.w300, FontStyle.normal),
                ),
                paddingHorizontalGlobal(),
                const Spacer(),
                Center(
                  child: SizedBox(
                    height: 45,
                    width: size.width * .2,
                    child: Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText:
                                  "RECHERCHER UNe sous categorie".toUpperCase(),
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(),
                            ),
                            onChanged: (value) =>
                                sousCategorieBloc.setRecherche(value),
                          ),
                        ),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                  ),
                ),
                paddingHorizontalGlobal(),
                GestureDetector(
                  onTap: () => menuAdminBloc.setSousCategorie(1),
                  child: CircleAvatar(
                      backgroundColor: bleuMarine,
                      child: Icon(
                        CupertinoIcons.add,
                        color: blanc,
                      )),
                ),
                paddingHorizontalGlobal(),
              ],
            ),
            paddingVerticalGlobal(),
            SizedBox(
              height: 700,
              width: size.width,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    paddingVerticalGlobal(8),
                    Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Expanded(
                            child: Row(children: [
                          Text(
                            'ID',
                            style: fontFammilyDii(context, 14, noir,
                                FontWeight.w500, FontStyle.normal),
                          )
                        ])),
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              'Date',
                              style: fontFammilyDii(context, 14, noir,
                                  FontWeight.w500, FontStyle.normal),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            Row(
                              children: [
                                Center(
                                    child: Text(
                                  'Catégorie',
                                  style: fontFammilyDii(context, 14, noir,
                                      FontWeight.w500, FontStyle.normal),
                                )),
                              ],
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            Row(
                              children: [
                                Center(
                                    child: Text(
                                  'Sous Catégorie',
                                  style: fontFammilyDii(context, 14, noir,
                                      FontWeight.w500, FontStyle.normal),
                                )),
                              ],
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              'Status',
                              style: fontFammilyDii(context, 14, noir,
                                  FontWeight.w500, FontStyle.normal),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              '...',
                              style: fontFammilyDii(context, 14, noir,
                                  FontWeight.w500, FontStyle.normal),
                            ),
                          ],
                        )),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                    paddingVerticalGlobal(8),
                    Expanded(
                        child: Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Expanded(
                          child: ListView(
                              children: sousCategorieBloc.sous_categories
                                  .where((e) {
                                    if (sousCategorieBloc.recherche == "") {
                                      return true;
                                    } else {
                                      return e.titre!.toLowerCase().contains(
                                          sousCategorieBloc.recherche
                                              .toLowerCase());
                                    }
                                  })
                                  .map((e) => Container(
                                        height: 50,
                                        color: blanc,
                                        child: Row(
                                          children: [
                                            paddingHorizontalGlobal(8),
                                            Expanded(
                                                child: Row(children: [
                                              Text(
                                                "#${e.id!.substring(0, 7)}",
                                                style: fontFammilyDii(
                                                    context,
                                                    14,
                                                    noir,
                                                    FontWeight.w500,
                                                    FontStyle.normal),
                                              )
                                            ])),
                                            Expanded(
                                                child: Row(
                                              children: [
                                                Text(
                                                  '${e.date!.split("T")[0].split("-").reversed.join('/')}',
                                                  style: fontFammilyDii(
                                                      context,
                                                      14,
                                                      noir,
                                                      FontWeight.w500,
                                                      FontStyle.normal),
                                                ),
                                              ],
                                            )),
                                            Expanded(
                                                child: Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      e.categorie!.titre!,
                                                      style: fontFammilyDii(
                                                          context,
                                                          12,
                                                          noir,
                                                          FontWeight.w500,
                                                          FontStyle.normal),
                                                    )),
                                                  ],
                                                ),
                                              ],
                                            )),
                                            Expanded(
                                                child: Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      e.titre!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: fontFammilyDii(
                                                          context,
                                                          12,
                                                          noir,
                                                          FontWeight.w500,
                                                          FontStyle.normal),
                                                    )),
                                                  ],
                                                ),
                                              ],
                                            )),
                                            Expanded(
                                                child: Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons.circle_fill,
                                                  size: 10,
                                                  color: e.statusOnline! == "on"
                                                      ? vertSport
                                                      : rouge,
                                                ),
                                                paddingHorizontalGlobal(4),
                                                Text(
                                                  e.statusOnline! == "on"
                                                      ? "En ligne"
                                                      : "Broullions",
                                                  style: fontFammilyDii(
                                                      context,
                                                      14,
                                                      noir,
                                                      FontWeight.w500,
                                                      FontStyle.normal),
                                                ),
                                              ],
                                            )),
                                            Expanded(
                                                child: Row(
                                              children: [
                                                paddingHorizontalGlobal(6),
                                                IconButton(
                                                    onPressed: () {
                                                      sousCategorieBloc
                                                          .setSousCategorie(e);
                                                      sousCategorieBloc
                                                          .setShowUpdate(1);
                                                    },
                                                    tooltip:
                                                        "Modifier sous catégorie",
                                                    icon: Icon(
                                                        CupertinoIcons.pen)),
                                                paddingHorizontalGlobal(6),
                                                IconButton(
                                                    onPressed: () async =>
                                                        dialogRequest(
                                                                title:
                                                                    'Vous êtes sur de vouloir suprimer cette sous categorie',
                                                                context:
                                                                    context)
                                                            .then(
                                                                (value) async {
                                                          if (value) {
                                                            sousCategorieBloc
                                                                .setSousCategorie(
                                                                    e);
                                                            sousCategorieBloc
                                                                .activeSousCategorie();
                                                          }
                                                        }),
                                                    tooltip: e.statusOnline! ==
                                                            "on"
                                                        ? "Suprimer sous categorie"
                                                        : "Réintégrer sous catégorie",
                                                    icon: Icon(
                                                        e.statusOnline! == "on"
                                                            ? CupertinoIcons
                                                                .delete
                                                            : Icons.publish)),
                                              ],
                                            )),
                                            paddingHorizontalGlobal(8),
                                          ],
                                        ),
                                      ))
                                  .toList()),
                        ),
                        paddingHorizontalGlobal(8)
                      ],
                    )),
                    paddingVerticalGlobal(8)
                  ],
                ),
              ),
            ),
            paddingVerticalGlobal(),
            Row(
              children: [
                paddingHorizontalGlobal(8),
                Text(
                  "Affichage de 1 à 10 sur ${sousCategorieBloc.sous_categories.length} sous categories",
                  style: fontFammilyDii(context, 14, noir.withOpacity(.7),
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
                      width: 50,
                      child: Center(
                          child: Icon(
                        CupertinoIcons.chevron_left,
                        size: 14,
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
                      width: 50,
                      child: Center(
                          child: Icon(
                        CupertinoIcons.chevron_right,
                        size: 14,
                        color: noir,
                      ))),
                ),
                paddingHorizontalGlobal(),
              ],
            )
          ],
        ),
        if (menuAdminBloc.addSouCategorie == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width * .64,
                height: size.height,
                child: const AddSousCategorieScreen(),
              )),
        if (sousCategorieBloc.showUpadte == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width * .64,
                height: size.height,
                child: const UpdateSousCategorieScreen(),
              )),
      ],
    );
  }
}
