import 'package:actu/bloc/utilisateur/home-bloc.dart';
import 'package:actu/models/administrateur/categorie-model.dart';
import 'package:actu/models/utilisateur/categorie-menu-model.dart';
import 'package:actu/utils/color-by-dii.dart';
import 'package:actu/utils/widgets/font-fammily-dii.dart';
import 'package:actu/utils/widgets/padding-global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MenuMobileItem extends StatefulWidget {
  final CategorieModel categorie;
  const MenuMobileItem({super.key, required this.categorie});

  @override
  State<MenuMobileItem> createState() => _MenuMobileItemState();
}

class _MenuMobileItemState extends State<MenuMobileItem> {
  List<Widget> getAllSousCategorie(List<SousRubrique>? sousRubrique) {
    List<Widget> liste = [];

    for (var i = 0; i < sousRubrique!.length; i = i + 2) {
      print(" sousRubrique!.length;");
      print(i);
      liste.add(Container(
        height: 45,
        child: Row(
          children: [
            Expanded(
                child: Row(
              children: [
                paddingHorizontalGlobal(),
                Text(sousRubrique[i].titre!),
              ],
            )),
            (i + 1) < sousRubrique.length
                ? Expanded(
                    child: Row(
                    children: [
                      Text(sousRubrique[i + 1].titre!),
                    ],
                  ))
                : Expanded(child: SizedBox()),
          ],
        ),
      ));
    }
    return liste;
  }

  @override
  Widget build(BuildContext context) {
    final homeUtilisateurBloc = Provider.of<HomeUtilisateurBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          homeUtilisateurBloc.setHoverMenuClick(0, widget.categorie);
          homeUtilisateurBloc.setTitlerubrique(widget.categorie.titre!);
          context.go(
              '/categorie/${widget.categorie.slug!.toLowerCase().replaceAll("é", "e")}');
        },
        child: homeUtilisateurBloc.hoverMenuClick ==
                homeUtilisateurBloc.categories.indexOf(widget.categorie)
            ? Container(
                color: homeUtilisateurBloc.hoverMenuClick ==
                        homeUtilisateurBloc.categories.indexOf(widget.categorie)
                    ? gris
                    : blanc,
                child: Column(
                  children: [
                    paddingVerticalGlobal(),
                    Row(
                      children: [
                        paddingHorizontalGlobal(size.width * .05),
                        Text(
                          widget.categorie.titre!,
                          style: fontFammilyDii(context, 14, noir,
                              FontWeight.bold, FontStyle.normal),
                        ),
                        // const Spacer(),
                        // Icon(
                        //   CupertinoIcons.chevron_down,
                        //   size: 14,
                        //   color: noir,
                        // ),
                        // paddingHorizontalGlobal(size.width * .05),
                      ],
                    ),
                    paddingVerticalGlobal(8),
                    Container(
                      height: 1,
                      color: gris,
                    ),
                    paddingVerticalGlobal(8),
                    // homeUtilisateurBloc.categorieMenuModel == null
                    //     ? SizedBox()
                    //     : Column(
                    //         children: getAllSousCategorie(homeUtilisateurBloc
                    //             .categorieMenuModel!.sousRubrique),
                    //       ),
                    paddingVerticalGlobal(),
                  ],
                ),
              )
            : Container(
                height: 50,
                color: blanc,
                child: Row(
                  children: [
                    paddingHorizontalGlobal(size.width * .05),
                    Text(
                      widget.categorie.titre!,
                      style: fontFammilyDii(
                          context, 14, noir, FontWeight.bold, FontStyle.normal),
                    ),
                    // const Spacer(),
                    // Icon(
                    //   CupertinoIcons.chevron_down,
                    //   size: 14,
                    //   color: noir,
                    // ),
                    // paddingHorizontalGlobal(size.width * .05),
                  ],
                ),
              ),
      ),
    );
  }
}
