import 'package:actu/bloc/administrateur/categorie-bloc.dart';
import 'package:actu/bloc/administrateur/menu-admin.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/categories/add-categorie-screen.dart';
import 'package:actu/screen/adminnistrateur/pages/dahsbord-admin/params/categories/update-categorie-screen.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/diallog-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorieScreen extends StatelessWidget {
  const CategorieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final menuAdminBloc = Provider.of<MenuAdminBloc>(context);
    final categorieBloc = Provider.of<CategorieBloc>(context);

    return Stack(
      children: [
        ListView(
          children: [
            paddingVerticalGlobal(),
            Row(
              children: [
                paddingHorizontalGlobal(),
                Text(
                  'Catégories'.toUpperCase(),
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
                    width: size.width * .3,
                    child: Row(
                      children: [
                        paddingHorizontalGlobal(8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText:
                                  "RECHERCHER UNe categorie".toUpperCase(),
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(),
                            ),
                            onChanged: (value) =>
                                categorieBloc.setRecherche(value),
                          ),
                        ),
                        paddingHorizontalGlobal(8),
                      ],
                    ),
                  ),
                ),
                paddingHorizontalGlobal(),
                GestureDetector(
                  onTap: () => menuAdminBloc.setCategorie(1),
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
                            flex: 2,
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
                            children: categorieBloc.categories
                                .where((e) {
                                  if (categorieBloc.recherche == "") {
                                    return true;
                                  } else {
                                    return e.titre!.toLowerCase().contains(
                                        categorieBloc.recherche.toLowerCase());
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
                                              "#${e.id!.substring(0, 8)}",
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
                                              flex: 2,
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Center(
                                                          child: Text(
                                                        e.titre!,
                                                        style: fontFammilyDii(
                                                            context,
                                                            14,
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
                                                    categorieBloc
                                                        .setShowUpdate(1);
                                                    categorieBloc
                                                        .setCategorie(e);
                                                  },
                                                  tooltip:
                                                      "Modifier la catégorie",
                                                  icon:
                                                      Icon(CupertinoIcons.pen)),
                                              paddingHorizontalGlobal(6),
                                              IconButton(
                                                  onPressed: () async =>
                                                      dialogRequest(
                                                              title:
                                                                  'Vous êtes sur de vouloir suprimer cette categorie',
                                                              context: context)
                                                          .then((value) async {
                                                        if (value) {
                                                          categorieBloc
                                                              .setCategorie(e);
                                                          categorieBloc
                                                              .activeCategorie();
                                                        }
                                                      }),
                                                  tooltip: e.statusOnline! ==
                                                          "on"
                                                      ? "Suprimer  categorie"
                                                      : "Réintégrer catégorie",
                                                  icon: Icon(e.statusOnline! ==
                                                          "on"
                                                      ? CupertinoIcons.delete
                                                      : Icons.publish)),
                                            ],
                                          )),
                                          paddingHorizontalGlobal(8),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
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
                  "Affichage de 1 à 10 sur ${categorieBloc.categories.length} categories",
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
        if (menuAdminBloc.addCategorie == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width * .64,
                height: size.height,
                child: const AddCategorieScreen(),
              )),
        if (categorieBloc.showUpdate == 1)
          Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                width: size.width * .64,
                height: size.height,
                child: const UpdateCategorieScreen(),
              )),
      ],
    );
  }
}
